From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [PATCH] Add MIME information to outgoing email
Date: Thu, 13 Mar 2008 18:14:36 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-03-13-18-14-36+trackit+sam@rfc1149.net>
References: <1205426419-4594-1-git-send-email-sam@rfc1149.net> <20080313170016.GA3439@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 18:15:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZr1a-0007ZP-JC
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 18:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbYCMROp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 13:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753767AbYCMROp
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 13:14:45 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:38116 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949AbYCMROo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 13:14:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id 7ECA1E2FB6;
	Thu, 13 Mar 2008 18:14:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A07H5ZtE3ab8; Thu, 13 Mar 2008 18:14:37 +0100 (CET)
Received: from mail2.rfc1149.net (unknown [IPv6:2a01:5d8:5138:2f95::3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by mail.rfc1149.net (Postfix) with ESMTP id 8C8D5E11CF;
	Thu, 13 Mar 2008 18:14:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id BEB4BC408D;
	Thu, 13 Mar 2008 18:14:36 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sk8+-ROYL5AJ; Thu, 13 Mar 2008 18:14:36 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 9AC1FC40B8; Thu, 13 Mar 2008 18:14:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080313170016.GA3439@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77106>

On 13/03, Jeff King wrote:

| It's supposed to handle this automatically if the commit message
| contains non-ascii characters. What version of git were you using?

A version from "next" from March 8:
ea6cde37d54121c5a1e1da51e1cd5cf27bfa3904 (+ 1 unrelated patch)

E.g, does "git format-patch a1eebf~1..a1eebf" add MIME headers for you
without my patch?
