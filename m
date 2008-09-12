From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [StGit PATCH] add option to import series directly from a tar archive
Date: Fri, 12 Sep 2008 15:59:45 +0200
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-09-12-15-59-45+trackit+sam@rfc1149.net>
References: <48C34EC7.9040102@gmail.com>
	<20080908180317.GA6123@diana.vm.bytemark.co.uk>
	<48C56AD9.6040007@gmail.com>
	<2008-09-12-14-21-13+trackit+sam@rfc1149.net>
	<48CA674B.9080900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Clark Williams <clark.williams@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 16:01:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke9Cw-0005W8-8B
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 16:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbYILOAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 10:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752728AbYILOAA
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 10:00:00 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:55624 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbYILOAA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 10:00:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id 07158E0547;
	Fri, 12 Sep 2008 15:59:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N0QpfaCpa7-0; Fri, 12 Sep 2008 15:59:50 +0200 (CEST)
Received: from mail2.rfc1149.net (unknown [IPv6:2a01:e35:1382:f950::3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by mail.rfc1149.net (Postfix) with ESMTPS id 0F7ABE05E5;
	Fri, 12 Sep 2008 15:59:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id C200AC40BC;
	Fri, 12 Sep 2008 15:59:45 +0200 (CEST)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GvABuShNfzgm; Fri, 12 Sep 2008 15:59:45 +0200 (CEST)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 990C1C40BD; Fri, 12 Sep 2008 15:59:45 +0200 (CEST)
In-Reply-To: <48CA674B.9080900@gmail.com> (Clark Williams's message of "Fri\, 12 Sep 2008 07\:57\:47 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95726>

>>>>> "Clark" == Clark Williams <clark.williams@gmail.com> writes:

Clark> Zowie, I thought I only had to worry about folks sending
Clark> patches with incomplete information. So you get patches to the
Clark> ada compiler that are rooted in gcc/ada (e.g.  patch in tarball
Clark> says "./ChangeLog", instead of gcc/ada/ChangeLog) rather than
Clark> at a top level? Only way I could see to deal with that would be
Clark> to try and pass in the appropriate prefix from the command
Clark> line.

Yes, passing the prefix and strip levels would be fine.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
