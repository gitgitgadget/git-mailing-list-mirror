From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [PATCH] Document levenshtein.c
Date: Thu, 20 Nov 2008 13:00:31 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-11-20-13-00-31+trackit+sam@rfc1149.net>
References: <20081118185326.12721.71576.stgit@arrakis.enst.fr> <alpine.DEB.1.00.0811190151000.30769@pacific.mpi-cbg.de> <2008-11-19-09-42-45+trackit+sam@rfc1149.net> <alpine.DEB.1.00.0811191053250.30769@pacific.mpi-cbg.de> <7vhc63svsl.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0811201255120.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 20 13:01:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L38Dz-00082w-NU
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 13:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201AbYKTMAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 07:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755217AbYKTMAN
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 07:00:13 -0500
Received: from zoidberg.rfc1149.net ([91.121.19.179]:50328 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755010AbYKTMAM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 07:00:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id 8BBEE10F104;
	Thu, 20 Nov 2008 13:00:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from zoidberg.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xiB0fc1vpOhI; Thu, 20 Nov 2008 13:00:07 +0100 (CET)
Received: from mail2.rfc1149.net (willow.rfc1149.net [IPv6:2001:6f8:37a:2::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by zoidberg.rfc1149.net (Postfix) with ESMTPS id C7A2110EC28;
	Thu, 20 Nov 2008 13:00:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 71519C40BE;
	Thu, 20 Nov 2008 13:00:31 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wcmVa6Um+zU0; Thu, 20 Nov 2008 13:00:31 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 35B7AC40CD; Thu, 20 Nov 2008 13:00:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0811201255120.30769@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101410>

* Johannes Schindelin <Johannes.Schindelin@gmx.de> [2008-11-20 13:00:35 +0100]

| 	How about this?

I think it still lacks a note about what "deletion" and "insertion" means
(is that a character deleted from string1 to obtain string2 or the reverse?).
In most implementation, you use the same cost for insertion and deletion
so the function is symetrical, but this implementation is more powerful.
