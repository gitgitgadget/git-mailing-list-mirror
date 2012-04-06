From: Michael Thayer <michael.thayer@oracle.com>
Subject: setprop support in git-svn
Date: Fri, 6 Apr 2012 10:00:44 +0000 (UTC)
Message-ID: <loom.20120406T114122-240@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 06 12:05:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG62g-0006ya-R3
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 12:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781Ab2DFKFK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 06:05:10 -0400
Received: from plane.gmane.org ([80.91.229.3]:52352 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752778Ab2DFKFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 06:05:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SG62V-0006rK-FJ
	for git@vger.kernel.org; Fri, 06 Apr 2012 12:05:07 +0200
Received: from p5482A549.dip.t-dialin.net ([84.130.165.73])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 12:05:07 +0200
Received: from michael.thayer by p5482A549.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 12:05:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 84.130.165.73 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:11.0) Gecko/20100101 Firefox/11.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194864>

Hello,

I have been looking at git-svn as an alternative to Subversion.  As for=
 many
people, the lack of support for Subverison properties is something of a=
 blocker
for me.  Some quick thought suggests that one of the simplest ways of f=
ixing
this would be to add a couple of options to dcommit: setprop and delpro=
p, which
would add a property change changeset at the end of a commit series.  s=
etprop
could take the form --setprop file:prop=3Dvalue [--setprop file:prop=3D=
value] and
delprop the form --delprop prop [--delprop prop], possibly allowing wil=
dcards in
file names.  Obviously there would be nicer ways to support this, but n=
o one has
done them yet, and this should be reasonably simple to implement (simil=
ar to
<http://www.spinics.net/lists/git/msg113263.html>), while still being a=
n
improvement over no support at all.  To answer the question in
<http://www.spinics.net/lists/git/msg113263.html>, I think that the adv=
antage
over using:

	svn prop(edit|set|del) ARGS $(git svn info --url)

would be the shorter time window between the property change and other =
relevant
changes.

I would appreciate being CC-ed on any answers.

Thanks for your time.

Regards,

Michael
--=20
ORACLE Deutschland B.V. & Co. KG   Michael Thayer
Werkstrasse 24                     VirtualBox engineering
71384 Weinstadt, Germany           mailto:michael.thayer@oracle.com

Hauptverwaltung: Riesstr. 25, D-80992 M=C3=BCnchen
Registergericht: Amtsgericht M=C3=BCnchen, HRA 95603

Komplement=C3=A4rin: ORACLE Deutschland Verwaltung B.V.
Hertogswetering 163/167, 3543 AS Utrecht, Niederlande
Handelsregister der Handelskammer Midden-Niederlande, Nr. 30143697
Gesch=C3=A4ftsf=C3=BChrer: J=C3=BCrgen Kunz, Marcel van de Molen, Alexa=
nder van der Ven=20
