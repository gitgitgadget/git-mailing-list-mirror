From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/9] t1508 (at-combinations): test branches separately
Date: Thu, 2 May 2013 12:30:37 -0500
Message-ID: <CAMP44s1wv4sCQM6V3S2+56KnxPJVQAp1skiUP+vSEetmenB_+A@mail.gmail.com>
References: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
	<1367501974-6879-3-git-send-email-artagnon@gmail.com>
	<CAMP44s3up_xo=oU+5EajoFo7VzA3RDK+hR-maxN9cUw7y=b3Eg@mail.gmail.com>
	<CALkWK0=_zcO8K75YxmQVp9hog0yHJ_vH5QKRwpWN8QMUc2zm_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 19:30:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXxLB-0000zy-JH
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 19:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759198Ab3EBRak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 13:30:40 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:35261 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757005Ab3EBRai (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 13:30:38 -0400
Received: by mail-la0-f42.google.com with SMTP id fq13so776402lab.1
        for <git@vger.kernel.org>; Thu, 02 May 2013 10:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ed1fP7ySK+LnsV/Io+xAA+O14QkNutrWdJ95mmPFhGo=;
        b=vhLPsYcH/IJODc2bJ19JYQrkxmMJSxdoHsTvw/lbDYQDBtlmdAL9s/oAmXXNAmiuEl
         pozj1w/v4A2tB2ep1Xhg4Gsa4IIC2PR/cQyQ1tNo0U4gZKyZDwayQfaVrOMtJSF6xAo2
         Bi5bWJY6sI+7T6XWFyLQqPL8bBBjjRMYK6jRwr4ewfpbAmDrxsM1lLgjv3u5xK9yEM4g
         Pj7IyRE/lLFZ8GNIdzqpnQQL9yzALV0nM+bWBY54qxVZ8qWX+lUFa3HDxAHM484/wQkD
         wnUx2+Zfcy0/+OPgEMJFAz9bnymASzUtAevD7ca+sOXXURgsH+Rg/+QBVsDmcWNopdv/
         D8Pg==
X-Received: by 10.152.87.69 with SMTP id v5mr2924946laz.24.1367515837136; Thu,
 02 May 2013 10:30:37 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 2 May 2013 10:30:37 -0700 (PDT)
In-Reply-To: <CALkWK0=_zcO8K75YxmQVp9hog0yHJ_vH5QKRwpWN8QMUc2zm_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223234>

On Thu, May 2, 2013 at 12:28 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> I'm not sure about this. If we introduce a check that fails, we would
>> have to do:
>>
>> check HEAD refs/heads/new-branch "" failure
>>
>> Which doesn't seem clean. Perhaps it makes more sense to always add
>> the type of check:
>>
>> check HEAD ref refs/heads/new-branch
>
> I think you misunderstood.  Failure looks like this:
>
>     check "@@{u}" ref refs/heads/upstream-branch failure
>
> And corresponding success like this:
>
>     check "@@{u}" refs/heads/upstream-branch
>
> We can make the "ref" compulsory if you like.  I thought about it too.

I think it's less surprising.

-- 
Felipe Contreras
