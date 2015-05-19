From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pull: handle --log=<n>
Date: Tue, 19 May 2015 06:57:02 -0700
Message-ID: <CAPc5daVze4+8aLGPpZgxDnvKSwvQiaR=kRdwfAHXFYA7HChmMg@mail.gmail.com>
References: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
 <5661061272076a1883cfde1087be4a42@www.dscho.org> <xmqq617pda0r.fsf@gitster.dls.corp.google.com>
 <6b905c01c9b57abc05fb49117c28c10e@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 19 15:57:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yui1S-0007xJ-K6
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 15:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbbESN5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 09:57:25 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35856 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932392AbbESN5X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 09:57:23 -0400
Received: by obbkp3 with SMTP id kp3so12601253obb.3
        for <git@vger.kernel.org>; Tue, 19 May 2015 06:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=8UeUIpQ1ffi3RjoLw9nXjKo6MEejnXysVUrvN1OYwFc=;
        b=LhFo3JEptI94ynzK+gzOiS+YNVZaK/SvlgX2/orNCftrc5McL5QxKMOkLzgsW95hB5
         Bw3IiL1BmXHmA5yRq+XwC3WRUf2aKYLzr5HDNazMqy4KdkyVGl2f7HJMjd08S4Ndwozk
         P3KvlezAWGi6YNe4v50r0xWXIrNAx+U/j4BAsHSuBYD3G7LBdTWJdNJs8q/uMxE4K3eQ
         rYfco5dvHVElpluEgQmp+iYOt2mbP/As/bgG41nmB59K+Aim5ESBLryBS4DsWq9w3isR
         Nrotp2nFwgx+pIim3SMSYZ7wWwhkK+H7NPT6dWUq6k9uIlJe7O52/67QhV8w/NNELU1A
         QXfA==
X-Received: by 10.60.33.74 with SMTP id p10mr24523942oei.62.1432043842708;
 Tue, 19 May 2015 06:57:22 -0700 (PDT)
Received: by 10.202.197.18 with HTTP; Tue, 19 May 2015 06:57:02 -0700 (PDT)
In-Reply-To: <6b905c01c9b57abc05fb49117c28c10e@www.dscho.org>
X-Google-Sender-Auth: 6C47-XVZpTmLNqHiD4v5su8bUhw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269358>

On Tue, May 19, 2015 at 6:35 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
>
> On 2015-05-18 20:18, Junio C Hamano wrote:
>>
>> So I dunno.  I really wish test_commit didn't create tags and either
>> left the tagging to the calling script.
>
> Or maybe just add a --tag flag to `test_commit` and use that in all cases where the tags were actually needed. Yeah, I think I like that option best.

Thanks for inferring what I wanted to say but left unsaid due to my
stupidity and
lack of proofreading. I meant to follow "either left to the caller"
with "or with an
option" ;-)
