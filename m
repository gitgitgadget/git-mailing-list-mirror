From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH] Add git-http-backend to command-list.
Date: Sat, 26 Dec 2009 12:01:07 -0500
Message-ID: <1261846867-13780-1-git-send-email-tarmigan+git@gmail.com>
Cc: git@vger.kernel.org, Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 26 18:04:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOa3l-0004Al-1J
	for gcvg-git-2@lo.gmane.org; Sat, 26 Dec 2009 18:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbZLZRBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Dec 2009 12:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbZLZRBf
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Dec 2009 12:01:35 -0500
Received: from mail-qy0-f192.google.com ([209.85.221.192]:33093 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbZLZRBe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2009 12:01:34 -0500
Received: by qyk30 with SMTP id 30so4336155qyk.33
        for <git@vger.kernel.org>; Sat, 26 Dec 2009 09:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=BFq5iChZQIB9ULUOhsgrlVeqBoHGEiy/Y+ZC5iT/7DE=;
        b=WV+UFBhYk4MtDSlhLBzvtXns3TDlCcWJwzxs7cdqU4FGzhBGsf/ut0/lMc2JXK9YIU
         AAMwizM5gB3O8g0FZu60n+n4O1PEAGyIy20lkkanDU5/lk3Xlpf3kZz6w36l1pD/8Zer
         ciAMhWhbO+mdpWvSz38IFJO7UE0dFe9PdM1D4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=IydHYGAumNIGwuRjip45/vymVGoCTMQL90H1juW+2Sp8y/2U+eljtdmavQl5ORhB9w
         PcQvCeBZp/q8bPfAYFcJI4ZA7trFbtGpmk4ZHhFNu684d7q9+rwfHleYBDs5frej3HmI
         Zst50LxsedV9gXVsLeJszEI/FZSmpVOVNM9L0=
Received: by 10.224.97.200 with SMTP id m8mr6812170qan.141.1261846893904;
        Sat, 26 Dec 2009 09:01:33 -0800 (PST)
Received: from localhost.localdomain (c-69-141-159-197.hsd1.nj.comcast.net [69.141.159.197])
        by mx.google.com with ESMTPS id 22sm8997470qyk.2.2009.12.26.09.01.31
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Dec 2009 09:01:33 -0800 (PST)
X-Mailer: git-send-email 1.6.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135690>

Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---
 command-list.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index cc5d48b..95bf18c 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -49,6 +49,7 @@ git-grep                                mainporcelain common
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
 git-help				ancillaryinterrogators
+git-http-backend                        synchingrepositories
 git-http-fetch                          synchelpers
 git-http-push                           synchelpers
 git-imap-send                           foreignscminterface
-- 
1.6.6
