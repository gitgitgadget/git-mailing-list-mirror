From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v2 0/16] Introduce index file format version 5
Date: Sun,  5 Aug 2012 23:48:57 +0200
Message-ID: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pcouds@gmail.com, robin.rosenberg@dewire.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 23:50:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy8ij-0001n4-7c
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 23:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755157Ab2HEVtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 17:49:49 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48918 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755137Ab2HEVts (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 17:49:48 -0400
Received: by eeil10 with SMTP id l10so649089eei.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 14:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=3uOUavqwqFaKqQnUnmtG9DrvWMA3kf8pICOBcAOAoEo=;
        b=Vq7Nx68k0mmuHQFT3t8QL/4X3Kd/OMpYIrEw3T6oCBquTwzEto4GFFrrqig6NO+5GF
         WrKP8pXv4m1MA9Jbwt1T3cNLpiRyj8gF2HNMFe8++d4Fb9BhlQNv2f5F2qVKtLriYWUl
         oCgrilcYDZ6E2d4Bc8diQBdM+Tof/lm0WV5tEYEgxvBWYT0IlVqAPTMpcEXlFMR4LYIl
         t7lqyyoF3IbDGp+VZ8uudB4Z92Kq/nLT+W+KQ54iLm1IlUlRZJYgONPYgc442Bx+sdZu
         L4xYvYMskW9uzzYRSC61IepEEQj0+KIv1h2ZkdWRWY+dathQIuo3v9R8hn+oI1yflu1h
         CSTw==
Received: by 10.14.0.198 with SMTP id 46mr4297814eeb.30.1344203387290;
        Sun, 05 Aug 2012 14:49:47 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id s8sm42271009eeo.8.2012.08.05.14.49.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Aug 2012 14:49:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202923>

Fist again apologies for those who were not credited in the first
version of this series.

The first version of the series was here: $gmane/202752.

Changes since the last version:

This series now applies to the latest master.

[PATCH/RFC v2 01/16] Modify cache_header to prepare for other index formats
Moved the cache_header structs to read-cache.c and redefined
cache_version_header in test-index-version.c

[PATCH/RFC v2 02/16] Modify read functions to prepare for other index
Make read_index_v2 static.

[PATCH/RFC v2 04/16] Modify write functions to prepare for other index
Make write_index_v2 static.

[PATCH/RFC v2 05/16] t2104: Don't fail for index versions other than [23]
Changed the test so that it converts the index to v2 at the beginning
of the test.

[PATCH/RFC v2 11/16] Read cache-tree in index-v5
Added a comment for cache_tree_convert_v5 that it is a destructive
function for the directory entries.

Added credits and reworded some commit messages.

Cleaned the patches up.
