From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH] worktree:  list operation
Date: Sat,  8 Aug 2015 16:34:56 -0400
Message-ID: <1439066097-85217-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Sat Aug 08 22:35:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOApj-0000Pr-2N
	for gcvg-git-2@plane.gmane.org; Sat, 08 Aug 2015 22:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992702AbbHHUfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2015 16:35:06 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35213 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992525AbbHHUfF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2015 16:35:05 -0400
Received: by qkbm65 with SMTP id m65so47473167qkb.2
        for <git@vger.kernel.org>; Sat, 08 Aug 2015 13:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=T2zXWFBZGSgmFiIDlXhHsU9Ie1sYuFxeRMRj9vZW+BY=;
        b=Peou1NzHxeLfoYgbqH8tHHa9MMRZGu+CJACAqfTCf+rkIVffME3xEqtF8i/LdvYYzr
         GDT07me1lLbe6mCq3b8Z9CGbUpNvssUbGDQUUNsAxgOYL+uEDNP2g09iuGMpMeX+/mKe
         wP+LVEEqTNRMCxtvQ2XhWyAiBBsBa6E+wNd3XDbWxc+hoLSZpSLT/7kpf7Oj+tWIclS/
         fPJlccVa2mTlk7ozhUtWU3KSSlHNpjDKlat8C+vav6gHypitozhFG/8b2/7f5zuHutDt
         YXgrASVHW1bOajrbo3wMof/8/kcPxDkYB01yDX/VeX9Cky58mb/IrMSM1JpJPxdptXBH
         7Urw==
X-Received: by 10.55.48.11 with SMTP id w11mr25328546qkw.61.1439066104106;
        Sat, 08 Aug 2015 13:35:04 -0700 (PDT)
Received: from Macbook-wireless.gtnexus.info (ool-18e49664.dyn.optonline.net. [24.228.150.100])
        by smtp.gmail.com with ESMTPSA id 126sm7034451qhc.49.2015.08.08.13.35.02
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 08 Aug 2015 13:35:03 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275516>

I am attempting to add the 'git worktree list' command.  

I don't have a lot of c experience, so please double check that I am 
not missing something important.

Michael Rappazzo (1):
  worktree:  list operation

 Documentation/git-worktree.txt |  9 ++++-
 builtin/worktree.c             | 80 ++++++++++++++++++++++++++++++++++++++----
 t/t2027-worktree-list.sh       | 68 +++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+), 7 deletions(-)
 create mode 100755 t/t2027-worktree-list.sh

-- 
2.5.0
