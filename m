From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: commit a1f6baa5 (wrap long header lines) breaks my habit
Date: Tue, 24 May 2011 18:02:53 +0200
Organization: -no organization-
Message-ID: <20110524160253.GA7723@scotty.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 18:03:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOu4U-00015c-2b
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 18:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245Ab1EXQC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 12:02:57 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:51648 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360Ab1EXQC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 12:02:56 -0400
Received: from scotty.home (port-92-196-58-134.dynamic.qsc.de [92.196.58.134])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0Lfpnu-1PrF0G2xek-00oj0A; Tue, 24 May 2011 18:02:55 +0200
Received: from scotty.home (hs@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-9.4) with ESMTP id p4OG2rR3015231
	for <git@vger.kernel.org>; Tue, 24 May 2011 18:02:53 +0200
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id p4OG2rJT015230
	for git@vger.kernel.org; Tue, 24 May 2011 18:02:53 +0200
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
Content-Disposition: inline
X-Mailer: Mutt 1.5.20 (2009-06-14) http://www.mutt.org/
X-Editor: GNU Emacs 23.2.1 http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
X-GPG-Public-Key: gpg --keyserver keys.gnupg.net --recv-keys E4FCD563
X-GPG-key-ID/Fingerprint: 0xE4FCD563 / EF09 97BB 3731 7DC7 25BA 5C39 185C
 F986 E4FC D563
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.97 at scotty
X-Virus-Status: Clean
X-Provags-ID: V02:K0:ZctHNi/hE+6s1cQce8MUcbW+Z+xd6HNLFVhSYniGjPv
 DTdzPVQfKzpfj0sVrm/m8hEcr2eIDx0w8zbjCWz1S2kLHsChb9
 DWjfWeq/GyaXT10Pvn6rCL8vAJkayL+C/AU+AIUnPtgI4ASLQr
 W04c9zDCa7cPbWb7RLiP1wPNZuyFuYFV9dhl88Poxv4bRW/kUS
 D7Zgx28t4OWdtAmhOGoog==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174323>

Hello,

for rebasing I'm using normally

   git format-patch -k --stdout a..b | git am -k -3

With commit

  commit a1f6baa5c97abc8b579fa7ac7c4dc21971bdc048
  format-patch: wrap long header lines 
  (since >v1.7.4)

this isn't possible anymore for those patches which have more then 78
characters on the first line.

The wrapping of the lines in the commit message will not be seen when
commiting but when rebasing via format-patch.

Was this the intention of this change or was my sort of workflow just
not in focus?

Any suggestion?


Stefan
-- 
Stefan-W. Hahn                          It is easy to make things.
                                        It is hard to make things simple.
