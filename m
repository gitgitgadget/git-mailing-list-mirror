From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: nightly tarballs of git
Date: Thu, 14 Sep 2006 21:48:40 +0200
Organization: At home
Message-ID: <eecblv$gh5$1@sea.gmane.org>
References: <20060914172754.GF8013@us.ibm.com> <20060914175116.GB22279@redhat.com> <7v1wqe45vs.fsf@assigned-by-dhcp.cox.net> <20060914193616.GA32735@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Sep 14 21:49:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNxCk-0002Uk-JS
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 21:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWINTsz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 14 Sep 2006 15:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWINTsz
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 15:48:55 -0400
Received: from main.gmane.org ([80.91.229.2]:14753 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751102AbWINTsz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Sep 2006 15:48:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GNxCS-0002QW-5N
	for git@vger.kernel.org; Thu, 14 Sep 2006 21:48:40 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 21:48:40 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 21:48:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27032>

Dave Jones wrote:

> I don't recall ever having done anything at all in the dir that
> is being snapshotted. So the only thing that should be happening
> is the side-effects of the script. =A0Here it is in its entirity..
>=20
> DATE=3D`date +%Y-%m-%d`
>=20
> PROJ=3D"git"
> cd ~/git-trees
> if [ -d $PROJ ]; then
> =A0 cd $PROJ

Just in case I would add "git checkout master" here.

> =A0 git pull -n
> else
> =A0 git clone -q git://git.kernel.org/pub/scm/git/git.git
> =A0 cd $PROJ
> fi
> snap=3Dgit-snapshot-$(date +"%Y%m%d")
> git-tar-tree HEAD $snap | gzip -9 > $PROJ-$DATE.tar.gz

And what is the HEAD? Perhaps you should say 'origin' here instead?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
