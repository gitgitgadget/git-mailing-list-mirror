From: Marcin =?iso-8859-2?q?Wi=B6nicki?= <mwisnicki@gmail.com>
Subject: Re: cvsimport does not work with passwords ?
Date: Thu, 28 Apr 2011 22:50:53 +0000 (UTC)
Message-ID: <ipcr0c$jc3$1@dough.gmane.org>
References: <ipckgd$krd$2@dough.gmane.org> <ipcmjp$krd$4@dough.gmane.org>
	<20110428224510.GA16065@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 00:51:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFa3J-0005Rr-38
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 00:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933547Ab1D1WvM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 18:51:12 -0400
Received: from lo.gmane.org ([80.91.229.12]:37880 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932352Ab1D1WvL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 18:51:11 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QFa3A-0005KV-R1
	for git@vger.kernel.org; Fri, 29 Apr 2011 00:51:08 +0200
Received: from static-78-8-147-77.ssp.dialog.net.pl ([78.8.147.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Apr 2011 00:51:08 +0200
Received: from mwisnicki by static-78-8-147-77.ssp.dialog.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Apr 2011 00:51:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: static-78-8-147-77.ssp.dialog.net.pl
User-Agent: Pan/0.134 (Wait for Me; Unknown)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172416>

On Thu, 28 Apr 2011 18:45:10 -0400, Jeff King wrote:

> On Thu, Apr 28, 2011 at 09:35:53PM +0000, Marcin Wi=C5=9Bnicki wrote:
>=20
>> I have tried another mirror that uses ssh:
>>=20
>> > export CVSROOT=3D:ext:anoncvs@anoncvs1.FreeBSD.org:/home/ncvs expo=
rt
>> > SSH_RSH=3Dssh
>>=20
>> And this also does not work because git tries to use rsh. According =
to
>> google this should work.
>>=20
>> Any ideas why cvsimport is so broken for me ?
>=20
> It has (thankfully) been a long time since I've had to touch CVS, but
> shouldn't that be CVS_RSH on the second line?
>=20
> -Peff

Ahh yes indeed. I made a silly typo, now it works.
