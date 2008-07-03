From: Gabriel <g2p.code@gmail.com>
Subject: [BUG] git-svn failure with python repository
Date: Thu, 3 Jul 2008 19:00:59 +0000 (UTC)
Message-ID: <g4j7lb$22c$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 03 21:02:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEU4I-00032z-1W
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 21:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023AbYGCTBM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jul 2008 15:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752924AbYGCTBL
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 15:01:11 -0400
Received: from main.gmane.org ([80.91.229.2]:37582 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752673AbYGCTBL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 15:01:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KEU3G-0008Dh-0U
	for git@vger.kernel.org; Thu, 03 Jul 2008 19:01:06 +0000
Received: from pro75-5-88-162-203-35.fbx.proxad.net ([88.162.203.35])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 19:01:06 +0000
Received: from g2p.code by pro75-5-88-162-203-35.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 19:01:06 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pro75-5-88-162-203-35.fbx.proxad.net
User-Agent: Pan/0.132 (Waxed in Black)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87303>

I got an error importing the python repository with git-svn.
The error could be due to a funky branch name.

git --version
git version 1.5.6.1.89.gd5446

LANG=3D git svn clone -s http://svn.python.org/projects/python
=E2=80=A6
r5002 =3D 8aa67da1bc987c02661b5331eae7c349be2da0ef (trunk)
=46ound possible branch point: http://svn.python.org/projects/python/tr=
unk =3D> http://svn.python.org/projects/python/tags/Beta_14-Mar-1995-#2=
, 5002
=46ound branch parent: (tags/Beta_14-Mar-1995-#2) 8aa67da1bc987c02661b5=
331eae7c349be2da0ef
=46ollowing parent with do_switch
Invalid filesystem path syntax: REPORT request failed on '/projects/!sv=
n/vcc/default': Target path does not exist at /home/g2p/bin/git-svn lin=
e 3892
