From: Federico Fissore <federico@fissore.org>
Subject: [bug] .git/hooks/commit-msg.sample test is reversed
Date: Tue, 15 Sep 2015 10:43:52 +0200
Message-ID: <55F7DA48.30104@fissore.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050504080704040000050103"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 11:05:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbmAh-0003O6-Nm
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 11:05:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbbIOJE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 05:04:59 -0400
Received: from li196-221.members.linode.com ([178.79.140.221]:53974 "EHLO
	inglesina.fissore.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbbIOJE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 05:04:58 -0400
X-Greylist: delayed 1262 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Sep 2015 05:04:58 EDT
Received: from [192.168.0.87] (unknown [82.112.219.187])
	by inglesina.fissore.org (Postfix) with ESMTPSA id DC19C1102B8
	for <git@vger.kernel.org>; Tue, 15 Sep 2015 09:53:20 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:40.0) Gecko/20100101
 Thunderbird/40.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277897>

This is a multi-part message in MIME format.
--------------050504080704040000050103
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello everyone

In file commit-msg.sample, grep test is reversed. It greps
'^Signed-off-by: '
while it should grep
'Signed-off-by: '

If you run the sample against attached file, it won't complain. Remove 
the ^ and it will work as expected

Regards

Federico

--------------050504080704040000050103
Content-Type: text/plain; charset=UTF-8;
 name="test.commit.msg"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="test.commit.msg"

ICAgIENvbW1pdCBtZXNzYWdlCiAgICAKICAgIFNpZ25lZC1vZmYtYnk6IE1lIDxtZUBleGFt
cGxlLmNvbT4KICAgIFNpZ25lZC1vZmYtYnk6IE1lIDxtZUBleGFtcGxlLmNvbT4KCg==
--------------050504080704040000050103--
