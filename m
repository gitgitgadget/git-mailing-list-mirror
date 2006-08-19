From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git clone dies (large git repository)
Date: Sat, 19 Aug 2006 12:58:22 +0200
Organization: At home
Message-ID: <ec6qsa$aal$2@sea.gmane.org>
References: <op.teh30gmyies9li@rygel.lnxi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Aug 19 13:00:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEOYn-0000Hs-14
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 13:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWHSLAJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 19 Aug 2006 07:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbWHSLAI
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 07:00:08 -0400
Received: from main.gmane.org ([80.91.229.2]:15287 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751318AbWHSLAG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Aug 2006 07:00:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GEOYc-0000G3-95
	for git@vger.kernel.org; Sat, 19 Aug 2006 13:00:02 +0200
Received: from host-81-190-24-244.torun.mm.pl ([81.190.24.244])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Aug 2006 13:00:02 +0200
Received: from jnareb by host-81-190-24-244.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Aug 2006 13:00:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-244.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25714>

Troy Telford wrote:

> I originally had everything as loose objects. =A0I then ran 'git-repa=
ck -d' =A0
> on occasion, so I had a combination of a large pack file, smaller pac=
k =A0
> files, and loose objects. =A0Finally, I tried 'git repack -a -d' and =
=A0
> consolidated it all into a single 4GB pack file. =A0It didn't seem to=
 make =A0
> much difference in the output.
>=20
> Am I bumping some sort of limitation within git, or have I uncovered
> a bug?=20

You _might_ have bumped into filesystem limit on file size, or system l=
imit
on mmap size.

IIRC it was to be addressed (splitting packs into manageable hunks).
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
