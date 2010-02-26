From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 0/4] git-grep documentation updates
Date: Thu, 25 Feb 2010 22:40:09 -0500
Message-ID: <1267155613-22134-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 04:45:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkr8i-0003B1-00
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 04:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935138Ab0BZDpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 22:45:14 -0500
Received: from mail-qy0-f199.google.com ([209.85.221.199]:40858 "EHLO
	mail-qy0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935135Ab0BZDpM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 22:45:12 -0500
X-Greylist: delayed 498 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Feb 2010 22:45:12 EST
Received: by qyk37 with SMTP id 37so1503033qyk.20
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 19:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=y0SlzK9/F4mai/nDMLwVNQFSc5K2AobuNFGYbjS8Ei4=;
        b=t2Zv5n8WTNNAM4DGZtTYxJJVbsePqbcg0G9nQ2uNcRTS1hLFnDv7HOA5H1eGE9Hryy
         t/v6lC6TiZ0fhpSCX7Iasd7y5dwbunah3Yuecg1TF8+eLPwi7nY6aSUqKkHNzrNzTSXh
         HLQUXQHlQ8YGLE/RfENb0vzg4q1DhG4AfTVo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Sc7PFNYBm0+Y/+twn2XOua8B75LXMQ/fN8pkcD6+8yi5/DAEjT8ORgWBGVTGeHDqeL
         7DHe/oDKsj3O9RCONQiKZrlWKgrn1hF9e6xXRGnIOCsxEk3wDOdj44LAd9c20OPtRNbT
         NBgJ5zMYx9/Yq5WsnUBdZCyoSfABuCLGOiNLo=
Received: by 10.229.38.69 with SMTP id a5mr138405qce.15.1267155413264;
        Thu, 25 Feb 2010 19:36:53 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 22sm1593622qyk.6.2010.02.25.19.36.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Feb 2010 19:36:52 -0800 (PST)
X-Mailer: git-send-email 1.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141098>

This patch series contains some small changes to git-grep.txt.  It is
based on my previous "grep documentation: clarify what files match",
committed to master as 3ac44408.  I posted these as four separate
patches to document each change individually, but they could be squashed
into one if that is preferable.

Mark Lodato (4):
  grep docs: pluralize "Example" section
  grep docs: use AsciiDoc literals consistently
  grep docs: --cached and <tree>... are incompatible
  grep docs: document --no-index option

 Documentation/git-grep.txt |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)
