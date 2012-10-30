From: "Aleksey Vasenev" <margtu-fivt@ya.ru>
Subject: Password parsing fix on windows
Date: Tue, 30 Oct 2012 13:37:24 +0400
Message-ID: <op.wmzjomzi945a05@ratio.ispring.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=----------YgoOrErbYtYaHWI59MU0iN
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 10:45:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT8Ni-0000vF-UG
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 10:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757482Ab2J3Jo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 05:44:58 -0400
Received: from forward3.mail.yandex.net ([77.88.46.8]:59519 "EHLO
	forward3.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757055Ab2J3Jo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 05:44:57 -0400
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Oct 2012 05:44:57 EDT
Received: from smtp1.mail.yandex.net (smtp1.mail.yandex.net [77.88.46.101])
	by forward3.mail.yandex.net (Yandex) with ESMTP id 9C1F7B418F4
	for <git@vger.kernel.org>; Tue, 30 Oct 2012 13:37:26 +0400 (MSK)
Received: from smtp1.mail.yandex.net (localhost [127.0.0.1])
	by smtp1.mail.yandex.net (Yandex) with ESMTP id 87F4CAA03BC
	for <git@vger.kernel.org>; Tue, 30 Oct 2012 13:37:26 +0400 (MSK)
Received: from dev.cpslabs.net (dev.cpslabs.net [91.210.252.146])
	by smtp1.mail.yandex.net (nwsmtp/Yandex) with ESMTP id bPC45KLZ-bQCegqkn;
	Tue, 30 Oct 2012 13:37:26 +0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1351589846;
	bh=/8ovcJRMrJ8OFSLNdOAVaHQTOuzBpcQFznIoN1jMScg=;
	h=Content-Type:To:Date:Subject:MIME-Version:From:Message-ID:
	 User-Agent;
	b=o54lTAGBrBE501mmqOdrcZwgP4e3b+NycSJcEKNPcEuNdEJVMpufWZsxy7PGAkufQ
	 MdjCJh7YQuqkrO1SSG2cdDC1rObSrM7SmOUYndLUxLy/wefrBe9yzw6LYFJmnv8MaY
	 C7OvCV6qj6TWotFWGACE6k/S0JYXJuE5iJiYXp7s=
User-Agent: Opera Mail/12.02 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208688>

------------YgoOrErbYtYaHWI59MU0iN
Content-Type: text/plain; charset=utf-8; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


------------YgoOrErbYtYaHWI59MU0iN
Content-Disposition: attachment; filename=patch.diff
Content-Type: application/octet-stream; name="patch.diff"
Content-Transfer-Encoding: Base64

ZGlmZiAtLWdpdCBhL3BlcmwvR2l0L1NWTi9Qcm9tcHQucG0gYi9wZXJsL0dpdC9T
Vk4vUHJvbXB0LnBtCmluZGV4IDNhNmY4YWYuLmFlMmFlZGEgMTAwNjQ0Ci0tLSBh
L3BlcmwvR2l0L1NWTi9Qcm9tcHQucG0KKysrIGIvcGVybC9HaXQvU1ZOL1Byb21w
dC5wbQpAQCAtMTI0LDcgKzEyNCw3IEBAIHN1YiBfcmVhZF9wYXNzd29yZCB7CiAJ
aWYgKGV4aXN0cyAkRU5We0dJVF9BU0tQQVNTfSkgewogCQlvcGVuKFBILCAiLXwi
LCAkRU5We0dJVF9BU0tQQVNTfSwgJHByb21wdCk7CiAJCSRwYXNzd29yZCA9IDxQ
SD47Ci0JCSRwYXNzd29yZCA9fiBzL1tcMDEyXDAxNV0vLzsgIyBcblxyCisJCSRw
YXNzd29yZCA9fiBzL1tcMDEyXDAxNV0rLy87ICMgXG5ccgogCQljbG9zZShQSCk7
CiAJfSBlbHNlIHsKIAkJcHJpbnQgU1RERVJSICRwcm9tcHQ7Cg==

------------YgoOrErbYtYaHWI59MU0iN--
