From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Use diff3 instead of merge in merge-recursive.
Date: Wed, 18 Oct 2006 11:35:28 +0200
Organization: At home
Message-ID: <eh4sfr$3ej$1@sea.gmane.org>
References: <20061018085949.GA26501@cepheus.pub>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Oct 18 11:36:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga7qK-000240-Bz
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 11:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWJRJfv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 18 Oct 2006 05:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWJRJfu
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 05:35:50 -0400
Received: from main.gmane.org ([80.91.229.2]:3976 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751072AbWJRJft (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 05:35:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ga7pe-0001sp-M6
	for git@vger.kernel.org; Wed, 18 Oct 2006 11:35:26 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Oct 2006 11:35:26 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Oct 2006 11:35:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29213>

Uwe Zeisberger wrote:

> If no error occurs, merge (from rcs 5.7) is nothing but:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0diff3 -E -am -L label1 -L label2 -L label3 fi=
le1 file2 file3 > tmpfile
> =A0=A0=A0=A0=A0=A0=A0=A0cat tmpfile > file1
>=20
> Using diff3 directly saves one fork per conflicting file.

Doesn't xdiff library git uses have diff3/merge equivalent?
Couldn't we use that instead (on less dependency, better performance)?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
