From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [ANNOUNCE] Git Universal OS X Installer
Date: Tue, 6 Jan 2015 06:59:03 -0800
Message-ID: <8EAE9A2B-6029-4869-AE3A-B79DA0FADE54@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 16:06:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8VbE-00065x-Eh
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 15:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbbAFO7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 09:59:08 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:65374 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146AbbAFO7G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 09:59:06 -0500
Received: by mail-pa0-f41.google.com with SMTP id rd3so31253641pab.0
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 06:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:to:content-type:content-transfer-encoding:subject
         :mime-version:date;
        bh=aOTUetOhRzAenk+Y/cQTOYmsBDXBbaU7ws14iHXvO6o=;
        b=mT2T8uWZBGn+eMVFS9VBkVJf+zBCQLdj3HB6oZKuMuvy/0TbDCszyUunl+nMh93Vm6
         wvkUdMVuxZ0rZiD5wvWKTggbDXLTsuz1nzayiNZ8TKrx87A3sTz5nPOcxjYU2PqrJy47
         K0LzaTwckqA6oKxYngQZ7uhD1U1kFpJm0F4ewznXv4yFt7Aj1RxR7HdFyVH931QD1IcR
         sRMCMrU76gG/9nPmXc2dsD+J28pCNMnQOe2BoYpHdL8I0aSUBAPRnuID7SXkWXwskfYN
         SS2EJ8CI/WzSHyjEpIEIoV5T0oWuVQ+IwGzWP+9fMDqHnwofjUJTRwpPn8gGnW35+28g
         6WdQ==
X-Received: by 10.68.201.8 with SMTP id jw8mr30174141pbc.28.1420556345373;
        Tue, 06 Jan 2015 06:59:05 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ob4sm57269260pdb.48.2015.01.06.06.59.04
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 06:59:04 -0800 (PST)
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262068>

What is it?
-----------

A universal installer for Git on OS X supporting Mac OS X 10.4.8 or  
later including PowerPC/Intel and both 32 and 64 bit.


Isn't there one already?
------------------------

Yes, there is another OS X installer for Git available.  That one,  
however, did not meet my needs so I created this one and decided to  
share it in case anyone else has similar requirements.


Features
--------

* This installer includes PowerPC/Intel 32/64 bit binaries and runs on  
10.4.8 or later.  So if you're running PPC 10.5 on a G5 and need a 64- 
bit Git you're good to go.

* The Git translations ARE included and may optionally be chosen based  
on the System Preferences languages selection(s) instead of the LANG  
and related environment variables.

* Besides the man pages; the html docs, release notes, api, howto etc.  
docs are also included.

* This is a Secure Transport-based Git -- no OpenSSL is used.  This  
means all root certificates (by default) come from the standard OS X  
keychain location(s).  Both git imap-send and git send-email operate  
using Secure Transport in this build (via libcurl).

* git send-email, git imap-send and git instaweb work out-of-the-box  
with no additional software installation required.

* git subtree and git-credential-osxkeychain are included.

* A build of the curl command-line utility that uses Secure Transport  
is also included (may be optionally disabled in the installer) for  
convenience.

* A build of the GnuPG gpg utility (with docs) is included (may be  
optionally disabled in the installer) for signing/verifying  
convenience which also supports creating top secret strength RSA keys.

* A build of TopGit is included (may be optionally disabled in the  
installer) for patch management.

* Library headers are included  (may be optionally disabled in the  
installer) for ease of building a custom Git against the same  
libraries the installed Git uses.

* Provides a complete solution for using Git on Mac OS X 10.4.x and  
10.5.x including full support for https/imaps/ftps/smtps TLS  
certificates which use the SHA-2 family of hash functions (such as  
SHA-256).

* Fully supports TLS 1.2 when run on a version of OS X with TLS 1.2  
support (OS X 10.9 and later).

* Currently provides Git version 2.1.4 (with backports of the  
executable-config-file fix, reflog-reading fix and imap-send-via- 
libcurl patch).  Installers for later versions of Git are planned.


Downloads
---------

Download links (and hashes) for the 11 MiB installer (a .dmg image)  
are available at:

   http://mackyle.github.io/git-osx-installer/


-Kyle
