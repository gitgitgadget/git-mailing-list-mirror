From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Re: Problem with git-cvsimport
Date: Tue, 9 Oct 2007 14:47:49 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200710091447.50501.wielemak@science.uva.nl>
References: <470B491F.9020306@jentro.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Pasch <thomas.pasch@jentro.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 14:54:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfEb2-0004UG-G2
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 14:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbXJIMxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 08:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752801AbXJIMxu
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 08:53:50 -0400
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:1312 "EHLO
	smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbXJIMxt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 08:53:49 -0400
Received: from gollem.science.uva.nl (gollem.science.uva.nl [146.50.26.20])
	(authenticated bits=0)
	by smtp-vbr4.xs4all.nl (8.13.8/8.13.8) with ESMTP id l99CrgMW041591;
	Tue, 9 Oct 2007 14:53:43 +0200 (CEST)
	(envelope-from wielemak@science.uva.nl)
User-Agent: KMail/1.9.5
In-Reply-To: <470B491F.9020306@jentro.com>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60400>

On Tuesday 09 October 2007 11:25, Thomas Pasch wrote:
> Hello,
>
> using git-cvsimport (1.5.3.4), it dies with
>
> Update
> guidance-common/src/java/com/jentro/manager/guidance/common/servlet/IconSer
>vlet.java: 2104 bytes
> Tree ID 01cb84cbee2e70a712459be6601b993603eed5bd
> Parent ID dcd8dc76f4638d1994165070c9813202992d546a
> Committed patch 3775 (bmw +0000 2004-10-14 11:10:43)
> Commit ID 53c68066f71651b057884e1101cda3967070724d
> Fetching
> guidance-common/src/java/com/jentro/manager/guidance/common/serverapi/Guida
>nceException.java v 1.14.4.2
> Update
> guidance-common/src/java/com/jentro/manager/guidance/common/serverapi/Guida
>nceException.java: 3718 bytes
> Tree ID 886268190ac2cb28b5f1e6cdb309054bcb8fa38e
> Parent ID 53c68066f71651b057884e1101cda3967070724d
> Merge parent branch: master
> fatal: Not a valid object name master
> Use of uninitialized value in chomp at /usr/bin/git-cvsimport line 766.
> Use of uninitialized value in pattern match (m//) at
> /usr/bin/git-cvsimport line 527.
> Use of uninitialized value in concatenation (.) or string at
> /usr/bin/git-cvsimport line 767.
> Cannot get commit id ():
>
> What can I do to avoid this problem?

I've had some similar problem.  I've converted two big old repositories by
first converting to SVN using:

	cvs2svn -s myrepo-svn /path/to/cvsmodule
	git-svnimport -i -u -C /path/to-git file://myrepo-svn

Worked like a charm

	Cheers --- Jan
