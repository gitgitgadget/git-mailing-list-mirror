From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Fri, 17 May 2013 11:35:48 -0500
Message-ID: <CAMP44s0o7tgUrz4xQh3H62+=625ppAOMFskOL70Nrx-O5uwaYw@mail.gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
	<7v7gj77nt9.fsf@alter.siamese.dyndns.org>
	<CAMP44s1HDp+ojGK0UhKHF=1iDu5_E9Z0VrK-JtMked1mtH_2gQ@mail.gmail.com>
	<CAMP44s3J8YpULYenDoYhyRJXSXL3b8-vpMbW2c4LcjK43Xidng@mail.gmail.com>
	<7vwqqy7v8g.fsf@alter.siamese.dyndns.org>
	<CAMP44s17aD_ryeGWQazTcJ3nrhe6C9TLhKHhrUnys=Yj_ATa0A@mail.gmail.com>
	<7vzjvu6faq.fsf@alter.siamese.dyndns.org>
	<CAMP44s3c1vdCn43S=nSzfj=znZ9L_7jH9-+EOY0+SZNnSBTVbw@mail.gmail.com>
	<7vfvxm6biv.fsf@alter.siamese.dyndns.org>
	<CAMP44s2QcFStPtE8cSbH7jWvUOUVRSgGNYNVoDN6exRdW6xNYA@mail.gmail.com>
	<7vobc91squ.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 18:36:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdNdZ-0006ha-7M
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 18:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366Ab3EQQfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 12:35:52 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:49837 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577Ab3EQQfv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 12:35:51 -0400
Received: by mail-lb0-f173.google.com with SMTP id t10so4615150lbi.18
        for <git@vger.kernel.org>; Fri, 17 May 2013 09:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=OWZhj7d2XxPvTaLIqHQvkCNef2ADLQM1gVQz6APYqd8=;
        b=xZvu2y1Un7F/xC1QVdnDiwthXpXP8IKkNCjvpAghkv84YRd88FaIrn3z+AyvKUXMdX
         HsZs3J1UsJ/AKXXRX6jifOGsZzaDq6k6U9ijnWaLqOmXsFVBmIdzk4C9iBvRBB5eMzpb
         jbg+AjkwsvTw7V2/oTkpePPtL5MyWJDvNns0F71liDFckCYEFlJlw3zPINuPXg2EX3n1
         RCt/JlAWkK631SYKQTibpnQuBM98EnYD8/d2UHAW97MrHJhe9ROW6T4BuyCA55DhS6Ui
         /gYG1msbwsiS9rxgmbNIYfyi8QO9whFxwWsUFOJXmWr9fZ5l/zqxI6Dl1QBgmJR/tZwF
         Ip0A==
X-Received: by 10.112.166.101 with SMTP id zf5mr22403711lbb.59.1368808548624;
 Fri, 17 May 2013 09:35:48 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Fri, 17 May 2013 09:35:48 -0700 (PDT)
In-Reply-To: <7vobc91squ.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224699>

On Fri, May 17, 2013 at 11:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> *You* are telling my that; it's *your* opinion and nothing else. It's
>
> I saw a review comment that points out that the continuation lines
> do not align, and you refused to say "ah, thanks for spotting" and
> reroll [*1*], so even I do not want to do so in general, I had to
> play the role of the arbiter.

Spotting what? There no style issues in my patch.

> My take on these style issues is this:
>
>  * People made mistakes in the past while doing real work.  Big
>    news: contributors and reviewers are not perfect.

That's exactly why "follow the surrounding code" is not a good guideline.

>  * They survived to this day because we do not do tree-wide "style
>    fixes" for the sake of style fix, in order to avoid clashing with
>    real work in flight.
>
>  * Existing mistakes are not an excuse for adding new mistakes of
>    the same kind, especially when they are pointed out during the
>    review (this is not limited to "style issues").

Fortunately nobody is adding new mistakes in this patch.

> I do not think I would reject a patch with minor style bugs like
> unaligned continuation lines, if it were a patch that does real
> work.
>
> But a "style cleanups" patch that introduces new instances of style
> breakage is a different matter.

THERE IS NO STYLE BREAKAGE.

> It is clear that the original
> (picked randomly):
>
>         die ("Encountered signed tag %s; use ",
>              "--signed-tags=<mode> to handle it.",
>              sha1_to_hex(tag->object.sha1));
>
> wanted the opening double-quotes of two lines and the "sha1" at the
> beginning of the third line to align.  I see that is the local style
> a "style cleanup" change should follow.

Unless the original had a mistaken style, or there was no guideline at
all, which is the case.

> A patch that cleans up styles in preparation for a real work (like
> this one) is a rare and precious occasion for us to really clean up
> accumulated wart.  I do not want to see existing mistakes from other
> unrelated parts of the codebase that have not been cleaned up as an
> excuse to waste that rare occasion to do a good job of cleaning up.

This is a good job of cleaning up. It follows the coding style PERFECTLY.

> So that is the arbiter's decision.  Call it *my* opinion or whatever
> you like; it does not change anything.

You are rejecting a patch for not following your *ARBITRARY* coding
style, not the project's.

All you are doing is using rhetoric to say that this patch has "broken
style" doesn't follow the "project's style", and whatever, and you
conveniently ignore the fact that 535 instances of this style, and the
fact that it's not mentioned at all in Documentation/CodingStyle
proves that it does indeed follow the project's style.

Keep using rhetoric all you want, it doesn't change the facts. You are
rejecting the patch because of your own personal subjective reasons,
and not because of anything related to the project's style.

> [Footnote]
>
> *1* That would have ended this thread without wasting everybody's
> time.

It would have ended if you applied the patch that follows the coding
style to the letter.

-- 
Felipe Contreras
