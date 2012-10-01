From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH] gitk: Add workaround for system where Shift-F5 mapped to Shift-XF86_Switch_VT_5
Date: Mon,  1 Oct 2012 11:16:03 -0400
Message-ID: <1349104564-30812-1-git-send-email-andrew.kw.w@gmail.com>
Cc: szeder@ira.uka.de, paulus@samba.org,
	Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 01 17:17:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIhjt-0001An-27
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 17:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679Ab2JAPQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 11:16:46 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:56190 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab2JAPQq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 11:16:46 -0400
Received: by ieak13 with SMTP id k13so12350834iea.19
        for <git@vger.kernel.org>; Mon, 01 Oct 2012 08:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=/Clt0Cz1FeDx1gCNPRrI72ky/5CYKCHwzBFsNJbp6Lk=;
        b=wCZTgDXLzJ3ZXaivy7uj+F9/cbWFras3PrILRbNSQe0Ngtu2ErvXkguIk22/gyMVC7
         x30OllDaqBOSgqYvFB2DbdbAFElcy4uNSMUsy6AUojPJXzVPFtB2p9ZKwDp2i14SxBhy
         mu9lXt7E1BfyjI8aXLvhDHWPMn5rNc3vqpKBZwaE6oS9/jS212NwxDQ/OYT3evjyfqeE
         UOuA1HwQtn/gNz69twy4mp4BicjW6deIE7zNojyIkZ5fx/Y425FqhHwm1VQBDm0VjuGz
         6FTPplT+pdnUZ+cgn00eLxXVFVtSACSFQI80QSB9Hyml3eoTiYDvX/HGPc+v17Ha6g9+
         QrZw==
Received: by 10.50.190.234 with SMTP id gt10mr6041127igc.20.1349104604190;
        Mon, 01 Oct 2012 08:16:44 -0700 (PDT)
Received: from nigel.sohovfx.com ([66.207.196.114])
        by mx.google.com with ESMTPS id uj6sm7184834igb.4.2012.10.01.08.16.39
        (version=SSLv3 cipher=OTHER);
        Mon, 01 Oct 2012 08:16:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.382.gb0576a6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206735>

I was running into the same issue too. It turns out that on some machines
Shift-F5 is mapped to Shift-XF86_Switch_VT_5. My patch includes a workaround.
The same workaround was used for Shift-F4.

Andrew Wong (1):
  gitk: Add workaround for system where Shift-F5 mapped to
    Shift-XF86_Switch_VT_5

 gitk-git/gitk | 1 +
 1 file changed, 1 insertion(+)

-- 
1.7.12.1.382.gb0576a6
