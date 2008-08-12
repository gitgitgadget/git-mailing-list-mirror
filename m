From: Russell Steicke <russellsteicke@gmail.com>
Subject: [TopGit PATCH] Ignore tg-export and tg-export.txt.
Date: Tue, 12 Aug 2008 14:56:14 +0800
Message-ID: <20080812065614.GH11179@maggie.localnet>
Reply-To: Russell Steicke <russellsteicke@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Aug 12 08:57:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSnot-0003M1-OU
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 08:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbYHLG4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 02:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbYHLG4Y
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 02:56:24 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:17303 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbYHLG4X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 02:56:23 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2638177rvb.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 23:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:reply-to:mime-version:content-type:content-disposition
         :user-agent;
        bh=Dyoqk608U9FYga4JtBqAM2otkOLPAb/PrtXRlQEaRpA=;
        b=JXDIwqduvFgdms/ZKC2v+GdGnxFefQdss8h7RU/LmPzeGRyFYTpNKMEZNzZpkTgQiV
         nAofcAjxgarSEM0jKk/v7xVoa/VfArltBB2snjjz+KJU/z5XMUIIuAaDjC2nFPNhoNYK
         0NqsUsSQjRM3BfJdf+Gv0bnAmzBi/RR46DhmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-type:content-disposition:user-agent;
        b=clZn6cbtPoJAxnBDotUZ/WrxZ0HUiqASwchgEgze+0eLZMxQMA5GtV92aWJi3wdXJM
         Pa0Balo6zng8013txPIayu6AEFj9jFzlUfMXEPWi0XDoVMpyPAbfT7cuGxq48dbxIzlt
         +WAp7r61NMyLNWoK5Ue8Zd5/0W8ZYxR1qI6zE=
Received: by 10.140.178.17 with SMTP id a17mr4113289rvf.156.1218524181853;
        Mon, 11 Aug 2008 23:56:21 -0700 (PDT)
Received: from localhost ( [203.33.247.40])
        by mx.google.com with ESMTPS id g22sm2108429rvb.7.2008.08.11.23.56.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Aug 2008 23:56:20 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92071>

tg-export and tg-export.txt are generated files.

Signed-off-by: Russell Steicke <russellsteicke@gmail.com>

---
 .gitignore |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 6f0727f..2f7f3d3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -3,6 +3,8 @@ tg-create
 tg-create.txt
 tg-delete
 tg-delete.txt
+tg-export
+tg-export.txt
 tg-info
 tg-info.txt
 tg-patch
-- 
tg: (11a91e4..) t/gitignore-export (depends on: master)
