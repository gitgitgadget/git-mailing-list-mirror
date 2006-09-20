From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] cvsimport move over to using git for each ref to read refs
Date: Wed, 20 Sep 2006 11:23:02 +0200
Organization: At home
Message-ID: <eer19l$6hm$1@sea.gmane.org>
References: <20060920085200.GA21865@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Sep 20 11:23:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPyIx-0007hI-Jx
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 11:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWITJXV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 20 Sep 2006 05:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWITJXV
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 05:23:21 -0400
Received: from main.gmane.org ([80.91.229.2]:56214 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750745AbWITJXU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 05:23:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GPyIO-0007YL-Qu
	for git@vger.kernel.org; Wed, 20 Sep 2006 11:23:08 +0200
Received: from host-81-190-26-22.torun.mm.pl ([81.190.26.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 11:23:08 +0200
Received: from jnareb by host-81-190-26-22.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 11:23:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-22.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27334>

Andy Whitcroft wrote:

> +=A0=A0=A0=A0=A0=A0=A0open(H, "git-for-each-ref --format=3D'%(objectn=
ame) %(refname)'|") or

By the way, this is equivalent to using "git-show-ref" introduced by Li=
nus.
But if you want commit timestamp

> cvsimport opens all of the files in $GIT_DIR/refs/heads and reads
> out the sha1's in order to work out what time the last commit on
> that branch was made (in CVS) thus allowing incremental updates.

you can use it in --format as well.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
