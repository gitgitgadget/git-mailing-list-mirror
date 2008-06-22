From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [jgit PATCH] Paper bag fix quoting for SSH transport commands
Date: Sun, 22 Jun 2008 19:54:08 +0200
Message-ID: <200806221954.08919.robin.rosenberg.lists@dewire.com>
References: <20080622013640.GA18629@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jun 22 19:59:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KATqk-0003dP-UY
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 19:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755689AbYFVR62 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Jun 2008 13:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752704AbYFVR61
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 13:58:27 -0400
Received: from av6-2-sn3.vrr.skanova.net ([81.228.9.180]:51887 "EHLO
	av6-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755640AbYFVR6B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jun 2008 13:58:01 -0400
Received: by av6-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 346D2381E7; Sun, 22 Jun 2008 19:57:59 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av6-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 0F292381D6; Sun, 22 Jun 2008 19:57:59 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id E555037E47;
	Sun, 22 Jun 2008 19:57:58 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080622013640.GA18629@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85789>

s=C3=B6ndagen den 22 juni 2008 03.36.40 skrev Shawn O. Pearce:
> Not all Git-over-SSH servers run a Bourne shell on the remote side
> to evaluate the command we are sending.  Some servers run git-shell,
> which will fail to execute git-upload-pack if we feed it a quoted
> string for the name git-upload-pack.
>=20
> Testing concludes that git-shell requires the command name to never
> be quoted, and the argument name to always be single quoted.  As
> this is a long-standing behavior in the wild jgit needs to conform,
> as git-shell and all git-shell work-a-likes such as gitosis may be
> following the same convention.
>=20
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>=20
>  If there are no arguments I'll push this into the public tree.
>  It seems right on the surface, and is necessary to use jgit against
>  repo.or.cz, and probably many other sites like it.

Seems ok and works here. Error handling still has a paperbagish feel. S=
ee
follow up patches.

Maybe we should have a patch for git too so it will actually work with =
spaces in file names. What do people on Windows do? (those that actuall=
y get an SSH server up and running and sleep well overe it on that plat=
form).

As for pushing and signing. One way is for you (Shawn) and me is to sig=
n-off and push each other's patches. I pushed this one.

-- robin
