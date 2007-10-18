From: cho <tobutaz@gmail.com>
Subject: [BUG] git-svn not following svn moves
Date: Thu, 18 Oct 2007 11:20:16 +0000 (UTC)
Message-ID: <ff7fhg$2eu$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 13:25:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiTVD-0001xq-J9
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 13:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223AbXJRLZM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2007 07:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755726AbXJRLZL
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 07:25:11 -0400
Received: from main.gmane.org ([80.91.229.2]:41260 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755521AbXJRLZK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 07:25:10 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IiTUs-0005Zt-6l
	for git@vger.kernel.org; Thu, 18 Oct 2007 11:25:07 +0000
Received: from dhcp26-237.enst.fr ([137.194.26.237])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Oct 2007 11:25:02 +0000
Received: from tobutaz by dhcp26-237.enst.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Oct 2007 11:25:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dhcp26-237.enst.fr
User-Agent: Pan/0.129 (Benson & Hedges Moscow Gold)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61516>

Hello,

I have a git-svn checkout that apparently did not follow a move correct=
ly.
The files are not present in an svn checkout, but are in a git svn clon=
e.

According to a trac browser, some of the files that appear in my git=20
checkout had in fact been moved to their separate branch before doing g=
it-
svn clone. I noticed this when trying to commit changes to those files,=
=20
getting the error message:
> Le syst=C3=A8me de fichiers ne contient pas cet =C3=A9l=C3=A9ment: Fi=
chier non=20
trouv=C3=A9 : transaction '3926-1', chemin '.../composants.py' at /home=
/marc/
bin/git-svn line 2960
It's a standard subversion error, "Filesystem has no item"

I've made a clean checkout (with today's 1.5.3.4.206.g58ba4), and I sti=
ll=20
have the moved files present.
The clone command is just:
git svn clone --stdlayout svn+ssh://host/srv/subversion/proj/appli/proj

Tell me if I can give more info (the repository isn't public).
