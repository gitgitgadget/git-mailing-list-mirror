From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] rebase-i minifixes
Date: Mon,  5 Jul 2010 23:27:09 -0700
Message-ID: <1278397631-20658-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 06 08:27:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW1cn-0003GP-VV
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 08:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181Ab0GFG1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 02:27:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094Ab0GFG1P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 02:27:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D653C026F
	for <git@vger.kernel.org>; Tue,  6 Jul 2010 02:27:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=AxkpExktubukQyryfJxQImAw57E
	=; b=aesYUBXwb311YhFvx4LzTE1cse46oNoyZ5NPDX5qzN8Pk4/JhBpYAoDEhEB
	FXUltIZd5Y5CYT47rHc9Ke/WKenG2bFuisjt7aVOQeDcG9sbyxexbbVY4NEgktMQ
	MkdPUsogcuTbUsqyHrwYNHeaMi0qkIbcUTexpwLgDVpXvHRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=FiK2rFBs/95oU9cyIL/VKHEhFwzgz
	P0rzMks2SsP+i/7JysyKANVOmPGeT1qZLQI/GPN/4TSfuUNQUP7ryh7YMNVi+mmB
	H0mkrZcgoAXFIe3D1CCTEWlV47jHZZyesM9p+TiTrZ7ugRYR5Lcm5kIaxK2HpwV9
	rYAkEgelHhah4g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AF72C026E
	for <git@vger.kernel.org>; Tue,  6 Jul 2010 02:27:13 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2767DC026D for
 <git@vger.kernel.org>; Tue,  6 Jul 2010 02:27:13 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.rc1.209.g3868f
X-Pobox-Relay-ID: 83D5429C-88C7-11DF-BC8C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150326>

The first one is just a (long overdue) style fix.  The second one changes
"read" to "read -r" to work around commit log messages that have backslash
characters in them, the issue reported by Joshua ben Jore

Junio C Hamano (2):
  rebase-i: style fix
  rebase-i: do not get fooled by a log message ending with backslash

 git-rebase--interactive.sh    |   19 ++++++++++---------
 t/t3404-rebase-interactive.sh |   18 ++++++++++++++++++
 2 files changed, 28 insertions(+), 9 deletions(-)

-- 
1.7.2.rc1.209.g3868f
