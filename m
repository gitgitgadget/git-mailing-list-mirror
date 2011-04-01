From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] "log --cherry-pick" documentation regression fix
Date: Fri, 01 Apr 2011 11:04:46 -0700
Message-ID: <7v39m1hmpt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 20:05:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5iib-0003NQ-NT
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 20:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757314Ab1DASFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 14:05:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35460 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756871Ab1DASE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 14:04:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 309D7473C;
	Fri,  1 Apr 2011 14:06:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=W
	EovMUoLoknqcmJ2/LJuA9pwgMI=; b=WB7s+giwJRNB8TaG2wkLfBfBAuB6YgKP9
	ZbQ5Opy8FX0uZW0sIQpUA848RBBUlc5jPEM8Yvg7irxwf6KmQ6KU+lX5HsC4qGSU
	6kE63OoC0i7vO6OJCk/FabyTovIZdgFBcz/eOjnpTrb6Wv7ToyFB4XYPDib0ZEyJ
	npTDvAs3Ug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=BuxnZHnAjXob5EsD1A2xt/ILGAT5uw6ttjgUIMTUXq5dwJGLvNaeX8mA
	HFMbW5mHKFYyd1lAf+pvsMzsrZeUvfyXH7TYErG9Cu698kmZMyGsghpIKZelWjpl
	sXvBr1GRgDnPoFKjOrscOirOc1NFx4WjEDbUa8kD+DZePyGZ+nc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0B8BF4738;
	Fri,  1 Apr 2011 14:06:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1D260472F; Fri,  1 Apr 2011
 14:06:38 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC0B6342-5C8A-11E0-B75D-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170599>

Earlier f98fd43 (git-log.txt,rev-list-options.txt: put option blocks in
proper order, 2011-03-08) moved the text around in the documentation for
options in the rev-list family of commands such as "log".  Consequently,
the description of the --cherry-pick option appears way above the
description of the --left-right option now.

But the description of the --cherry-pick option still refers to the
example for the --left-right option, like this:

    ... with --left-right, like the example ABOVE in the description of
    that option.

Rephrase it to clarify that we are making a forward reference.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I just happened to notice this one; there may be similar screw-ups due
   to this bulk text movement but I didn't look.

 Documentation/rev-list-options.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index ea5c6c4..73111bb 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -179,8 +179,8 @@ endif::git-rev-list[]
 +
 For example, if you have two branches, `A` and `B`, a usual way
 to list all commits on only one side of them is with
-`--left-right`, like the example above in the description of
-that option.  It however shows the commits that were cherry-picked
+`--left-right` (see the example below in the description of
+the `--left-right` option).  It however shows the commits that were cherry-picked
 from the other branch (for example, "3rd on b" may be cherry-picked
 from branch A).  With this option, such pairs of commits are
 excluded from the output.
