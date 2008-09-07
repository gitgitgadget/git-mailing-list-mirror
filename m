From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH] RevWalk: Fix RevSort.REVERSE combined with RevSort.TOPO
Date: Sun, 7 Sep 2008 23:21:59 +0200
Message-ID: <200809072321.59789.robin.rosenberg.lists@dewire.com>
References: <1220821208-13420-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Sep 07 23:23:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcRix-0007HS-T2
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 23:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbYIGVWF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Sep 2008 17:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbYIGVWE
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 17:22:04 -0400
Received: from av8-1-sn3.vrr.skanova.net ([81.228.9.183]:51638 "EHLO
	av8-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbYIGVWD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Sep 2008 17:22:03 -0400
Received: by av8-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id E36BF38C0B; Sun,  7 Sep 2008 23:22:00 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av8-1-sn3.vrr.skanova.net (Postfix) with ESMTP
	id C060238C06; Sun,  7 Sep 2008 23:22:00 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id A612037E45;
	Sun,  7 Sep 2008 23:22:00 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1220821208-13420-1-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95178>

s=F6ndagen den 7 september 2008 23.00.08 skrev Shawn O. Pearce:
> From: Shawn O. Pearce <sop@google.com>
>=20
> The reverse sort was using the initial pending queue, not the
> generator that comes before it in the workflow.  This caused
> a combination of TOPO and REVERSE to return no commits.

Some unit tests to back this up would be nice. We running low on
coverage in this section of code.

> Signed-off-by: Shawn O. Pearce <sop@google.com>

No idea Google employees had this short email addresses.  Ok, 27x27x27 =
=3D 19683=20
would be sufficient in theory, I'd suppose.

-- robin
