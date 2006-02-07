From: "H. Peter Anvin" <hpa@zytor.com>
Subject: git-am: "Patch fragment without a header"
Date: Mon, 06 Feb 2006 18:59:47 -0800
Message-ID: <43E80D23.4070007@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070006060601040008010500"
X-From: git-owner@vger.kernel.org Tue Feb 07 04:00:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6J5D-0003YG-Uh
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 04:00:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWBGC7w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 21:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964917AbWBGC7w
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 21:59:52 -0500
Received: from terminus.zytor.com ([192.83.249.54]:23182 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964914AbWBGC7v
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Feb 2006 21:59:51 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k172xlKc025090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 6 Feb 2006 18:59:48 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15677>

This is a multi-part message in MIME format.
--------------070006060601040008010500
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

git-am from git-1.1.6 refuses to apply the following two patches, 
whereas patch(1) sees nothing wrong with them...

The error messages look like:

: smyrno 46 ; git-am /tmp/\[klibc]\ Add\ swap\ support\ to\ fstype,\ 
second\ version.eml

Applying 'Add swap support to fstype, second version'

error: patch fragment without header at line 4: @@ -7,7 +7,7 @@
error: patch fragment without header at line 13: @@ -20,6 +20,7 @@
error: patch fragment without header at line 21: @@ -49,6 +50,9 @@
error: patch fragment without header at line 31: @@ -182,6 +186,19 @@
error: patch fragment without header at line 50: @@ -189,17 +206,18 @@
error: patch fragment without header at line 83: @@ -0,0 +1,18 @@
fatal: No changes
Patch failed at 0001.

The patches are meant to be apply to the top of:

git://git.kernel.org/pub/scm/libs/klibc/klibc.git

HEAD = ea6af2b08cb18ba60e55c5e8f0f65ddac1672ca0

	-hpa

--------------070006060601040008010500
Content-Type: message/rfc822;
 name="[klibc] Add LUKS support to fstype, second version.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[klibc] Add LUKS support to fstype, second version.eml"

Return-Path: <klibc-bounces@zytor.com>
Received: from terminus.zytor.com (mailman@localhost [127.0.0.1])
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k15AQ3lc006938;
	Sun, 5 Feb 2006 02:26:15 -0800
Received: from palpatine.hardeman.nu (1-1-12-13a.han.sth.bostream.se
	[82.182.30.168])
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k15APUjs006923
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <klibc@zytor.com>; Sun, 5 Feb 2006 02:25:33 -0800
Received: from ip54532fb6.speed.planet.nl ([84.83.47.182] helo=austin)
	by palpatine.hardeman.nu with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1F5h57-0002nr-9I
	for klibc@zytor.com; Sun, 05 Feb 2006 11:25:24 +0100
Received: by austin (Postfix, from userid 1000)
	id 336D819AF3D; Sun,  5 Feb 2006 11:24:26 +0100 (CET)
Date: Sun, 5 Feb 2006 11:24:26 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: klibc@zytor.com
Message-ID: <20060205102426.GA10190@hardeman.nu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Content-Transfer-Encoding: 7bit
X-SA-Score: -2.2
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 
	autolearn=unavailable version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Subject: [klibc] Add LUKS support to fstype, second version
X-BeenThere: klibc@zytor.com
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: About Linux klibc and early userspace issues <klibc.zytor.com>
List-Unsubscribe: <http://www.zytor.com/mailman/listinfo/klibc>,
	<mailto:klibc-request@zytor.com?subject=unsubscribe>
List-Archive: <http://www.zytor.com/pipermail/klibc>
List-Post: <mailto:klibc@zytor.com>
List-Help: <mailto:klibc-request@zytor.com?subject=help>
List-Subscribe: <http://www.zytor.com/mailman/listinfo/klibc>,
	<mailto:klibc-request@zytor.com?subject=subscribe>
Sender: klibc-bounces@zytor.com
Errors-To: klibc-bounces@zytor.com
X-UID: 1336
X-Keywords: NonJunk                                                                                           


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The attached patch adds support for detecting LUKS partitions (Linux=20
Unified Key Setup - http://luks.endorphin.org/) to fstype. This makes it=20
easier to automatically detect and activate encrypted (root) partitions=20
from an initramfs image.

The patch is now against klibc's git tree instead of klibc-1.2.

Signed-off-by: David H=E4rdeman <david@2gen.com>

--

 fstype.c  |   17 ++++++++++++++++-
 luks_fs.h |   45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=klibc-add-luks-to-fstype-v2

Index: klibc/usr/kinit/fstype/fstype.c
===================================================================
--- klibc.orig/usr/kinit/fstype/fstype.c	2006-02-05 10:53:51.000000000 +0100
+++ klibc/usr/kinit/fstype/fstype.c	2006-02-05 11:09:31.000000000 +0100
@@ -7,7 +7,7 @@
  *  FSSIZE - filesystem size (if known)
  *
  * We currently detect (in order):
- *  gzip, cramfs, romfs, xfs, minix, ext3, ext2, reiserfs, jfs
+ *  gzip, cramfs, romfs, xfs, luks, minix, ext3, ext2, reiserfs, jfs
  *
  * MINIX, ext3 and Reiserfs bits are currently untested.
  */
@@ -29,6 +29,7 @@
 #include "ext2_fs.h"
 #include "ext3_fs.h"
 #include "xfs_sb.h"
+#include "luks_fs.h"
 
 /*
  * Slightly cleaned up version of jfs_superblock to
@@ -168,6 +169,19 @@
 	return 0;
 }
 
+static int luks_image(const unsigned char *buf, unsigned long long *blocks)
+{
+	const struct luks_partition_header *lph =
+		(const struct luks_partition_header *)buf;
+
+	if (!memcmp(lph->magic, LUKS_MAGIC, LUKS_MAGIC_L)) {
+		/* FSSIZE is dictated by the underlying fs, not by LUKS */
+		*blocks = 0;
+		return 1;
+	}
+	return 0;
+}
+
 struct imagetype {
 	off_t		block;
 	const char	name[12];
@@ -179,6 +193,7 @@
 	{ 0,	"cramfs",	cramfs_image	},
 	{ 0,	"romfs",	romfs_image	},
 	{ 0,	"xfs",		xfs_image	},
+	{ 0,	"luks",		luks_image	},
 	{ 1,	"minix",	minix_image	},
 	{ 1,	"ext3",		ext3_image	},
 	{ 1,	"ext2",		ext2_image	},
Index: klibc/usr/kinit/fstype/luks_fs.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ klibc/usr/kinit/fstype/luks_fs.h	2006-02-05 10:57:52.000000000 +0100
@@ -0,0 +1,45 @@
+#ifndef __LINUX_LUKS_FS_H
+#define __LINUX_LUKS_FS_H
+
+/* The basic structures of the luks partition header */
+#define LUKS_MAGIC_L		6
+#define LUKS_CIPHERNAME_L	32
+#define LUKS_CIPHERMODE_L	32
+#define LUKS_HASHSPEC_L		32
+#define LUKS_UUID_STRING_L	40
+
+#define LUKS_MAGIC		"LUKS\xBA\xBE"
+#define LUKS_DIGESTSIZE		20
+#define LUKS_SALTSIZE		32
+#define LUKS_NUMKEYS		8
+#define LUKS_MKD_ITER		10
+#define LUKS_KEY_DISABLED	0x0000DEAD
+#define LUKS_KEY_ENABLED	0x00AC71F3
+#define LUKS_STRIPES		4000
+
+
+/* On-disk "super block" */
+struct luks_partition_header {
+	char	magic[LUKS_MAGIC_L];
+	__be16	version;
+	char	cipherName[LUKS_CIPHERNAME_L];
+	char	cipherMode[LUKS_CIPHERMODE_L];
+	char	hashSpec[LUKS_HASHSPEC_L];
+	__be32	payloadOffset;
+	__be32  keyBytes;
+	char	mkDigest[LUKS_DIGESTSIZE];
+	char	mkDigestSalt[LUKS_SALTSIZE];
+	__be32	mkDigestIterations;
+	char	uuid[LUKS_UUID_STRING_L];
+
+	struct {
+		__be32	active;
+		/* Parameters for PBKDF2 processing */
+		__be32	passwordIterations;
+		char	passwordSalt[LUKS_SALTSIZE];
+		__be32	keyMaterialOffset;
+		__be32	stripes;
+	} keyblock[LUKS_NUMKEYS];
+};
+
+#endif

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
klibc mailing list
klibc@zytor.com
http://www.zytor.com/mailman/listinfo/klibc

--3V7upXqbjpZ4EhLz--

--------------070006060601040008010500
Content-Type: message/rfc822;
 name="[klibc] Add swap support to fstype, second version.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[klibc] Add swap support to fstype, second version.eml"

Return-Path: <klibc-bounces@zytor.com>
Received: from terminus.zytor.com (mailman@localhost [127.0.0.1])
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k15AWHcj007144;
	Sun, 5 Feb 2006 02:32:26 -0800
Received: from palpatine.hardeman.nu (1-1-12-13a.han.sth.bostream.se
	[82.182.30.168])
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k15ARSKU006978
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <klibc@zytor.com>; Sun, 5 Feb 2006 02:27:31 -0800
Received: from ip54532fb6.speed.planet.nl ([84.83.47.182] helo=austin)
	by palpatine.hardeman.nu with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1F5h73-0002o9-8K
	for klibc@zytor.com; Sun, 05 Feb 2006 11:27:23 +0100
Received: by austin (Postfix, from userid 1000)
	id EB6DE19AF41; Sun,  5 Feb 2006 11:26:47 +0100 (CET)
Date: Sun, 5 Feb 2006 11:26:47 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: klibc@zytor.com
Message-ID: <20060205102647.GB10190@hardeman.nu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Content-Transfer-Encoding: 7bit
X-SA-Score: -2.2
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 
	autolearn=unavailable version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Subject: [klibc] Add swap support to fstype, second version
X-BeenThere: klibc@zytor.com
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: About Linux klibc and early userspace issues <klibc.zytor.com>
List-Unsubscribe: <http://www.zytor.com/mailman/listinfo/klibc>,
	<mailto:klibc-request@zytor.com?subject=unsubscribe>
List-Archive: <http://www.zytor.com/pipermail/klibc>
List-Post: <mailto:klibc@zytor.com>
List-Help: <mailto:klibc-request@zytor.com?subject=help>
List-Subscribe: <http://www.zytor.com/mailman/listinfo/klibc>,
	<mailto:klibc-request@zytor.com?subject=subscribe>
Sender: klibc-bounces@zytor.com
Errors-To: klibc-bounces@zytor.com
X-UID: 1337
X-Keywords: NonJunk                                                                                           


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch adds support for swap detection to fstype (to be applied on=20
top of the previous luks patch).

The patch is now against klibc's git tree instead of klibc-1.2.

Signed-off-by: David H=E4rdeman <david@2gen.com>

--=20

 fstype.c  |   42 ++++++++++++++++++++++++++++++------------
 swap_fs.h |   18 ++++++++++++++++++
 2 files changed, 48 insertions(+), 12 deletions(-)


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=klibc-add-swap-to-fstype-v2

Index: klibc/usr/kinit/fstype/fstype.c
===================================================================
--- klibc.orig/usr/kinit/fstype/fstype.c	2006-02-05 11:09:31.000000000 +0100
+++ klibc/usr/kinit/fstype/fstype.c	2006-02-05 11:11:15.000000000 +0100
@@ -7,7 +7,7 @@
  *  FSSIZE - filesystem size (if known)
  *
  * We currently detect (in order):
- *  gzip, cramfs, romfs, xfs, luks, minix, ext3, ext2, reiserfs, jfs
+ *  gzip, cramfs, romfs, xfs, luks, minix, ext3, ext2, reiserfs, jfs, swap
  *
  * MINIX, ext3 and Reiserfs bits are currently untested.
  */
@@ -20,6 +20,7 @@
 #include <endian.h>
 #include <netinet/in.h>
 #include <sys/vfs.h>
+#include <asm/page.h>
 
 #define cpu_to_be32(x) __cpu_to_be32(x)	/* Needed by romfs_fs.h */
 
@@ -49,6 +50,9 @@
 
 #define BLOCK_SIZE 1024
 
+/* Swap needs the definition of block size */
+#include "swap_fs.h"
+
 static int gzip_image(const unsigned char *buf, unsigned long long *bytes)
 {
 	if (buf[0] == 037 && (buf[1] == 0213 || buf[1] == 0236)) {
@@ -182,6 +186,19 @@
 	return 0;
 }
 
+static int swap_image(const unsigned char *buf, unsigned long long *blocks)
+{
+	const struct swap_super_block *ssb =
+		(const struct swap_super_block *)buf;
+
+	if (!memcmp(ssb->magic, SWAP_MAGIC_1, SWAP_MAGIC_L) ||
+	    !memcmp(ssb->magic, SWAP_MAGIC_2, SWAP_MAGIC_L)) {
+		*blocks = 0;
+		return 1;
+	}
+	return 0;
+}
+
 struct imagetype {
 	off_t		block;
 	const char	name[12];
@@ -189,17 +206,18 @@
 };
 
 static struct imagetype images[] = {
-	{ 0,	"gzip",		gzip_image	},
-	{ 0,	"cramfs",	cramfs_image	},
-	{ 0,	"romfs",	romfs_image	},
-	{ 0,	"xfs",		xfs_image	},
-	{ 0,	"luks",		luks_image	},
-	{ 1,	"minix",	minix_image	},
-	{ 1,	"ext3",		ext3_image	},
-	{ 1,	"ext2",		ext2_image	},
-	{ 8,	"reiserfs",	reiserfs_image	},
-	{ 64,	"reiserfs",	reiserfs_image	},
-	{ 32,	"jfs",		jfs_image	}
+	{ 0,		"gzip",		gzip_image	},
+	{ 0,		"cramfs",	cramfs_image	},
+	{ 0,		"romfs",	romfs_image	},
+	{ 0,		"xfs",		xfs_image	},
+	{ 0,		"luks",		luks_image	},
+	{ 1,		"minix",	minix_image	},
+	{ 1,		"ext3",		ext3_image	},
+	{ 1,		"ext2",		ext2_image	},
+	{ 8,		"reiserfs",	reiserfs_image	},
+	{ 64,		"reiserfs",	reiserfs_image	},
+	{ 32,		"jfs",		jfs_image	},
+	{ SWAP_OFFSET,	"swap",		swap_image	}
 };
 
 int identify_fs(int fd, const char **fstype,
Index: klibc/usr/kinit/fstype/swap_fs.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ klibc/usr/kinit/fstype/swap_fs.h	2006-02-05 11:10:01.000000000 +0100
@@ -0,0 +1,18 @@
+#ifndef __LINUX_SWAP_FS_H
+#define __LINUX_SWAP_FS_H
+
+/* The basic structures of the swap super block */
+#define SWAP_RESERVED_L		BLOCK_SIZE - 10
+#define SWAP_MAGIC_L		10
+#define SWAP_MAGIC_1		"SWAP-SPACE"
+#define SWAP_MAGIC_2		"SWAPSPACE2"
+/* The super block is the last block in the first page */
+#define SWAP_OFFSET		((PAGE_SIZE - BLOCK_SIZE) / BLOCK_SIZE)
+
+/* On-disk "super block" */
+struct swap_super_block {
+	char reserved[SWAP_RESERVED_L];
+	char magic[SWAP_MAGIC_L];
+};
+
+#endif

--MW5yreqqjyrRcusr
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
klibc mailing list
klibc@zytor.com
http://www.zytor.com/mailman/listinfo/klibc

--MW5yreqqjyrRcusr--

--------------070006060601040008010500--
