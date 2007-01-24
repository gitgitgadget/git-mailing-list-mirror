From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Problem with git push over <hostname>:/path protocol (ssh)
Date: Wed, 24 Jan 2007 21:35:36 +0100
Organization: At home
Message-ID: <ep8fss$dlf$1@sea.gmane.org>
References: <17847.47131.694158.247941@lisa.zopyra.com> <Pine.LNX.4.64.0701241453410.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 24 21:34:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9opY-0003NY-G6
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 21:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbXAXUet convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 24 Jan 2007 15:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbXAXUet
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 15:34:49 -0500
Received: from main.gmane.org ([80.91.229.2]:54890 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932579AbXAXUes (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 15:34:48 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H9opO-0003yT-L4
	for git@vger.kernel.org; Wed, 24 Jan 2007 21:34:42 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 21:34:42 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 21:34:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37672>

Daniel Barkalow wrote:

>> So, if the developer then commits on his branch on machine 1, all hi=
s
>> changes get undone. =A0This has happened to him consistently --- he =
is
>> running git 1.4.4.1 throughout. =A0I just reproduced it using the ab=
ove,
>> and I am using 1.5.0-rc2 on machine 2, and 1.4.4.1 on machine 1.
>=20
> Git gets unhappy if you push into a branch that's checked out. It doe=
sn't=20
> update the index or working directory, so the state after the push lo=
oks=20
> like the user reverted the patch in the working directory and updated=
 the=20
> index.

So you usually push into _bare_ repository, or use fetch / pull instead=
=2E
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
