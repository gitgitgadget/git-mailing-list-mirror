From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v4] git-rebase--interactive.sh: add config option for custom instruction format
Date: Thu, 11 Jun 2015 22:23:27 -0400
Message-ID: <1434075808-43453-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, johannes.schindelin@gmx.de
X-From: git-owner@vger.kernel.org Fri Jun 12 04:23:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3EdO-0002S7-TN
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 04:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbbFLCXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 22:23:42 -0400
Received: from mail-vn0-f41.google.com ([209.85.216.41]:39317 "EHLO
	mail-vn0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbbFLCXl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 22:23:41 -0400
Received: by vnbg190 with SMTP id g190so3760862vnb.6
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 19:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=JLvlOB3yB78FaI+ktl+TfKUzzyDqozHTv3u8Z7z5ao4=;
        b=TeR7QIjmDKnoLgl6//KL6i3N642jGEEWnbhmbql3qLPC1asWVV/A+47Jp3MTTzg3rl
         nnT9jcEIYYCkN2iiQ7DdxXJSttft14lZNcXjNInmxccH96KGKrXOakTpMT2BKBoa5j74
         8E+KDNg2zTsVuMzcrnh6M8GwTD4o5KwDUcrOmEMEFphDIje0qfYCtbxItsdVfwpzp2Sq
         LgPYj4j4jjkou62x+Vw/xyDdejliDARLS0HGvvNcyTGxZBp59B32afEn7ve7Gb+fQ6Vq
         CvulBFmIqXVadpPLZKqD5NK/55Nclhf7nfWWQYkDR+4ovwWBc6fXJGizKf6gcgtp4b5W
         5iYg==
X-Received: by 10.52.126.11 with SMTP id mu11mr21721946vdb.8.1434075820960;
        Thu, 11 Jun 2015 19:23:40 -0700 (PDT)
Received: from MRappazzo-2.local.info (ool-18e49664.dyn.optonline.net. [24.228.150.100])
        by mx.google.com with ESMTPSA id p13sm3010344vdj.15.2015.06.11.19.23.39
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 19:23:40 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271466>

Difference between v3 and v4 of this patch:

    - cleaned up changes in rearrange_squash() function
    - consolidated autosquash test 

Michael Rappazzo (1):
  git-rebase--interactive.sh: add config option for custom instruction
    format

 Documentation/git-rebase.txt |  7 +++++++
 git-rebase--interactive.sh   | 20 +++++++++++++++++---
 t/t3415-rebase-autosquash.sh | 21 +++++++++++++++++++++
 3 files changed, 45 insertions(+), 3 deletions(-)

-- 
2.4.2
