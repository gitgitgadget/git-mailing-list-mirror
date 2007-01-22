From: SungHyun Nam <goweol@gmail.com>
Subject: GIT 1.5.0-rc2 compiler warning
Date: Mon, 22 Jan 2007 10:08:14 +0900
Message-ID: <45B40E7E.3030706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 22 02:08:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8nfg-0004MB-SP
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 02:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbXAVBI0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 20:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbXAVBI0
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 20:08:26 -0500
Received: from relaygw1.kornet.net ([61.74.75.196]:38035 "EHLO
	relaygw1.kornet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbXAVBIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 20:08:25 -0500
Received: from [211.48.62.137] ([211.48.62.137]) 
          by relaygw1.kornet.net ([61.74.75.196]) 
          with ESMTP id 2007012210:08:19:586762.19779.12258224
          Mon, 22 Jan 2007 10:08:19 +0900 (KST) 
Received: from [218.147.236.19] ([218.147.236.19]) 
          by relay9.kornet.net ([211.48.62.137]) 
          with ESMTP id 2007012210:08:18:570282.20845.38493104
          Mon, 22 Jan 2007 10:08:18 +0900 (KST) 
User-Agent: Thunderbird 2.0b1 (Windows/20061223)
To: Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.94.1.2
OpenPGP: id=8509C67F
X-TERRACE-SPAMMARK: NOT spam-marked.                              
  (by Terrace)                                            
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37374>

Hello,

Use CYGWIN.

gcc -o utf8.o -c -O2 -DNO_D_TYPE_IN_DIRENT -DNO_SYMLINK_HEAD
-DNO_FAST_WORKING_DIRECTORY -DNO_IPV6 -DSHA1_HEADER='<openssl/sha.h>'
-DNO_STRCASESTR utf8.c
utf8.c: In function `wcwidth':
utf8.c:148: warning: comparison is always false due to limited range of
data type
utf8.c:148: warning: comparison is always true due to limited range of
data type
utf8.c:149: warning: comparison is always false due to limited range of
data type
utf8.c:149: warning: comparison is always true due to limited range of
data type
utf8.c: In function `reencode_string':
utf8.c:313: warning: passing arg 2 of `libiconv' from incompatible
pointer type


'gcc -E .... utf8.c' gives me:

# 325 "/bin/../lib/gcc/i686-pc-cygwin/3.4.4/include/stddef.h" 3 4
typedef short unsigned int wchar_t;


Regards,
namsh
