From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [PATCH] Add MIME information to outgoing email
Date: Fri, 14 Mar 2008 12:57:06 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-03-14-12-57-06+trackit+sam@rfc1149.net>
References: <1205426419-4594-1-git-send-email-sam@rfc1149.net> <7vhcfaxxxk.fsf@gitster.siamese.dyndns.org> <2008-03-13-20-05-55+trackit+sam@rfc1149.net> <20080314112139.GA12846@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brian Swetland <swetland@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 12:58:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja8Y1-0008Ns-DI
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 12:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbYCNL5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 07:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367AbYCNL5Q
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 07:57:16 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:33516 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbYCNL5P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 07:57:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id 6624EE049C;
	Fri, 14 Mar 2008 12:57:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FrE4tzifuSb4; Fri, 14 Mar 2008 12:57:07 +0100 (CET)
Received: from mail2.rfc1149.net (unknown [IPv6:2a01:5d8:5138:2f95::3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by mail.rfc1149.net (Postfix) with ESMTP id 3CC8EE0479;
	Fri, 14 Mar 2008 12:57:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 6B5C0C408D;
	Fri, 14 Mar 2008 12:57:06 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aDH2VF5N6Tgo; Fri, 14 Mar 2008 12:57:06 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 3FD69C40B8; Fri, 14 Mar 2008 12:57:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080314112139.GA12846@bulgaria.corp.google.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77210>

On 14/03, Brian Swetland wrote:

| > Only format-patch knows what encoding has been used by itself to
| > generate the message. Doing it at any later stage would have to guess
| > what the correct charset is.
| 
| When the encoded string is entirely ascii except for one or two characters
| (such as occurs in a lot of patches I handle from people with names
| not represented in plain ascii) guessing later on seems to run pretty
| high risk of guessing wrong.
| [...]
| Considering that UTF-8 is the expected default encoding (right?) for
| git metadata, it seems to be the sane thing to indicate if the default
| is unchanged.

Yup.
