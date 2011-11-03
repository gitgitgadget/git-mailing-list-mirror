From: Jochen Striepe <jochen@tolot.escape.de>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Thu, 3 Nov 2011 04:22:05 +0100
Message-ID: <20111103032205.GA25888@pompeji.miese-zwerge.org>
References: <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org>
 <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org>
 <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
 <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
 <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
 <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com>
 <CAJo=hJsXvSyB65KBp8sfciT=h5uZSqSUdxkpWtZJRtr4hXAh5A@mail.gmail.com>
 <CA+55aFyXg32mko8TOGCfGHpr3jHBEgcKiK7HdVwq0Wez0fAs9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Thu Nov 03 04:24:31 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RLnun-0000Nn-Pu
	for glk-linux-kernel-3@lo.gmane.org; Thu, 03 Nov 2011 04:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932794Ab1KCDY0 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 2 Nov 2011 23:24:26 -0400
Received: from oker.escape.de ([194.120.234.254]:34689 "EHLO oker.escape.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932193Ab1KCDYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2011 23:24:25 -0400
Received: from oker.escape.de (localhost [127.0.0.1])
	(envelope-sender: jochen@tolot.escape.de)
	by oker.escape.de (8.14.3/8.14.3/$Revision: 1.76 $) with ESMTP id pA33Nx2e026181
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 3 Nov 2011 04:23:59 +0100
Received: (from uucp@localhost)
	by oker.escape.de (8.14.3/8.14.3/Submit) with UUCP id pA33NwDC026180;
	Thu, 3 Nov 2011 04:23:58 +0100
Received: from pompeji.miese-zwerge.org (localhost [127.0.0.1])
	by pompeji.miese-zwerge.org (8.14.4/8.14.4/Debian-2) with ESMTP id pA33M65m029973;
	Thu, 3 Nov 2011 04:22:06 +0100
Received: (from jochen@localhost)
	by pompeji.miese-zwerge.org (8.14.4/8.14.4/Submit) id pA33M5b3029972;
	Thu, 3 Nov 2011 04:22:05 +0100
Content-Disposition: inline
In-Reply-To: <CA+55aFyXg32mko8TOGCfGHpr3jHBEgcKiK7HdVwq0Wez0fAs9A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184701>

	Hi,

On Wed, Nov 02, 2011 at 07:25:17PM -0700, Linus Torvalds wrote:
> To me, the point of the tag is so that the person doing the merge can
> verify that he merges something trusted.
> 
> However, everybody else seems to disagree, and wants that stupid
> signature to live along in the repository.

It seems quite useless and leading to false conclusions in several cases
where the merger's gpg output differs from someone's checking later on,
e.g. when

 - the signing key has been revoked in the mean time (for whatever
   reasons)
 - the signing key has expired
 - the public part of the signing key is not available for the general
   public.

AFAIK gpg just gives you an error code and a message like e.g. "Key has
expired" without stating if the key was valid _when signing the commit_.

How do you plan to handle this when keeping the signature in the
repository? Or am I overlooking something?


Thanks,
Jochen.
