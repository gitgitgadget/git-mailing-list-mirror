From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Remove "historical" objects from repository to save place
Date: Sat, 21 Jan 2006 22:18:50 +0300
Message-ID: <200601212218.51055.arvidjaar@mail.ru>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jan 21 20:19:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0OGN-0001MT-UF
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 20:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWAUTTA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 14:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWAUTTA
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 14:19:00 -0500
Received: from mx3.mail.ru ([194.67.23.149]:42799 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S932256AbWAUTS7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 14:18:59 -0500
Received: from [83.237.195.229] (port=17136 helo=cooker.home.net)
	by mx3.mail.ru with asmtp 
	id 1F0OGH-000FNS-00
	for git@vger.kernel.org; Sat, 21 Jan 2006 22:18:58 +0300
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15004>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Is it possible to conserve space by removing old versions? Let's say I am not 
interested in kernel versions before 2.6.15 - is it possible to remove them 
from repository cloned from one of "official" ones (Linus or stable).

Description of git-prune suggests that it may be possible by removing tags 
from refs/tags; OTOH I may have commit chain that will prevent them. Also 
won't those tags come back after git fetch --tags?

TIA

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD0okaR6LMutpd94wRAqEZAKC5VAkNMlL9TEmgELynIUf24Dd9oQCeOejQ
Mdmc4lFsYXBHqofjQhgEIlU=
=2j5N
-----END PGP SIGNATURE-----
