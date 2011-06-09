From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.6.rc1
Date: Wed, 08 Jun 2011 20:14:41 -0700
Message-ID: <7vlixbzof2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 05:15:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUVi4-00030w-7G
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 05:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781Ab1FIDOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 23:14:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626Ab1FIDOv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 23:14:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 701DD6603;
	Wed,  8 Jun 2011 23:17:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type; s=sasl;
	 bh=w7xv8CccpxPwT5RqmI7i+FWXzTo=; b=QcU5esHMlZBdWm5n+VbzQ0xwu+Lj
	djypVU2uVbFqKnFXS9x4yjP0jp0QbmuhOGd8uSQsDhKFWAMgU87tjXJn3H/xYN5b
	O268MPzvh4X0fQVCEtvgMdH3xWuzSZUkESCn1idX7dAsLHb8WApdblIhd8vgP8t+
	h0mqxO82DWgtzwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	ZGxIZCMpxMcc1Jo8fubErMYpE59MbKyT6i0/KNpolERIhYj/WEg8bvAfPtM2fIwO
	r0Bti9mjxj8lxK4B6GHsDKu3Rxg9/i0J0mG1HzMybc+ulEjFzZete5jakgsA62g4
	BYs9dd0daHUH7H+WFhjDtyCORL27TN+BLxhG4OLz/H8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 30D506602;
	Wed,  8 Jun 2011 23:16:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0AAA86601; Wed,  8 Jun 2011
 23:16:53 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF476BCA-9246-11E0-A5E1-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175485>

A release candidate Git 1.7.6-rc1 is available at the usual places
for testing:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.6.rc1.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.6.rc1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.6.rc1.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  testing/git-*-1.7.6.rc1-1.fc13.$arch.rpm	(RPM)

A week has passed since the casual "-rc0" was tagged, so here is the first
official release candidate, with RPM and announcement.

Please switch to the tip of 'master' for your daily use so that we can
ship 1.7.6 without regressions and bugs in new features in two weeks.

Thanks.

----------------------------------------------------------------

Changes since v1.7.6-rc0 are as follows:

Alex Riesen (1):
      t3703: skip more tests using colons in file names on Windows

Brandon Casey (2):
      t7508: demonstrate status's failure to use --porcelain format with -z
      builtin/commit.c: set status_format _after_ option parsing

Jakub Narebski (4):
      gitweb: Move information about installation from README to INSTALL
      gitweb: Describe CSSMIN and JSMIN in gitweb/INSTALL
      gitweb: Move "Requirements" up in gitweb/INSTALL
      gitweb: Fix usability of $prevent_xss

Jeff King (1):
      diff_tree: disable QUICK optimization with diff filter

Jim Meyering (1):
      fetch: do not leak a refspec

Junio C Hamano (2):
      diff: futureproof "stop feeding the backend early" logic
      Git 1.7.6-rc1
