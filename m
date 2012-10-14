From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v5 05/12] Integrate wildmatch to git
Date: Sun, 14 Oct 2012 13:07:36 +0200
Message-ID: <507A9CF8.1040603@web.de>
References: <1350182110-25936-1-git-send-email-pclouds@gmail.com> <1350182110-25936-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 13:08:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNM2z-0000i2-Sz
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 13:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381Ab2JNLHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 07:07:41 -0400
Received: from mout.web.de ([212.227.17.12]:53946 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181Ab2JNLHk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 07:07:40 -0400
Received: from birne.lan ([195.67.191.22]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0Lj2TO-1Tukmk2d02-00d6KL; Sun, 14 Oct 2012 13:07:37 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <1350182110-25936-6-git-send-email-pclouds@gmail.com>
X-Provags-ID: V02:K0:EWgklG+N4ghaB+dFxUrypTRtp/7hvtqHoQlbVM7bWlZ
 YoqIbaWUKTlvuEZZtSfe0jtxtI8lzybEjaJFUoYcuiWtA0Mzk1
 0RgFJDhwb9l0jaSkWl4z9O2qWP6Qo3RqwanCe9w3uuVLA6bZrs
 POgKRD1pUjH04FUSGfmqUoCTk0aQDhydWh7YdWU1JwuQmu8TLX
 QHAFQO1IxW4vBWqHFY7HQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207651>

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
new file mode 100755
index 0000000..dbd3c8b
--- /dev/null
+++ b/t/t3070-wildmatch.sh
@@ -0,0 +1,188 @@
+#!/bin/sh
+#    else
+#    test_expect_success BROKEN_FNMATCH "fnmatch:       '$3' '$4'" "
+#        ! test-wildmatch fnmatch '$3' '$4'
+#    "
+    fi
+}
+

Thanks:
On my Mac OS X box:
# passed all 259 test(s)

And a quick test on cygwin:
$ ./t3070-wildmatch.sh  2>&1 | grep "not ok"
not ok - 148 fnmatch:      match '5' '[[:xdigit:]]'
not ok - 150 fnmatch:      match 'f' '[[:xdigit:]]'
not ok - 152 fnmatch:      match 'D' '[[:xdigit:]]'


And 2 micronits:
a) Commented out code
b) Whithespace damage
( 4 spaces used for an indent of 1, TAB for indent of 2)

/Torsten
