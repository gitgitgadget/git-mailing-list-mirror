From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/2] remote-bzr: couple of fixes
Date: Sun, 5 May 2013 16:54:55 -0500
Message-ID: <CAMP44s3W79ZY_s2jq8-KtdMSqFRvCo3RC7ojcTzgGYJkzoDVnA@mail.gmail.com>
References: <1367627467-15132-1-git-send-email-felipe.contreras@gmail.com>
	<7vd2t5uvi2.fsf@alter.siamese.dyndns.org>
	<CAMP44s1D7LOhDGkZguosPiXyuJ5cP2hmgq4AWagwadrJYK1Pgg@mail.gmail.com>
	<7v4nehuu3o.fsf@alter.siamese.dyndns.org>
	<CAMP44s3JtLzE0vne5VH+bHrLvSuOwaWwuGa7DFggjEOt6ixgTA@mail.gmail.com>
	<7vzjw9ta8u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 05 23:55:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZ6ta-0005xF-BY
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 23:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066Ab3EEVy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 17:54:57 -0400
Received: from mail-we0-f182.google.com ([74.125.82.182]:57613 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977Ab3EEVy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 17:54:56 -0400
Received: by mail-we0-f182.google.com with SMTP id r46so2549038wey.41
        for <git@vger.kernel.org>; Sun, 05 May 2013 14:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=q8h2VTQxWXM7XiLB1Y+yZB8I0j/SFCBZ8Fnf1Zk/+YA=;
        b=zrcZ9FAU7SG2Jub8Uq4Ny7moqp4rR8tLXJ16e9HnmYCLsNposLkzOV2V7XJ0vm7EKj
         0PQ0jcIdfj2U1/tkgIvol8hfDa51OhjOEU1oNP/a3rWsg6jooEOQV2iOYCjISQ33vZn3
         zBEjHWyUq5PdTKfX+su93KsSkF+7whspaKCsM30s7swC/x35K9nOncfJK1ttdX9V02x8
         QwRrItastzfVccJ9ZJm5ciz35gtfbeXebCOhjAqkI0JGDyZGDCozxpQdjd0pfNY1bVJZ
         /c1zphNCpp7j4bz4ZyoRh8SEmaV7cw6mD30Jn1UWqXnxss2DVJPmlV09Yy4XnsPA9n3N
         flQQ==
X-Received: by 10.180.91.131 with SMTP id ce3mr5895397wib.5.1367790895139;
 Sun, 05 May 2013 14:54:55 -0700 (PDT)
Received: by 10.194.240.135 with HTTP; Sun, 5 May 2013 14:54:55 -0700 (PDT)
In-Reply-To: <7vzjw9ta8u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223418>

On Sun, May 5, 2013 at 3:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> So do you want to queue these on top of the "massive" in 'next', not
>>> directly on 'master'?
>>
>> If they apply on master, master. But I'm confused, are the massive
>> changes not going to graduate to master? Because if not, I should
>> cherry-pick the safest changes, as there's a lot of good stuff there.
>
> I think we discussed and agreed that we would ship it in 1.8.3 if we
> hear positive feedback from Emacs folks, and my understanding is
> that I was waiting for you to give me a go-ahead once that happens.

Yeah, and I just said everything seems to be fine. There's only one
more patch that would be good to have that I still haven't cleaned up.

> It is entirely up to you to add these two on top of that "massive"
> stuff, their fate decided by feedback from Emacs folks, or apply
> these as "much safer than those we need to hear from them; we can
> verify their validity and safety ourselves without knowing the real
> world projects that use the program" patches.
>
> The impression I was getting from your response "I hear it breaks
> for some of them without the patch but I haven't seen the breakage
> myself" is that it is safer to group 2/2 as part of the rest of the
> series, but as I heard in the same message that you heard Emacs
> folks are happy with the entire series, so it wouldn't make much of
> a difference either way.
>
> Will apply these two to the tip of the "massive" stuff, and merge
> the result before the next -rc.

Cool, I think that's the best approach. I'll send the last patch later today.

Cheers.

-- 
Felipe Contreras
