From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v8 5/5] help: respect new common command grouping
Date: Tue, 19 May 2015 12:35:58 -0400
Message-ID: <CAPig+cS15yzwbcdb-yLH5QiMoxa0utmaJaDDz=W9WfWd+PL37A@mail.gmail.com>
References: <1431976697-26288-1-git-send-email-sebastien.guimmara@gmail.com>
	<1431976697-26288-6-git-send-email-sebastien.guimmara@gmail.com>
	<xmqqr3qda7kx.fsf@gitster.dls.corp.google.com>
	<20150519004356.GA12854@flurp.local>
	<xmqq1tica6rk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 19 18:36:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YukUv-0003Ef-15
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 18:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155AbbESQgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 12:36:00 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34531 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756147AbbESQf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 12:35:58 -0400
Received: by ieczm2 with SMTP id zm2so18238303iec.1
        for <git@vger.kernel.org>; Tue, 19 May 2015 09:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=I/hOBbSE+CKzwuMleCAylgL9N3/hvIdc7Rkebuzl8do=;
        b=RFIADUbchoqdITa+pnwxI1w+aIy9Y/0iJvkmx9Mn6vxWGgSXx0hvUCBOQuGihtNIlY
         NguCKhtLWGf4mQxjmotRLizd0m/u+tveba/yDVxJNBb3Mo3pM/OBDB6ghAdXaBGnKxiB
         oQJYNIWECCgTTtz2Cx1UGt+7yLOqHo4zd38p4z5NuF/qJcCDT01Z9UleqCrq5rE1PUBw
         0hpbYfd+uH93wx0ejpoybG8LmG54fkolk27Lw/hEQkM0VhvaSOzW0Z8Ms7gO6WUb+7ij
         0HJ//p2X3fV4tDJdCW3FyqA6Q4SYtZNNEjWKrl+SjGJmykVAZ3SAR87EQyyWQoCmurFh
         /NRA==
X-Received: by 10.42.67.80 with SMTP id s16mr27012572ici.25.1432053358312;
 Tue, 19 May 2015 09:35:58 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 19 May 2015 09:35:58 -0700 (PDT)
In-Reply-To: <xmqq1tica6rk.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: YPzJULtbhaMAzp4ToLBciZhkhwY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269371>

On Tue, May 19, 2015 at 12:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> The awk script restricts itself to POSIX, and I did test it on Linux,
>> Mac OS X, and FreeBSD, so it seems pretty portable.
>
> I was worried more about some people only having gawk while others
> with mawk and yet others nawk, etc., without having one of them
> under the canonical name "awk".  It's nothing what
>
>     $ make AWK=mawk
>
> or its config.mak equivalent cannot fix, but still bothers me a bit.

In that case, perhaps we should go with the Perl version, which, given
that more people (these days) are familiar with Perl than awk, is less
likely to be a maintenance burden.
