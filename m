From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Wed, 2 Nov 2011 19:31:00 -0700
Message-ID: <CA+55aFzbNxTn83DdQd9cVpDujNYEdEP0Aimv5k1hCD0ebTDzcQ@mail.gmail.com>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org> <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org> <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
 <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
 <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
 <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com> <CAJo=hJsXvSyB65KBp8sfciT=h5uZSqSUdxkpWtZJRtr4hXAh5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: linux-kernel-owner@vger.kernel.org Thu Nov 03 03:31:30 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RLn5V-0001Gl-5H
	for glk-linux-kernel-3@lo.gmane.org; Thu, 03 Nov 2011 03:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680Ab1KCCbZ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 2 Nov 2011 22:31:25 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45108 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303Ab1KCCbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2011 22:31:22 -0400
Received: by wyh15 with SMTP id 15so759315wyh.19
        for <multiple recipients>; Wed, 02 Nov 2011 19:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=3yIwzGLKBGUwYl/gphkpOfvpLxqibxyaNCsKA2gDOnk=;
        b=g95wV6KdFBrmwew3PsZiU3sUxDb1ZaTfAterpbRxqYG33F3cIrDz86ooN0mhbp1zeo
         mwaUcAOsPdXuZ20SikCUvjEDYltCZ5RIZ92B0ZjkfQs68+JCpH+cum8BBe/s1JigiROC
         O0vm+XvPlbe1KUEj2KNTNKr9YpFvygiUocyC8=
Received: by 10.216.229.162 with SMTP id h34mr283609weq.82.1320287481155; Wed,
 02 Nov 2011 19:31:21 -0700 (PDT)
Received: by 10.216.166.3 with HTTP; Wed, 2 Nov 2011 19:31:00 -0700 (PDT)
In-Reply-To: <CAJo=hJsXvSyB65KBp8sfciT=h5uZSqSUdxkpWtZJRtr4hXAh5A@mail.gmail.com>
X-Google-Sender-Auth: nJ2xv1q5e0fpspPFY1GcRUaviRQ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184696>

On Wed, Nov 2, 2011 at 7:14 PM, Shawn Pearce <spearce@spearce.org> wrote:
>
> <rant>

I'm answering this separately, because it's a separate rant.

It's also totally bogus, but whatever.

> Get over it. Add the fucking empty commit to show the flow of a
> change. Stop forcing every fucking contributor to rebase/rewrite his
> commits just so someone higher up in the food chain can wank with
> their SOB line.

Shawn, stop using whatever drugs you are using.

NOBODY EVER REBASES ANYTHING FOR SIGNED-OFF-BY.

If they do, they are doing things very very wrong.

Signed-off-by: is *purely* for sending patches by email. No git
operations involved. None. Nada. Zilch. No rebasing involved, because
there's not even a git repository involved, for chissake!

Once something is in git, it's not signed off on - there should be a
sign-off-chain from the author to the committer, and that's it.
Anything else would be crazy.

So stop the crazy rants. Stop with the bad drugs. Seriously. You're
acting crazy.

                          Linus
