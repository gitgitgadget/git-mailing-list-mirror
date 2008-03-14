From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [PATCH] Add MIME information to outgoing email
Date: Fri, 14 Mar 2008 15:40:29 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-03-14-15-40-29+trackit+sam@rfc1149.net>
References: <1205426419-4594-1-git-send-email-sam@rfc1149.net> <20080313170016.GA3439@sigill.intra.peff.net> <2008-03-13-18-14-36+trackit+sam@rfc1149.net> <20080314132949.GC2932@coredump.intra.peff.net> <2008-03-14-14-40-22+trackit+sam@rfc1149.net> <20080314134600.GA3968@coredump.intra.peff.net> <2008-03-14-14-50-48+trackit+sam@rfc1149.net> <20080314143536.GA5362@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 15:41:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaB60-0001Ce-Cz
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 15:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbYCNOkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 10:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbYCNOkk
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 10:40:40 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:35245 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbYCNOkj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 10:40:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id 762E3E2CED;
	Fri, 14 Mar 2008 15:40:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oXrSTt6zKUQr; Fri, 14 Mar 2008 15:40:30 +0100 (CET)
Received: from mail2.rfc1149.net (unknown [IPv6:2a01:5d8:5138:2f95::3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by mail.rfc1149.net (Postfix) with ESMTP id B3D6BE0481;
	Fri, 14 Mar 2008 15:40:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id CEEFAC408D;
	Fri, 14 Mar 2008 15:40:29 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9-93tZY1kBf3; Fri, 14 Mar 2008 15:40:29 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id AA5BAC40B8; Fri, 14 Mar 2008 15:40:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080314143536.GA5362@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77232>

On 14/03, Jeff King wrote:

| No, I don't. Having peeked a few days ago at the pretty-printing code,
| that is almost certainly the problem (I think the extra_headers
| parameter is overloaded to handle both of these conditions). Can you
| work up a patch?

Sure, but not before some time, I am quite busy with urgent work right
now. If you want to beat me at it, be my guest :)
