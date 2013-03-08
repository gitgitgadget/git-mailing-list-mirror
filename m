From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] "git add -u/-A" from future
Date: Fri,  8 Mar 2013 15:54:47 -0800
Message-ID: <1362786889-28688-1-git-send-email-gitster@pobox.com>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 09 00:55:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE78B-0002Sd-DJ
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 00:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759667Ab3CHXyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 18:54:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38023 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754610Ab3CHXyw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 18:54:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 703EFBF5A;
	Fri,  8 Mar 2013 18:54:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=+fb0TC6ND0MShim+Ll5vQnOlGYM
	=; b=pArRDWUGGCM5R1xyS64Rn2a4MCXiSvmqKrR0CU737aOkMawAToilhSEMKJs
	UlkW8zDz1A7ra6WZTOdJk0iKNXEOGEqzWxFsW5X8DaBtHRKEubHdDNGld1hh/2Wj
	RTmaHekvPJ5ey5g8fuKdWG9ViysgOR+Iq16//GFVrJKtzIGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=pYA8293uXkbaB4gOytVoT
	F0gPE3IwWCqxTN2MuUtpgDHU3r2Rp4tpVU9QV2hUL6YRdU/vswPs+cSy3Mb7MLzn
	6rlPokAQXblfvJvDe8/9T11I1TE6adqsAA4hXwoEpSm6GfhktBC8qu42lNU1rIqx
	nYXT4lNorOjApg6xdoVRsw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65601BF59;
	Fri,  8 Mar 2013 18:54:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DBA21BF57; Fri,  8 Mar 2013
 18:54:50 -0500 (EST)
X-Mailer: git-send-email 1.8.2-rc3-196-gfcda97c
X-Pobox-Relay-ID: 90E03C90-884B-11E2-89B2-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217691>

Here are two future steps to update the behaviour of "add -u/-A" run
without pathspec towards Git 2.0; the first step may probably be
optional, but it is included for completeness.

Junio C Hamano (2):
  require pathspec for "git add -u/-A"
  git add: -u/-A now affects the entire working tree

 Documentation/git-add.txt |  8 ++++----
 builtin/add.c             | 49 ++++-------------------------------------------
 2 files changed, 8 insertions(+), 49 deletions(-)

-- 
1.8.2-rc3-196-gfcda97c
