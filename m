From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Wed, 2 Nov 2011 19:25:17 -0700
Message-ID: <CA+55aFyXg32mko8TOGCfGHpr3jHBEgcKiK7HdVwq0Wez0fAs9A@mail.gmail.com>
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
X-From: linux-kernel-owner@vger.kernel.org Thu Nov 03 03:25:50 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RLn01-00084G-BN
	for glk-linux-kernel-3@lo.gmane.org; Thu, 03 Nov 2011 03:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655Ab1KCCZm (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 2 Nov 2011 22:25:42 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34136 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797Ab1KCCZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2011 22:25:39 -0400
Received: by wwi36 with SMTP id 36so1140605wwi.1
        for <multiple recipients>; Wed, 02 Nov 2011 19:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=pqz0lkz9EAnGeHSsyl2jLGSYh58J6gM1q6VVB0UVJAQ=;
        b=hhCZdG8sRMpA+2xUl9I4v2Z5P61O/Og3n8yMNE6btpV3AWMUlnFygxA7GAd+OmkED0
         6US6wwedHwsCUuOxhv8TO6WT0qR7KyIfb66+JjJkxeBw59kIVGzdACQwV2S4img+hYJl
         HNGxIa4fFwglvjxBYnTV/hQ98aknsfy5FF+SQ=
Received: by 10.216.188.83 with SMTP id z61mr6723496wem.82.1320287138055; Wed,
 02 Nov 2011 19:25:38 -0700 (PDT)
Received: by 10.216.166.3 with HTTP; Wed, 2 Nov 2011 19:25:17 -0700 (PDT)
In-Reply-To: <CAJo=hJsXvSyB65KBp8sfciT=h5uZSqSUdxkpWtZJRtr4hXAh5A@mail.gmail.com>
X-Google-Sender-Auth: 7lEjX3zEHVLR9PNLKdu6kPGjbRw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184695>

On Wed, Nov 2, 2011 at 7:14 PM, Shawn Pearce <spearce@spearce.org> wrote:
>
> So you propose we put the tag contents into the merge commit message
> so it can be verified after the fact? So merges are now going to be
> something much more horrific to read, because it will end with Git
> object tag cruft, the tag message, and the PGP signature spew that no
> human can decode in the head?

Actually, I wanted to just drop the damn thing.

To me, the point of the tag is so that the person doing the merge can
verify that he merges something trusted.

However, everybody else seems to disagree, and wants that stupid
signature to live along in the repository. And I can live with that,
although I do agree with you that it's not exactly pretty. I can live
with "ugly signature that I don't care for" way more than "stupid
design".

Because unlike your crazy empty commit, it at least fits the workflow,
and it certainly isn't any uglier that extraneous pointless commit.

You can disagree. You obviously do. I simply don't care. Because I'm right.

(And your claim that it's big UI fixes and protocol changes is pure
and utter garbage. I just sent a patch that cleans the code up,
removes a line that improperly drops information and gets rid of the
biggest problem with our current handling of tags. No protocol changes
involved, no big UI fixup).

                        Linus
