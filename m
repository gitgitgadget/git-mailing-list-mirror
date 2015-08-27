From: larsxschneider@gmail.com
Subject: [PATCH v7] git-p4: Obey core.ignorecase when using P4 client specs
Date: Thu, 27 Aug 2015 14:47:13 +0200
Message-ID: <1440679634-26738-1-git-send-email-larsxschneider@gmail.com>
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 27 14:47:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUwaU-0000RV-Lf
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 14:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbbH0MrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 08:47:20 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34726 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932202AbbH0MrS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 08:47:18 -0400
Received: by widdq5 with SMTP id dq5so76911178wid.1
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 05:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0ccsIcQeoVjTe+9hJNqxuN0IEZ9TZKnhCQ3ppcOdwTE=;
        b=Pv8jayVqdz/ZNspmfEd6TZERD9RrMpW5P3bLFoQvJaOQR51YmddR6YaDtlhD9x1a5M
         2bFVMgU5twqhQTISi5z3ctNlxQS3B81XDwcElF6pOk8yNtyFHDOsAIHh8hCTUCLLeOMI
         Gc3/LTm3Q0SAvYN2CndAflrqywLhIneU1uq9txog5heHvC4yPXAZaEehxRWk5Iawqcv5
         V3lync9E5LsfzYnu2t5RMuvT/zElq8DxmEZhpddXXphxudu1aL8FeSD5Z7xUmmFVqcgw
         YcL5M9xv3AVf6Bqm0mNAcdh7tDjhQzPaXoh++WgfG20TJ9tehRwOxi7uu/illeUqg5WV
         /2gA==
X-Received: by 10.194.22.33 with SMTP id a1mr4687750wjf.90.1440679636991;
        Thu, 27 Aug 2015 05:47:16 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id w8sm3482244wiy.10.2015.08.27.05.47.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Aug 2015 05:47:16 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276668>

From: Lars Schneider <larsxschneider@gmail.com>

I changed the commit message based on Junio's suggestion in the v6 thread and I changed the test case path names to match the commit message example.

Thanks,
Lars

Lars Schneider (1):
  git-p4: Obey core.ignorecase when using P4 client specs

 git-p4.py                         |   7 ++
 t/t9821-git-p4-path-variations.sh | 200 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+)
 create mode 100755 t/t9821-git-p4-path-variations.sh

--
1.9.5 (Apple Git-50.3)
