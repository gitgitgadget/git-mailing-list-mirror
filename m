From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [PATCH] Add MIME information to outgoing email
Date: Thu, 13 Mar 2008 20:05:55 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-03-13-20-05-55+trackit+sam@rfc1149.net>
References: <1205426419-4594-1-git-send-email-sam@rfc1149.net> <7vhcfaxxxk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 20:07:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZslI-0006mT-G1
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 20:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022AbYCMTGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 15:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216AbYCMTGE
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 15:06:04 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:37942 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbYCMTGD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 15:06:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id D3483E3713;
	Thu, 13 Mar 2008 20:06:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7NyCV1WZBYVE; Thu, 13 Mar 2008 20:05:56 +0100 (CET)
Received: from dawn.rfc1149.net (unknown [192.168.9.2])
	by mail.rfc1149.net (Postfix) with ESMTP id C9941E11CF;
	Thu, 13 Mar 2008 20:05:55 +0100 (CET)
Received: by dawn.rfc1149.net (Postfix, from userid 1000)
	id 406D68065; Thu, 13 Mar 2008 20:05:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vhcfaxxxk.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77129>

On 13/03, Junio C Hamano wrote:

| Samuel Tardieu <sam@rfc1149.net> writes:
| 
| > Add MIME-Version/Content-Type/Content-Transfer-Encoding headers in
| > messages generated with git-format-patch. Without it, messages generated
| > without using --attach or --inline didn't have any content type information.
| 
| Isn't that job for send-email (or user's MUA)?  I really do not think we
| want to clutter format-patch output any more than necessary.

Only format-patch knows what encoding has been used by itself to
generate the message. Doing it at any later stage would have to guess
what the correct charset is.
