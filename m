From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/9] A natural solution to the @ -> HEAD problem
Date: Thu, 2 May 2013 12:25:40 -0500
Message-ID: <CAMP44s2M0A_ecfFfD_9hYQUvHSXMup6Whpn80rs741Lu1-ytcg@mail.gmail.com>
References: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
	<CALkWK0=osd8jQYfHcwO8=C_sMNgPj59Th=+tpfZfp7FeopMDyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 19:25:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXxGO-0004X8-CY
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 19:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293Ab3EBRZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 13:25:42 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:52936 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932213Ab3EBRZl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 13:25:41 -0400
Received: by mail-la0-f46.google.com with SMTP id fk20so754526lab.5
        for <git@vger.kernel.org>; Thu, 02 May 2013 10:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=XqkaXcEu4+D75Cc+86tfIz5em7qS+JaCWWktXsXcxV4=;
        b=OYtpHfq/0DR8m4CqPXo6mj48wM5q2Gs/1iUQBfHJ/kbMADrTr/Dpi+wZNADYbE2lbf
         fFwq8yDwSu4yAG33ikeeyEyELunPr8EzInnKWdxxh5mILbdaM/7WGskzz1IP+Z7X/vO2
         zbXKvBgpLaWN/zgYFWGBwRYWnhaAvimO0a+LLszyu2nynIDPlh6Lwzk4oAVPBF+YwObl
         MDFNaA1opq82k0UFOL1j5Z+Xlh6Zqv6CTv7rhIzvwGl1PTVVVtB/ztoFQfhryzlaVUF0
         8j4TYHCqCEZOvHpLAHQu9VMwfspZRIlxmpypmWfMCdH1qqe+tadTRlF+XEYNhS7nWc3I
         KTKw==
X-Received: by 10.112.135.70 with SMTP id pq6mr3082535lbb.82.1367515540468;
 Thu, 02 May 2013 10:25:40 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 2 May 2013 10:25:40 -0700 (PDT)
In-Reply-To: <CALkWK0=osd8jQYfHcwO8=C_sMNgPj59Th=+tpfZfp7FeopMDyg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223231>

On Thu, May 2, 2013 at 12:18 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Ramkumar Ramachandra wrote:
>> Felipe Contreras (3):
>>   t1508 (at-combinations): simplify setup
>>   t1508 (at-combinations): test branches separately
>>   t1508 (at-combinations): improve nonsense()
>>
>> Ramkumar Ramachandra (6):
>>   t1508 (at-combinations): increase coverage
>>   t1508 (at-combinations): document @{N} versus HEAD@{N}
>>   t1508 (at-combinations): test with symbolic refs
>
> Can we just okay these six now, and drop the rest?

I'm generally OK with them, but the one for 'symbolic refs' is relying
on a symbolic ref named '@', so it would immediately conflict with my
patch series.

-- 
Felipe Contreras
