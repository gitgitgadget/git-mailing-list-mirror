From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] Fix git-daemon argument-parsing bug
Date: Thu, 20 Oct 2005 18:34:58 -0700
Message-ID: <435845C2.3010504@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030601090600040900030405"
X-From: git-owner@vger.kernel.org Fri Oct 21 03:36:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESlp9-0004XI-D0
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 03:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbVJUBfV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 21:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbVJUBfV
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 21:35:21 -0400
Received: from terminus.zytor.com ([192.83.249.54]:9432 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964838AbVJUBfU
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 21:35:20 -0400
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9L1YxgJ005325
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 20 Oct 2005 18:35:02 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10404>

This is a multi-part message in MIME format.
--------------030601090600040900030405
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Fix stupid bug in parsing the --init-timeout option.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

--------------030601090600040900030405
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="diff"

ZGlmZiAtLWdpdCBhL2RhZW1vbi5jIGIvZGFlbW9uLmMKLS0tIGEvZGFlbW9uLmMKKysrIGIv
ZGFlbW9uLmMKQEAgLTYxMiw3ICs2MTIsNyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAq
KmFyZ3YpCiAJCWlmICghc3RybmNtcChhcmcsICItLXRpbWVvdXQ9IiwgMTApKSB7CiAJCQl0
aW1lb3V0ID0gYXRvaShhcmcrMTApOwogCQl9Ci0JCWlmICghc3RybmNtcChhcmcsICItLWlu
aXQtdGltZW91dD0iLCAxMCkpIHsKKwkJaWYgKCFzdHJuY21wKGFyZywgIi0taW5pdC10aW1l
b3V0PSIsIDE1KSkgewogCQkJaW5pdF90aW1lb3V0ID0gYXRvaShhcmcrMTUpOwogCQl9CiAJ
CWlmICghc3RyY21wKGFyZywgIi0tIikpIHsK
--------------030601090600040900030405--
