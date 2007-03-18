From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [wishlist] graphical diff
Date: Sun, 18 Mar 2007 16:06:19 +0100
Organization: Dewire
Message-ID: <200703181606.20678.robin.rosenberg.lists@dewire.com>
References: <1174223784.5987.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Raimund Bauer <ray007@gmx.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 16:04:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSwvd-0000N4-Io
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 16:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbXCRPEM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 18 Mar 2007 11:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbXCRPEM
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 11:04:12 -0400
Received: from [83.140.172.130] ([83.140.172.130]:5492 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932205AbXCRPEL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Mar 2007 11:04:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id AB7E7802855;
	Sun, 18 Mar 2007 15:58:49 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 14450-06; Sun, 18 Mar 2007 15:58:49 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 5440B802664;
	Sun, 18 Mar 2007 15:58:47 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <1174223784.5987.6.camel@localhost>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42498>

s=C3=B6ndag 18 mars 2007 14:16 skrev Raimund Bauer:
> I think it would be really helpful (especially for newbies like me) t=
o
> have an option like
>=20
> git diff --gui [revisions] <singe path spec>
>=20
> to fire up a graphical diff viewer (similar to what git-mergetool doe=
s).
>=20
> Another good place to start a graphical diff from is probably gitk fr=
om
> a context-menu for the changed files in the lower right pane.
>=20
> Thoughts?
>=20

=46ine, except it is not likely to be my favourite gui. But you don't h=
ave to wait,
you can get a gui easily today.

Pipe the output to another tool. Kompare is such a tool which can take =
a patch
and compare it. It does not have to a single file. You can diff  two tr=
ees and
compare. You'll need at kdesdk version 3.5.5 (or 3.5.6)  or the patch i=
n
http://bugs.kde.org/show_bug.cgi?id=3D131717 for kompare to display git=
 diffs.

git diff HEAD^..HEAD | kompare -

As for other gui's I don't know which ones work easily out of the box.=20

Eclipse will soon have recursive diff mode for git. Seems to work here,=
 so I'll probably submit it soon).=20

-- robin
