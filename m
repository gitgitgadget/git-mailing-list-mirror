From: "Gerald (Jerry) Carter" <jerry@samba.org>
Subject: Re: Problem with git-cvsimport
Date: Tue, 09 Oct 2007 08:21:13 -0500
Message-ID: <470B8049.1090308@samba.org>
References: <470B491F.9020306@jentro.com> <200710091447.50501.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Thomas Pasch <thomas.pasch@jentro.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 15:21:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfF1i-0001GM-Oi
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 15:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbXJINVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 09:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbXJINVY
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 09:21:24 -0400
Received: from mail.samba.org ([66.70.73.150]:49463 "EHLO lists.samba.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094AbXJINVY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 09:21:24 -0400
Received: from kayak.plainjoe.org (68-184-60-223.dhcp.mtgm.al.charter.com [68.184.60.223])
	by lists.samba.org (Postfix) with ESMTP id 656F71638C1;
	Tue,  9 Oct 2007 13:21:21 +0000 (GMT)
Received: from [127.0.0.1] (phzzbt.plainjoe.org [192.168.1.1])
	by kayak.plainjoe.org (Postfix) with ESMTP id 614E711703F;
	Tue,  9 Oct 2007 08:21:22 -0500 (CDT)
User-Agent: Thunderbird 1.5.0.13 (X11/20070824)
In-Reply-To: <200710091447.50501.wielemak@science.uva.nl>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60411>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jan Wielemaker wrote:

> I've had some similar problem.  I've converted two big old 
> repositories by first converting to SVN using:
> 
> 	cvs2svn -s myrepo-svn /path/to/cvsmodule
> 	git-svnimport -i -u -C /path/to-git file://myrepo-svn

I would actually plug using cvs2svn to convert directly to git.
See this thread for Michael's original announcement.

   http://marc.info/?l=git&m=118592701426175&w=2

I'm in the process of drafting Samba's own git repos from
the CVS and SVN history (http://gitweb.samba.org/).




cheers, jerry
=====================================================================
Samba                                    ------- http://www.samba.org
Centeris                         -----------  http://www.centeris.com
"What man is a man who does not make the world better?"      --Balian
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHC4BJIR7qMdg1EfYRAlQ4AKDctlXFv0kcT51sA6P99qjVrPJ+MgCfWkCB
wPSf6l06UIlz0HERasHbryg=
=zSSf
-----END PGP SIGNATURE-----
