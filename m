From: Samuel Tardieu <sam@rfc1149.net>
Subject: Invalid refspec?
Date: Thu, 20 Mar 2008 11:53:31 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-03-20-11-53-31+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 11:54:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcIPj-0002U5-Hv
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 11:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbYCTKxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 06:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbYCTKxn
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 06:53:43 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:53064 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbYCTKxm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 06:53:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id E6149E08F1
	for <git@vger.kernel.org>; Thu, 20 Mar 2008 11:53:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cdNS9WbIK3jr for <git@vger.kernel.org>;
	Thu, 20 Mar 2008 11:53:32 +0100 (CET)
Received: from mail2.rfc1149.net (unknown [IPv6:2a01:5d8:5138:2f95::3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by mail.rfc1149.net (Postfix) with ESMTPS id 6FCF5E0496
	for <git@vger.kernel.org>; Thu, 20 Mar 2008 11:53:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 7AC2DC408D;
	Thu, 20 Mar 2008 11:53:31 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RtpVOYTg1KTX; Thu, 20 Mar 2008 11:53:31 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 4A1BDC40B8; Thu, 20 Mar 2008 11:53:31 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77649>

I am using git master branch locally (1.5.5.rc0.133.g7e207), and the
server is using 1.5.4.rc3.g16335. I want to push my HEAD~1 revision
into the 2.0 branch on the server, and it looks like it is not
expanded anymore in the refspec:

% git push origin HEAD~1:2.0
fatal: Invalid refspec 'HEAD~1:2.0'
fatal: The remote end hung up unexpectedly

Isn't HEAD~1 supposed to be expanded locally? Using the SHA-1 instead
of HEAD~1 works fine.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
