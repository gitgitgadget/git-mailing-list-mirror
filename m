From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
 to "rebase-merge"
Date: Sat, 19 Jul 2008 22:25:48 +0200
Message-ID: <48824DCC.7090405@free.fr>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com> <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx> <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness> <20080716012619.GM8185@mit.edu> <7viqv5r637.fsf@gitster.siamese.dyndns.org> <4882454D.2080500@free.fr> <20080719195944.GB5792@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Theodore Tso <tytso@mit.edu>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?Ren=E9_?= =?ISO-8859-1?Q?Scharfe?= 
	<rene.scharfe@lsrfire.ath.cx>, Joe Fiorini <joe@faithfulgeek.org>,
	git@vger.kernel.org, Jari Aalto <jari.aalto@cante.net>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jul 19 22:28:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKJ2U-0003kT-7s
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 22:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbYGSUZv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jul 2008 16:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752960AbYGSUZv
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 16:25:51 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:46296 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621AbYGSUZu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 16:25:50 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 8C1C012B6D5;
	Sat, 19 Jul 2008 22:25:49 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id CC26812B6AC;
	Sat, 19 Jul 2008 22:25:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <20080719195944.GB5792@leksak.fem-net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89133>

Stephan Beyer a =E9crit :
>=20
> If you mean with "work like I want" that it complains about an unclea=
n
> work tree: the check is explicitly done by git-sequencer.

Yes, I mean: refuse to work if the tree is not clean _and_ --skip
and --abort clean the index/tree for me.
With current git version "git am --skip" refuse to continue with a
message: "Dirty index: cannot apply patches (dirty: ...)", if some
files stay unmerged.
As a user I find --skip and --abort useless^Wpainful to use in this
situation.

> I guess there are situations where you want to apply a patch on a dir=
ty
> work tree, e.g. if you fixed some tiny issues so that patches can
> apply cleanly.

Maybe.

Olivier.
