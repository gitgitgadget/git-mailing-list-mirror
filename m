From: Pete/Piet Delaney <pete@bluelane.com>
Subject: Re: How to Import a bitkeeper repo into git
Date: Mon, 15 Oct 2007 17:41:28 -0700
Organization: Bluelane
Message-ID: <471408B8.8080509@bluelane.com>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com> <20070709173720.GS29994@genesis.frugalware.org> <alpine.LFD.0.999.0707091049080.31544@woody.linux-foundation.org> <4713FA4A.5090501@bluelane.com> <20071016000359.GT27899@spearce.org>
Reply-To: pete@bluelane.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 02:44:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhaVF-0006yc-72
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 02:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756822AbXJPAle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 20:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756263AbXJPAle
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 20:41:34 -0400
Received: from outbound.mse2.exchange.ms ([69.25.50.247]:56828 "EHLO
	mse2fe1.mse2.exchange.ms" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755757AbXJPAld (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2007 20:41:33 -0400
Received: from piet2.bluelane.com ([64.95.123.130]) by mse2fe1.mse2.exchange.ms with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 15 Oct 2007 20:41:32 -0400
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <20071016000359.GT27899@spearce.org>
X-Enigmail-Version: 0.95.3
X-OriginalArrivalTime: 16 Oct 2007 00:41:32.0746 (UTC) FILETIME=[4C72DAA0:01C80F8D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61057>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Shawn O. Pearce wrote:
> Pete/Piet Delaney <pete@bluelane.com> wrote:
>> I imported the CVS repository to git and it worked great. Since all
>> of our other repository are in bitkeeper the management would like to
>> stick with CVS. With git apparently still being weak in the area of
>> supporting difftool on different version that seems somewhat reasonable
>> for the time being.
> ...
>> I was curious why the difftool paradigm hasn't been integrated into
>> the git GUIs. It's very comfortable and I think it has been used in
>> other source code control systems, for example Sun Microsystems.
> 
> What's difftool?  What's so great about it?

It's a side by side graphical diff. So instead of showing the difference
like diff does it takes the output from diff and shows the originals
with the diffs highlighted.

tkdiff is a good example that's easy to down load and see. So
just imagine allowing git-gui to run tkdiff of revisions you select
with the mouse.


> 
> Forgive my ignorance but it has been many years since I last used
> BitKeeper and even when I did use it I didn't get into many of the
> features it offered.  Its entirely possible I never learned about
> difftool.

Try downloading tkdiff. There also a X implementation,
I think it's xdiff.

> 
> I've never found that I cannot get the information I need out of Git
> when I need it.  Actually I've found it to be the easiest VCS to get
> data out of, beating CVS, Perforce, BitKeeper, SVN, etc. hands down.
> Of course I also know Git better than I know those tools...

Try tkdiff and then tell me you don't find it easier to read that
the straight output from diff.

- -piet

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHFAi4JICwm/rv3hoRAluCAJ9jFrA9G8aKQi1rtM2CSiNnmhlo4wCeJjk7
LONAM+lzvin021HAhQ8jKoE=
=QsE/
-----END PGP SIGNATURE-----
