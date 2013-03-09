From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] "git add -u/-A" from future
Date: Sat,  9 Mar 2013 00:23:09 -0800
Message-ID: <1362817391-24452-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 09 09:23:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEF47-0004B0-Hh
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 09:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148Ab3CIIXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 03:23:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48270 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932071Ab3CIIXN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 03:23:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3BA89FE3
	for <git@vger.kernel.org>; Sat,  9 Mar 2013 03:23:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=MNnZRKKM1dWyeupKuPKQRSJHb5M
	=; b=fa8F88le9uKnVoZ6Xc3mBUrUfO6YAmjboS8oceIqRDtBliyqPeTCmdSWlNM
	k0BfMM4n5SWSA8dpf+/4q58LcMr0FL47sNM1iECqSVWyJvxDe3jxGOB2W/I7mB0u
	wCrOYZo/lqlqiwbILTLh65PgADR92W5Ogn3f+u/jlAk3H+Xw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=FlimTpuJ8oa5FL6eovkzIkmFev/1H
	k0LKY5ppA+fmZ22PdowwwwZtFPIxx5CZMmZeC8d3A1Zj+R66hz+rlHTnHPgIv/iZ
	I32H2bFtGN5Q4KISBWyx+SD+we7lfOkimqCOLccDUh9mtgWpHM80yqgh5+oWcys6
	5RP2LNHci8xxFA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D966D9FE2
	for <git@vger.kernel.org>; Sat,  9 Mar 2013 03:23:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62B519FDF for
 <git@vger.kernel.org>; Sat,  9 Mar 2013 03:23:12 -0500 (EST)
X-Mailer: git-send-email 1.8.2-rc3-203-gc9aaab5
X-Pobox-Relay-ID: 953058B0-8892-11E2-A79E-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217709>

Here are two future steps to update the behaviour of "add -u/-A" run
without pathspec towards Git 2.0; the first step may probably be
optional, but it is included for completeness.

Rebased on top of the recent "git add -u/-A" documentation updates
5cae93566027 (add: Clarify documentation of -A and -u, 2013-03-07)
by Greg Price.

Junio C Hamano (2):
  require pathspec for "git add -u/-A"
  git add: -u/-A now affects the entire working tree

 Documentation/git-add.txt | 16 ++++++++--------
 builtin/add.c             | 49 ++++-------------------------------------------
 2 files changed, 12 insertions(+), 53 deletions(-)

-- 
1.8.2-rc3-203-gc9aaab5
