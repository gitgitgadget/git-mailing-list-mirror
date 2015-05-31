From: Bruce Korb <bruce.korb@gmail.com>
Subject: seg fault in "git format-patch"
Date: Sun, 31 May 2015 12:13:16 -0700
Message-ID: <556B5D4C.4030406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: GIT Development <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 31 21:13:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yz8fm-0004Rj-Pt
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 21:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbbEaTNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 15:13:21 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:32997 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbbEaTNU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 15:13:20 -0400
Received: by pdbqa5 with SMTP id qa5so91674594pdb.0
        for <git@vger.kernel.org>; Sun, 31 May 2015 12:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=HJWGQeO7r7sVvaPUTt+uy2bf2sASru8UFfBuggPFnro=;
        b=QbFgrjqE7IWCTZpjNjQTCq138Ty72qaEjZGpwgi6vgaAIlgssaAum+baI1yZ8qre7C
         XJqA15y44fHNxDIY4MaHz2h2B7dGmCki+RR+iI1SC8ba8WAXMw35SHLR4ehGd3mXr+Ak
         NMeW04djTrlzGt3cCmVhfe2xBJceHygY9whhHbevFDOb9M5cONfTHMGFmZtMK6yEZw3E
         IvJtvBmOCXTGOj80iguQ0LdWt0+5dD8v4Q5PAy+0EwHWEns0hjgXFs7ZixpQ5Lf1w3Ur
         lp5Pvsz0o4i+SlaFH82hHmjzGQtN9W3ILyf+osUlvFsAOJG1+jqjWu5Ri2rlgPbdGIlz
         rpLA==
X-Received: by 10.66.236.39 with SMTP id ur7mr33982566pac.123.1433099599621;
        Sun, 31 May 2015 12:13:19 -0700 (PDT)
Received: from [172.16.16.2] (adsl-75-18-229-172.dsl.pltn13.sbcglobal.net. [75.18.229.172])
        by mx.google.com with ESMTPSA id o3sm11966712pds.1.2015.05.31.12.13.17
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2015 12:13:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270345>

$ git format-patch -o patches --ignore-if-in-upstream 14949fa8f39d29e44b43f4332ffaf35f11546502..2de9eef391259dfc8748dbaf76a5d55427f37b0d
Segmentation fault
/u/gnu/proj/gnu-pw-mgr
$ git format-patch -o patches 14949fa8f39d29e44b43f4332ffaf35f11546502..2de9eef391259dfc8748dbaf76a5d55427f37b0d
patches/0001-remove-dead-code.patch
patches/0002-dead-code-removal.patch
patches/0003-add-sort-pw-cfg-program.patch
patches/0004-add-doc-for-sort-pw-cfg.patch
patches/0005-clean-up-doc-makefile.patch
patches/0006-clean-up-doc-makefile.patch
patches/0007-happy-2015-and-add-delete-option.patch
patches/0008-fix-doc-Makefile.am.patch
patches/0009-re-fix-copyright.patch
patches/0010-finish-debugging-remove_pwid.patch
patches/0011-only-update-file-if-something-was-removed.patch
patches/0012-update-NEWS.patch
patches/0013-bootstrap-cleanup.patch
