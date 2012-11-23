From: Sascha Cunz <sascha-ml@babbelbox.org>
Subject: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Fri, 23 Nov 2012 18:24:33 +0100
Message-ID: <10919221.ErD9qLRjsD@blacky>
References: <20121117153007.GB7695@book.hvoigt.net> <7vhaokrr01.fsf@alter.siamese.dyndns.org> <20121123155521.GB14509@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Nov 23 18:24:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbwzm-0000HL-9D
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 18:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010Ab2KWRYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 12:24:38 -0500
Received: from babbelbox.org ([83.133.105.186]:53187 "EHLO mail.babbelbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753875Ab2KWRYg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 12:24:36 -0500
Received: (qmail 29030 invoked from network); 23 Nov 2012 17:25:29 -0000
Received: from p54aea686.dip.t-dialin.net (HELO blacky.localnet) (sascha@babbelbox.org@84.174.166.134)
  by babbelbox.org with ESMTPA; 23 Nov 2012 17:25:29 -0000
User-Agent: KMail/4.9.3 (Linux/3.6.6-gentoo; KDE/4.9.3; x86_64; ; )
In-Reply-To: <20121123155521.GB14509@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210268>

Am Freitag, 23. November 2012, 16:55:21 schrieb Heiko Voigt:
> I am still a little bit undecided about an automatically crafted commit.
> 
> At $dayjob we sometimes update submodules to their tip without any
> superproject changes just to make sure we use the newest version. Most
> of the time the commit messages are along the lines of "updated
> submodule x to master".
>
> On one hand Junio is right that the person updating to the newest
> submodule stuff has no clue what to write in this message.

I've been thinking about that for a while, when I started using submodules. In 
the end, I concluded, that what I really want to see in the commit message, is 
something similar to $(git shortlog $OLD_SHA1..$NEW_SHA1).

I've scripted that and taught my CI-Server to do it automatically, if 
possible. So most of the time, I really don't want an "automatically crafted 
commit" whenever something causes the tip of a submodule to be at a new SHA1.

Just my $.02, though.

Sascha
