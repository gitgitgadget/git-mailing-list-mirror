From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] rebase-am: fix regression with new cover-letter config
Date: Sun, 14 Apr 2013 21:31:26 -0500
Message-ID: <CAMP44s0GbocoBrONYdiN6f=qd58xbX0Y4neGSVRmCiLRr_f8Jw@mail.gmail.com>
References: <1365978424-11841-1-git-send-email-felipe.contreras@gmail.com>
	<7vhaj84l8m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 04:31:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URZCf-0007zB-3g
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 04:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567Ab3DOCb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 22:31:29 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:36553 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569Ab3DOCb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 22:31:28 -0400
Received: by mail-la0-f52.google.com with SMTP id ek20so2553386lab.25
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 19:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=23r8jznVgVsjKksOGefIT17u1F4rJBDbyN4iefjk3tI=;
        b=ITGXX7y4ntqQ1jranzf8LK8mgH90L6G3Knfj2iiaLVYXzfiPhKWa3dvrm2a8ghAHtG
         PihCt/17mQ/rnzB5Qasan6oJYJPPkDWOEotBxFHPvp/TXfiHpE8bsLZE97dohYmfCs/1
         ECc3kgfQ0RZTVh/ILttbXt7rvckkoWmMsDHqG2GdMBsi3IPPJ6Okv/kfRzW3U5MSYSxD
         Vfa6h3JgolRxG6HpWSs0mDa4ydxqFzy+8KLru6/P8CmAgMulHa0goVD8pKYLX8E103Jb
         4/4PrmGGsUN5uE7F4yPCEHvWbA0fPDzFZuz0ps8a/0gG0WHwLc5H3ZDdQVz56YqdoDnv
         iN7w==
X-Received: by 10.112.20.106 with SMTP id m10mr9421944lbe.8.1365993086632;
 Sun, 14 Apr 2013 19:31:26 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Sun, 14 Apr 2013 19:31:26 -0700 (PDT)
In-Reply-To: <7vhaj84l8m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221184>

On Sun, Apr 14, 2013 at 8:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> If you have a cover-letter configuration set to anything other than
>> 'false', 'git format-patch' might generate a cover letter, and 'git am'
>> doesn't seem to like that.
>>
>> Ideally 'git am' should skip the cover-letter, but for now lets just fix
>> the regression.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>
> This is a follow-up to the fc/send-email-annotate topic, right?

Right.

> You are mean to say "fix regression", which gave me a small heart
> attack ;-).  I was worried if we had already merged it to 'next'.
>
> As I already wrote in the recent "What's cooking", the series looks
> good to me.  I am inclined to say that we should merge it (together
> with this update) to 'next'.

Yeah, after thinking about it, it's not even really a regression,
because people don't have format.coverletter=auto in their configs
(yet), so the bug can't can possibly affect them.

> Thanks for catching this before breaking the real world users.

I'm running 'next' as you suggested we should do, along with all my
patches, so that helps :)

Cheers.

-- 
Felipe Contreras
