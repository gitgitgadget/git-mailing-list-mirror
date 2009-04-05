From: Joerg Bornemann <git@jbornemann.de>
Subject: [PATCH (GIT-GUI BUG)] git-gui: use of undeclared variable in
 =?UTF-8?Q?handle=5Fempty=5Fdiff?=
Date: Sun, 05 Apr 2009 22:20:14 +0200
Message-ID: <0337ff5648e5e0dc583e255a44573dbf@mb8-2.1blu.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_00c3ea3f4b6eba4edd7123475a42f836"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 23:14:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqZf5-0005AF-0W
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 23:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbZDEVMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 17:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753914AbZDEVMS
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 17:12:18 -0400
Received: from ms4-1.1blu.de ([89.202.0.34]:47821 "EHLO ms4-1.1blu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753632AbZDEVMS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 17:12:18 -0400
X-Greylist: delayed 3379 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Apr 2009 17:12:17 EDT
Received: from [89.202.0.19] (helo=webmail.1blu.de)
	by ms4-1.1blu.de with esmtpa (Exim 4.50)
	id 1LqYl1-0006ee-Mv
	for git@vger.kernel.org; Sun, 05 Apr 2009 22:15:55 +0200
X-Sender: git@jbornemann.de
User-Agent: 1blu Webmail/0.2
X-Con-Id: 36794
X-Originating-IP: 89.202.0.19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115710>

--=_00c3ea3f4b6eba4edd7123475a42f836
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="UTF-8"

Commit 584fa9cc ("git-gui: Avoid an infinite rescan loop in
handle_empty_diff.") introduced the global variable diff_empty_count, which
is used in diff.tcl. But this variable isn't declared anywhere which
results in an ugly error message box instead of the intended informative
message. This patch fixes this and removes the unnecessary second
initialization of current_diff_path. 
--=_00c3ea3f4b6eba4edd7123475a42f836
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8";
 name="diff.txt"; 
Content-Disposition: attachment;
 filename="diff.txt"; 

ZGlmZiAtLWdpdCBhL2dpdC1ndWkuc2ggYi9naXQtZ3VpLnNoCmluZGV4IGIzYWE3MzIuLmIwZDUw
MjggMTAwNzU1Ci0tLSBhL2dpdC1ndWkuc2gKKysrIGIvZ2l0LWd1aS5zaApAQCAtMTEwNCwxMCAr
MTEwNCwxMCBAQCBzZXQgY29tbWl0X3R5cGUge30KIHNldCBlbXB0eV90cmVlIHt9CiBzZXQgY3Vy
cmVudF9icmFuY2gge30KIHNldCBpc19kZXRhY2hlZCAwCi1zZXQgY3VycmVudF9kaWZmX3BhdGgg
e30KIHNldCBpc18zd2F5X2RpZmYgMAogc2V0IGlzX2NvbmZsaWN0X2RpZmYgMAogc2V0IHNlbGVj
dGVkX2NvbW1pdF90eXBlIG5ldworc2V0IGRpZmZfZW1wdHlfY291bnQgMAogCiBzZXQgbnVsbGlk
ICIwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwIgogc2V0IG51bGxpZDIg
IjAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDEiCg==
--=_00c3ea3f4b6eba4edd7123475a42f836--
