From: James Cloos <cloos@jhcloos.com>
Subject: Packing speed
Date: Sun, 07 Jun 2015 13:41:28 -0400
Message-ID: <m3fv632z7b.fsf@carbon.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 07 19:52:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1ek8-0000SC-3X
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 19:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbbFGRwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 13:52:12 -0400
Received: from ore.jhcloos.com ([198.147.22.87]:47469 "EHLO ore.jhcloos.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753382AbbFGRv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 13:51:58 -0400
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jun 2015 13:51:58 EDT
Received: by ore.jhcloos.com (Postfix, from userid 10)
	id E5F1B1E156; Sun,  7 Jun 2015 17:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=ore14; t=1433699013;
	bh=3s2u7APPFVfxmk4s/EcLuvVLk6XmID+2pkUdwPS/ytM=;
	h=From:To:Subject:Date:From;
	b=h/JmJYDw7EtWJyYIQH7hZyIr1q42+vYmCHWOxQwnIqdutCfMgzUlvwqo0azbs0Tea
	 eANYgwPW6T12KVkGKqNhT16JHWDRKx5ecWhVTB8THwaPGVaXsU3kneCH2bus4sdeww
	 AcIl6d8mNa3be+/PFTJoGyh7Va+0AtqiQfT8kCzc=
Received: by carbon.jhcloos.org (Postfix, from userid 500)
	id 6606B106FD880; Sun,  7 Jun 2015 17:41:28 +0000 (UTC)
User-Agent: Gnus/5.130012 (Ma Gnus v0.12) Emacs/25.0.50 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAgMAAABinRfyAAAACVBMVEX///8ZGXBQKKnCrDQ3
 AAAAJElEQVQImWNgQAAXzwQg4SKASgAlXIEEiwsSIYBEcLaAtMEAADJnB+kKcKioAAAAAElFTkSu
 QmCC
Copyright: Copyright 2015 James Cloos
OpenPGP: 0x997A9F17ED7DAEA6; url=https://jhcloos.com/public_key/0x997A9F17ED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
X-Hashcash: 1:28:150607:git@vger.kernel.org::AhbHhvryPhb9BGS7:00000000000000000000000000000000000000000hYbT4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270977>

With 2.4.2 I'm seeing *very* poor packing performance on my workstation.

The 2nd stage, where it does open/mmap/close/munmap on each of the
object files is processing only about 60 per socond.

Hundreds or even thousands per second seems like a reasonable
expectation, not mealy dozens.

Is my expectation wrong?

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 0x997A9F17ED7DAEA6
