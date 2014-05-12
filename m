From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Mon, 12 May 2014 15:19:36 -0500
Message-ID: <53712cd889ba9_2ea6e1f2f82f@nysa.notmuch>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
 <536a83097302f_76ff7a52ec6c@nysa.notmuch>
 <xmqqvbth8ha9.fsf@gitster.dls.corp.google.com>
 <536a999e2c0c_76ff7a52ec1e@nysa.notmuch>
 <xmqqoaz95ees.fsf@gitster.dls.corp.google.com>
 <536ad9601b73b_3caaa612ecdc@nysa.notmuch>
 <CAGK7Mr4DYuU34Zf_3fRQFkT+1TGOkpfLPUnQh=tYh6EMtBEt9A@mail.gmail.com>
 <xmqq8uq6rd30.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 22:30:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wjwru-0001ob-7m
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 22:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756182AbaELUae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 16:30:34 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:44187 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792AbaELUad (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 16:30:33 -0400
Received: by mail-oa0-f50.google.com with SMTP id i7so8867140oag.23
        for <git@vger.kernel.org>; Mon, 12 May 2014 13:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=dpcCl+Sn1FjWxDLi64fs5x7QT8MYbHMm5Y0ENtHlQHY=;
        b=xVlYEFn45Wh9AcpXpbcpqzMdAIaHnn/GwzxnKFu4YQm+hQ4TAHj+gEvgs8LgfZ03uq
         3JpYdceMjxpdFlHlXW59SvBz3/Dyn9I2i4laH4h6tgyj6iSQ7RXUt67zy46f0jG1ao0+
         6WlfEGTI3a0Pl+I7ZjqS74SA2EbTqdqqqoasWQ86qmdMVgDvBHjRGF83t98UDXceEJFn
         svGapbZehedbkTQ+bvlerW+T9OOL19rce/8KNrjE0ZIOQfdM/ioFsSk9JuIdj9aAy+NS
         YIZ8h+MBjO0jZg2uAQzPQBtqHieyCoP4VudnCtPYw9nY0UNJIkQhzu5kO0X2+piTLYH6
         TL+A==
X-Received: by 10.182.49.135 with SMTP id u7mr6833341obn.73.1399926633051;
        Mon, 12 May 2014 13:30:33 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id zm8sm22028243obc.16.2014.05.12.13.30.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 May 2014 13:30:32 -0700 (PDT)
In-Reply-To: <xmqq8uq6rd30.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248730>

Junio C Hamano wrote:
> Philippe Vaucher <philippe.vaucher@gmail.com> writes:
> 
> >> It is *way* beyond the quality of any other tool in 'contrib/' and even
> >> some tools in the core, like 'git-request-pull' (which has known bugs),
> >> and probably even 'git-pt'.
> >
> > Junio, can you comment on this? I understand this probably doesn't
> > really affect the issue at hand, but it'd help clarify if it's ever
> > possible to move out of contrib/ nowadays.
> 
> I was originally led to believe that its code quality was good
> enough, and that was why I merged the bottom three patches of the
> series even down to 'next' in the first place.  But after seeing the
> "Of course" response that led to [*1*], which made me recall many
> patch-review interactions with him, I have started to have doubts.

This is bullshit, and a wrong direction fallacy.

Event #1:
Junio rejects the graduation
http://article.gmane.org/gmane.comp.version-control.git/248263

Event #2:
I give up improving remote helpers in git.git
http://thread.gmane.org/gmane.comp.version-control.git/248063/focus=248341

Junio is trying to make you believe that his decision (#1) was caused by
something I did (#2). Don't fall into that trap, #2 happened *AFTER* #1,
it can't possibly be the cause.

> But I would be lying if I said that I would expect
> that things will suddenly improve and that the codebase will be
> maintained for the long haul in a healthy way the minute we move it
> out of contrib/ to the core.  Especially after seeing [*1*]

[1] happened *AFTER* you made that stupid decision.

Don't make it look as if your decision was caused by [1], *YOU* caused
[1].

If you want to show that the quality of the commit messages or the code
caused that decision, show an issue in that respect that happened
*BEFORE* your decision.

It is very clear what is happening. Junio made a wrong decision based a
non-issue, then it became abudantly clear that there was no basis for
such decision, this why he never clarified the reasoning behind. Then,
*AFTER* I reacted to his decision he grabbed that opportunity to say
"no, look, this _new_ thing Felipe is doing is the reason". Nice try.

If the behavior in [1] is the reason, the solution is easy; I'll revert
back to my old behavior where I explained everything in detail, and
updated the commit messages if something wasn't clear.

I would:

 1. Make sure the regression is fixed Git v2.0
 2. Send a clarified patch for the hg 3.0 compatibility
 3. Look for other important patches that might be missing and provide
    all the details why they are important
 4. Rebase and clean the rest of the patches to make sure nothing is
    missing

This is what I was going to do anyway *BEFORE* you made that decision.
And this commitment to quality is what I've been doing since day one.
*YOU* changed that by throwing away all my hard work.

If the issue was truly the behavior in [1], the outline above should get
rid of the (fake) problem you mention.

We make a compromise, you ignore this temporary bump (that *you*
caused), and I go "back" to high quality standards (which I was already
doing anyway before). The graduation process continues, and *IF* another
instance like [1] comes (it won't), then the graduation process is
canceled.

Ignoring temporary set-backs, finding common ground, and making an
agreement on future behavior is in the best interest of our users. Will
you do it?

> *1* http://thread.gmane.org/gmane.comp.version-control.git/248063/focus=248341

-- 
Felipe Contreras
