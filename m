From: Marcin =?iso-8859-2?q?Wi=B6nicki?= <mwisnicki@gmail.com>
Subject: Re: cvsimport does not work with passwords ?
Date: Thu, 28 Apr 2011 21:35:53 +0000 (UTC)
Message-ID: <ipcmjp$krd$4@dough.gmane.org>
References: <ipckgd$krd$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 23:36:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFYsn-0001bc-4I
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 23:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755608Ab1D1VgQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 17:36:16 -0400
Received: from lo.gmane.org ([80.91.229.12]:57575 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754366Ab1D1VgP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 17:36:15 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QFYsf-0001Wu-BG
	for git@vger.kernel.org; Thu, 28 Apr 2011 23:36:13 +0200
Received: from static-78-8-147-77.ssp.dialog.net.pl ([78.8.147.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 23:36:13 +0200
Received: from mwisnicki by static-78-8-147-77.ssp.dialog.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 23:36:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: static-78-8-147-77.ssp.dialog.net.pl
User-Agent: Pan/0.134 (Wait for Me; Unknown)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172411>

On Thu, 28 Apr 2011 20:59:57 +0000, Marcin Wi=C5=9Bnicki wrote:

> I have to import part of public cvs repository that is protected by
> password (which is "anoncvs"):
>=20
>> export CVSROOT=3D:pserver:anoncvs@anoncvs.fr.FreeBSD.org:/home/ncvs =
cvs
>> login
>=20

I have tried another mirror that uses ssh:

> export CVSROOT=3D:ext:anoncvs@anoncvs1.FreeBSD.org:/home/ncvs
> export SSH_RSH=3Dssh

And this also does not work because git tries to use rsh.
According to google this should work.

Any ideas why cvsimport is so broken for me ?
