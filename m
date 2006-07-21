From: "Mika Muukkonen" <mika.muukkonen@plenware.fi>
Subject: git clone / SHA1 mismatch
Date: Fri, 21 Jul 2006 07:55:05 +0300
Message-ID: <007e01c6ac81$d523a700$76401f0a@almare2.tre>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Fri Jul 21 06:54:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3n2L-0005EO-A0
	for gcvg-git@gmane.org; Fri, 21 Jul 2006 06:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbWGUEyO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Jul 2006 00:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbWGUEyO
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Jul 2006 00:54:14 -0400
Received: from mail.almare.com ([217.152.87.228]:30125 "EHLO mail.almare.com")
	by vger.kernel.org with ESMTP id S1030449AbWGUEyN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jul 2006 00:54:13 -0400
Received: from mail2.almare.tre ([10.31.7.225])
	by mail.almare.com with esmtp (Exim 3.35 #1 (Debian))
	id 1G3n1g-0001Jz-00
	for <git@vger.kernel.org>; Fri, 21 Jul 2006 07:54:12 +0300
Received: from p027.almare2.tre ([10.31.9.146] helo=p027)
	by mail2.almare.tre with esmtp (Exim 4.34)
	id 1G3n1M-0008Nc-L1
	for git@vger.kernel.org; Fri, 21 Jul 2006 07:53:52 +0300
To: <git@vger.kernel.org>
X-Mailer: Microsoft Office Outlook 11
x-mimeole: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: AcasgdUJwVm9pq8nQ3O9txpslwvk/w==
X-Almare-MailScanner: Found to be clean
X-MailScanner-From: mika.muukkonen@plenware.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24042>

Greetings,

when attempting to clone repositories (Linus's kernel, stable 2.6.16, OMAP kernel) I seem to come across the following more or less constantly:

mmu@spud1:/var/git$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git linux-2.6.16
Generating pack...
Done counting 195441 objects.
Deltifying 195441 objects.
 100% (195441/195441) done
fatal: unexpected EOF)      
fatal: packfile '/var/git/linux-2.6.16/.git/objects/pack/tmp-QeO4uB' SHA1 mismatch
error: git-fetch-pack: unable to read from git-index-pack
error: git-index-pack died with error code 128
fetch-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git' failed.

and

mmu@spud1:/var/git$ cg-clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git linux-2.6.16
defaulting to local storage area
Fetching pack (head and objects)...
Generating pack...
Done counting 190732 objects.
Deltifying 190732 objects.
 100% (190732/190732) done
fatal: unexpected EOF)      
fatal: packfile '.git/objects/pack/tmp-4BiKAb' SHA1 mismatch
error: git-fetch-pack: unable to read from git-index-pack
error: git-index-pack died with error code 128
cg-fetch: fetching pack failed

and... and...

I compiled a rather recent version of git:

mmu@spud1:/var/git$ git --version
git version 1.4.2.rc1.ge7a0

and the all other libs required are up-to-date as well.

So; am I missing something or should cloning of current trees at kernel.org go down smoothly. Any advice apprecieated.

Mika Muukkonen
