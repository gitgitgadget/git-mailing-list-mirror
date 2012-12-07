From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git(1): remove a defunct link to "list of authors"
Date: Fri, 07 Dec 2012 09:54:50 -0800
Message-ID: <7vobi5hhn9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 07 18:55:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th28i-0007sO-TG
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 18:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423583Ab2LGRyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 12:54:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51921 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423536Ab2LGRyw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 12:54:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28E3987A2;
	Fri,  7 Dec 2012 12:54:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=3
	YL/NhoyFeWso9WXQN2s5pm872w=; b=RT/1NUoNYdOdp8OHtXE/LM/UC6X19oqxU
	uzjP0ABl1jKEUYVUXzw2fHgmuXeSNigtF78Mq5fnSmIjfCdJ/hRDf7V5XPhf6woY
	mTCzbbgw4Lf5GqbFJGxjxNgCTQCFVw76oxwV9a66YtmdX2vWlPreOD2HiObiG8CK
	KPdn0mHS98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=mrg
	uC6KcE6vji3t//tkKJBnkIDoRRrRyinkyvDvviVZWiREyq5YE8BRypCrxmqIPoMF
	OSjRKH+aAIVruJCtZ6E/PWsvFAw3elSb/Mpo13r9QzbZOfIrIDzqfZtbTMeYoKBS
	L7OsD8ybiejd/B8hzbtLm8g5rutSuvCLnrGxK+Eg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16D7987A1;
	Fri,  7 Dec 2012 12:54:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9974E879F; Fri,  7 Dec 2012
 12:54:51 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 331D9572-4097-11E2-A728-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211184>

The linked page has not been showing the promised "more complete
list" for more than 6 months by now, and nobody has resurrected
the list there nor elsewhere since then.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * If somebody has a working replacement URL, we could use that
   instead, of course.  Takers?

 Documentation/git.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git c/Documentation/git.txt w/Documentation/git.txt
index cbe0883..5133952 100644
--- c/Documentation/git.txt
+++ w/Documentation/git.txt
@@ -868,8 +868,7 @@ Authors
 -------
 Git was started by Linus Torvalds, and is currently maintained by Junio
 C Hamano. Numerous contributions have come from the git mailing list
-<git@vger.kernel.org>. For a more complete list of contributors, see
-http://git-scm.com/about. If you have a clone of git.git itself, the
+<git@vger.kernel.org>.  If you have a clone of git.git itself, the
 output of linkgit:git-shortlog[1] and linkgit:git-blame[1] can show you
 the authors for specific parts of the project.
 
