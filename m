From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: fetch fails with a short read of received pack
Date: Thu, 09 Oct 2008 22:24:15 +0200
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-10-09-22-24-15+trackit+sam@rfc1149.net>
References: <20081009195518.GA1497@blimp.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 22:25:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko24o-0006LR-CQ
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 22:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbYJIUY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 16:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753844AbYJIUY1
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 16:24:27 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:47617 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbYJIUY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 16:24:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id 3807CE2B7B;
	Thu,  9 Oct 2008 22:24:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hU2B0fptMe8s; Thu,  9 Oct 2008 22:24:17 +0200 (CEST)
Received: from mail2.rfc1149.net (unknown [IPv6:2a01:e35:1382:f950::3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by mail.rfc1149.net (Postfix) with ESMTPS id E9D86E32A6;
	Thu,  9 Oct 2008 22:24:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 19569C40BC;
	Thu,  9 Oct 2008 22:24:16 +0200 (CEST)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0R+XxwG2Sk9w; Thu,  9 Oct 2008 22:24:15 +0200 (CEST)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id E55F6C40BD; Thu,  9 Oct 2008 22:24:15 +0200 (CEST)
In-Reply-To: <20081009195518.GA1497@blimp.localhost> (Alex Riesen's message of "Thu\, 9 Oct 2008 21\:55\:18 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97881>

>>>>> "Alex" == Alex Riesen <raa.lkml@gmail.com> writes:

Alex> Somehow I got my gnulib mirror to a strange state where I can't
Alex> fetch anything from it:

You're the third person to report this problem in three days (I was
the second one). I thought my repository or the upstream one (GCC) was
corrupted in some ways, but it looks like a general problem.

Alex> fatal: premature end of pack file, 1745 bytes missing
Alex> fatal: index-pack failed

Alex> This is with current Shawn's master (Junio's master erroneously
Alex> gives an error).

The error message has been fixed three days ago, it hasn't reached
Junio's repository yet.

Alex> Bisect points at ac0463ed44e859c84e354cd0ae47d9b5b124e112

Incidentally, my first "git fetch" problem was around September 8 if I
remember correctly, so this looks plausible to have had the bug around
the date of the commit you mention (Aug 29).

 Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
