From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Wed, 21 Nov 2007 18:06:55 +0100
Organization: At home
Message-ID: <fi1ojd$pva$1@ger.gmane.org>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 18:14:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iut9d-0002xR-MG
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 18:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbXKUROF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Nov 2007 12:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752101AbXKUROF
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 12:14:05 -0500
Received: from main.gmane.org ([80.91.229.2]:49130 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808AbXKUROD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 12:14:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Iut7O-0006KD-Qk
	for git@vger.kernel.org; Wed, 21 Nov 2007 17:12:06 +0000
Received: from abxf19.neoplus.adsl.tpnet.pl ([83.8.255.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 17:12:06 +0000
Received: from jnareb by abxf19.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 17:12:06 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abxf19.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65685>

[Cc: Santi B=E9jar <sbejar@gmail.com>, git@vger.kernel.org]

Santi B=E9jar wrote:

> 1) git-clone does not accept a bundle file, even if git-fetch does.
> I've made a patch to use git-fetch in git-clone for this.

[...]=20
> 3) I can "git fetch" a bundle but I cannot "git push" a bundle

We would also need "git ls-remote <bundle>" and "git fsck <bundle>"
to demote git-bundle to porcelain status :-)

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
