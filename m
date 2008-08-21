From: imyousuf@gmail.com
Subject: [JGit Patch v2 2/7] Add test resources to a new package structured directory
Date: Thu, 21 Aug 2008 09:13:09 +0600
Message-ID: <1219288394-1241-2-git-send-email-imyousuf@gmail.com>
References: <1219288394-1241-1-git-send-email-imyousuf@gmail.com>
Cc: spearce@spearce.org, robin.rosenberg@dewire.com,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 05:14:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW0dU-0007ZL-LU
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 05:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754378AbYHUDNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 23:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754675AbYHUDNk
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 23:13:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:60542 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378AbYHUDNi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 23:13:38 -0400
Received: by nf-out-0910.google.com with SMTP id d3so370899nfc.21
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 20:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=KDE0Qdm2t8qq2lA7XCIQjW9PYbOb09e3LnRjUx0mm4A=;
        b=gzepc+ubxf74/UbbcMZ5uidzqGIXsDbM4TBdKYMvgqnvHVPTBpA7LVmQ0+3Ewg9IDf
         E/SY3RLyJFcvIPz0hSWJHT0+aTUKy5OFPFP7NEW5S8TNYUpaJNfChym6S0gMvvK1YKMD
         mDBygvlI0EMu2HJ+pz4cM8VLrrH6maqdb5Mmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BAwl7veeqrtGWWb3lrOEZcVIkVfFwuxxmpqiqC//IuKmb6T7Y/9Z4GgeNuccFHezng
         86BW1A313dctniI4GDcl20z2Hga7g67Stw2r5XWDmEyblxfDi3zH6mMgDUPvy6tVUWlq
         T7+RubyUopVVrChXVlxyJuvr6X1O2Hvo4yzYw=
Received: by 10.210.125.13 with SMTP id x13mr1136767ebc.158.1219288417090;
        Wed, 20 Aug 2008 20:13:37 -0700 (PDT)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id 31sm3833479nfu.9.2008.08.20.20.13.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Aug 2008 20:13:36 -0700 (PDT)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1219288394-1241-1-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93098>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

Previously the test resources were read from a path in filesystem from now
on it wil be read from classpath and thus resources are added to a java
package structured directory.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 .../org/spearce/jgit/test/resources}/gitgit.index  |  Bin 134799 -> 134799 bytes
 .../spearce/jgit/test/resources}/gitgit.lsfiles    |    0 
 .../org/spearce/jgit/test/resources}/gitgit.lstree |    0 
 ...ck-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx |  Bin 1256 -> 1256 bytes
 ...-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2 |  Bin 1296 -> 1296 bytes
 ...k-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack |  Bin 7811 -> 7811 bytes
 ...ck-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.idx |  Bin 1088 -> 1088 bytes
 ...k-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.pack |  Bin 164 -> 164 bytes
 ...ck-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx |  Bin 2696 -> 2696 bytes
 ...-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2 |  Bin 2976 -> 2976 bytes
 ...k-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack |  Bin 5956 -> 5956 bytes
 ...ck-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.idx |  Bin 1112 -> 1112 bytes
 ...k-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.pack |  Bin 1643 -> 1643 bytes
 .../org/spearce/jgit/test/resources}/pack-huge.idx |  Bin 2368 -> 2368 bytes
 .../org/spearce/jgit/test/resources}/packed-refs   |    0 
 15 files changed, 0 insertions(+), 0 deletions(-)
 copy org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/gitgit.index (100%)
 copy org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/gitgit.lsfiles (100%)
 copy org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/gitgit.lstree (100%)
 copy org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx (100%)
 copy org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2 (100%)
 copy org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack (100%)
 copy org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.idx (100%)
 copy org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.pack (100%)
 copy org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx (100%)
 copy org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2 (100%)
 copy org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack (100%)
 copy org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.idx (100%)
 copy org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.pack (100%)
 copy org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/pack-huge.idx (100%)
 copy org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/packed-refs (100%)

diff --git a/org.spearce.jgit.test/tst/gitgit.index b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/gitgit.index
similarity index 100%
copy from org.spearce.jgit.test/tst/gitgit.index
copy to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/gitgit.index
diff --git a/org.spearce.jgit.test/tst/gitgit.lsfiles b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/gitgit.lsfiles
similarity index 100%
copy from org.spearce.jgit.test/tst/gitgit.lsfiles
copy to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/gitgit.lsfiles
diff --git a/org.spearce.jgit.test/tst/gitgit.lstree b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/gitgit.lstree
similarity index 100%
copy from org.spearce.jgit.test/tst/gitgit.lstree
copy to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/gitgit.lstree
diff --git a/org.spearce.jgit.test/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx
similarity index 100%
copy from org.spearce.jgit.test/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx
copy to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx
diff --git a/org.spearce.jgit.test/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2 b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2
similarity index 100%
copy from org.spearce.jgit.test/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2
copy to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2
diff --git a/org.spearce.jgit.test/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack
similarity index 100%
copy from org.spearce.jgit.test/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack
copy to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack
diff --git a/org.spearce.jgit.test/tst/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.idx b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.idx
similarity index 100%
copy from org.spearce.jgit.test/tst/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.idx
copy to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.idx
diff --git a/org.spearce.jgit.test/tst/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.pack b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.pack
similarity index 100%
copy from org.spearce.jgit.test/tst/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.pack
copy to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745.pack
diff --git a/org.spearce.jgit.test/tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx
similarity index 100%
copy from org.spearce.jgit.test/tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx
copy to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx
diff --git a/org.spearce.jgit.test/tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2 b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2
similarity index 100%
copy from org.spearce.jgit.test/tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2
copy to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2
diff --git a/org.spearce.jgit.test/tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack
similarity index 100%
copy from org.spearce.jgit.test/tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack
copy to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack
diff --git a/org.spearce.jgit.test/tst/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.idx b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.idx
similarity index 100%
copy from org.spearce.jgit.test/tst/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.idx
copy to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.idx
diff --git a/org.spearce.jgit.test/tst/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.pack b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.pack
similarity index 100%
copy from org.spearce.jgit.test/tst/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.pack
copy to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa.pack
diff --git a/org.spearce.jgit.test/tst/pack-huge.idx b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-huge.idx
similarity index 100%
copy from org.spearce.jgit.test/tst/pack-huge.idx
copy to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-huge.idx
diff --git a/org.spearce.jgit.test/tst/packed-refs b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/packed-refs
similarity index 100%
copy from org.spearce.jgit.test/tst/packed-refs
copy to org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/packed-refs
-- 
1.5.6
