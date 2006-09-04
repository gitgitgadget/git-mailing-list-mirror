From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/5] Some autoconf patches
Date: Tue, 5 Sep 2006 00:54:24 +0200
Message-ID: <200609050054.24279.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 05 00:58:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKNOj-0007dB-VW
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 00:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWIDW6b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 18:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWIDW6b
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 18:58:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:3608 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751235AbWIDW6a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 18:58:30 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1112901nfa
        for <git@vger.kernel.org>; Mon, 04 Sep 2006 15:58:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=S7g4fd17FwQ4bsHeNIOEF3rQA7AosmguIbT+TjhWlPRZ4P+N45l5AFm8fQbED9pYRWOz/pAZIoZc+kSBHv5fstPQ9VdDsqLkowYwilJQe4+XjJ8mm52hbfiAyyath5hyBS1BUMjap8Vflz7iQDV/vdTV3x7mSpyPWI2XCJH1tys=
Received: by 10.48.210.20 with SMTP id i20mr7140731nfg;
        Mon, 04 Sep 2006 15:58:29 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id l38sm10135925nfc.2006.09.04.15.58.27;
        Mon, 04 Sep 2006 15:58:28 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26442>

This is set of a few autoconf patches, based on 'master' 
  (commit 6b4fd65cce00d4adb5dd3ed2960ba355057c5a97)
What is left is check if "libc/libiconv properly support iconv.",
i.e. NO_ICONV check.

Summary:
---
 config.mak.in |    2 ++
 configure.ac  |   22 ++++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)


Shortlog:
 * [PATCH 1/5] autoconf: Add some commented out variables to config.mak.in
 * [PATCH 2/5] autoconf: Add -liconv to LIBS when NEEDS_LIBICONV
 * [PATCH 3/5] autoconf: Preliminary check for working mmap
 * [PATCH 4/5] autoconf: Check for subprocess.py
 * [PATCH 5/5] autoconf: Quote AC_CACHE_CHECK arguments
-- 
Jakub Narebski
ShadeHawk on #git
Poland
