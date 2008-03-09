From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: Remotes order in "git remote update"
Date: Sun, 9 Mar 2008 12:21:35 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-03-09-12-21-35+trackit+sam@rfc1149.net>
References: <2008-03-09-11-22-34+trackit+sam@rfc1149.net> <7vbq5op4gt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 12:31:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYJkk-0006j1-6V
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 12:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbYCILbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 07:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbYCILbD
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 07:31:03 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:60271 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbYCILbB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 07:31:01 -0400
X-Greylist: delayed 559 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Mar 2008 07:31:01 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id 6D2FFE0645;
	Sun,  9 Mar 2008 12:21:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sfr10WWw03cw; Sun,  9 Mar 2008 12:21:35 +0100 (CET)
Received: from dawn.rfc1149.net (unknown [192.168.9.2])
	by mail.rfc1149.net (Postfix) with ESMTP id B2372E04BF;
	Sun,  9 Mar 2008 12:21:35 +0100 (CET)
Received: by dawn.rfc1149.net (Postfix, from userid 1000)
	id 6F40E80AF; Sun,  9 Mar 2008 12:21:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vbq5op4gt.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76654>

On  9/03, Junio C Hamano wrote:

| Samuel Tardieu <sam@rfc1149.net> writes:
| 
| > It looks like remote repositories are ordered alphabetically by their
| > local names when doing a "git remote update".
|
| I think the reimplementaiton in 'next' that will hopefully be in 1.5.5
| will keep the list of remotes in the order read from the config.

Indeed it does, thanks.

