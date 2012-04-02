From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.9.6
Date: Mon, 02 Apr 2012 14:42:07 -0700
Message-ID: <7v8viderps.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Mon Apr 02 23:42:24 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1SEp15-0001Xg-87
	for glk-linux-kernel-3@plane.gmane.org; Mon, 02 Apr 2012 23:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291Ab2DBVmM (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 2 Apr 2012 17:42:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57737 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751861Ab2DBVmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Apr 2012 17:42:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 274077F20;
	Mon,  2 Apr 2012 17:42:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type; s=sasl;
	 bh=fyHqEYBmKJlq/vTgiiW1+JkPTqY=; b=TdkJUNrC7SikIcDR6YO1F62/jYfD
	M5snXcbLx8BklqxEbYbKTK1+PWx+91F4TXHCcqHHUE0xh/JT6gPAZRdVlDjsg1+c
	Jwo/aovIGBWXup4P4S8+qi+xUee1f2GZf5NhzxoiSBLWk7iqccjWM/HZrcmvodpU
	mGZRIEipZhhMZko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	dS1gtGABaCVLLK2F9KDy2lkUdir8ikntrAhxKLgZ3bd7MkWC8A1+yRY1M2orz2pm
	qNfjH/6BKUSjuTzZe/ttY4GXUE+Zgk7nS856RX0hXXq1UcBQUv0H+O+iLWIbyItS
	wS60Q5ZD+2T3+uzefsajTjRy6VBK2wMmQ6dTgZIo0wg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D28D7F1E;
	Mon,  2 Apr 2012 17:42:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A79857F1D; Mon,  2 Apr 2012
 17:42:08 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B294485E-7D0C-11E1-BC15-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194567>

The latest maintenance release Git 1.7.9.6 is now available at the
usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

71c5a5acdef77cd8d29a4ae5d4fe7f2889f495b5  git-1.7.9.6.tar.gz
e744796212ac536ac1b9b1d84e750cb02775ac0f  git-htmldocs-1.7.9.6.tar.gz
43441aaa208b1f948f5a006e818a1a34dcda6740  git-manpages-1.7.9.6.tar.gz

Also the following public repositories all have a copy of the v1.7.9.6
tag and the maint branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git


Git v1.7.9.6 Release Notes
==========================

Fixes since v1.7.9.5
--------------------

 * "git merge $tag" to merge an annotated tag always opens the editor
   during an interactive edit session. v1.7.10 series introduced an
   environment variable GIT_MERGE_AUTOEDIT to help older scripts decline
   this behaviour, but the maintenance track should also support it.

Also contains minor fixes and documentation updates.

----------------------------------------------------------------

Changes since v1.7.9.5 are as follows:

Heiko Voigt (1):
      string-list: document that string_list_insert() inserts unique strings

Junio C Hamano (2):
      merge: backport GIT_MERGE_AUTOEDIT support
      Git 1.7.9.6
