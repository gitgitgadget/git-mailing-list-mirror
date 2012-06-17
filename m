From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.7.10.5
Date: Sun, 17 Jun 2012 15:24:18 -0700
Message-ID: <7vd34x60h9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Mon Jun 18 00:24:41 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1SgNtg-000380-MS
	for glk-linux-kernel-3@plane.gmane.org; Mon, 18 Jun 2012 00:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757657Ab2FQWY0 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 17 Jun 2012 18:24:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64649 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544Ab2FQWYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jun 2012 18:24:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E50359936;
	Sun, 17 Jun 2012 18:24:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=W
	uNIfXWs2Fd9uFk3AmzTFzcDStA=; b=ME+Dds1OAXIn5eP5NVWiknrhl8+dl2+q/
	h5RXNl9B6YWBr9+9dWhSwjdt89sri6Cjj8qJXFtg4f0LwdqJLcJOzwa/iDgTYE2R
	2Uoee7D/KkaFsN2R6yPOXnQH6rJuGnPA9uq0RwXPvFAUqNkrryCmitZhOt7IP20h
	lal0MZb/xI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=Bg89tGEVW/qpdDsHG55FsyMU1PcsVqAtbcz+d6wwQ7RE1ZYLm2tcQ2HY
	mWvwiq94pVXsSG0db4MVxk1FvscnvkTnRXrkJhlE8dBnyk22qa12jmM7sgcs57g6
	ra3M5HXz/KqpsafzpPgxwi/0QY/Wk7dtC+dAr0CU1oZfRn5sRMo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC3B29935;
	Sun, 17 Jun 2012 18:24:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E37E9934; Sun, 17 Jun 2012
 18:24:19 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E6D51CE-B8CB-11E1-B8E7-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200135>

The latest maintenance release Git v1.7.10.5 is now available at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

9d0767ef195d3971a891efaf11996158cb341499  git-1.7.10.5.tar.gz
3f205417f11a9ae478eb77541df483a8fc4a4bc8  git-htmldocs-1.7.10.5.tar.gz
2249a6481891a349ed9a11dec89a35afec9f9edb  git-manpages-1.7.10.5.tar.gz

Also the following public repositories all have a copy of the v1.7.10.5
tag and the maint branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git


This time I didn't forget to update DEF_VER in GIT-VERSION-FILE ;-)

Git v1.7.10.5 Release Notes
===========================

Fixes since v1.7.10.4
---------------------

 * "git fast-export" did not give a readable error message when the
   same mark erroneously appeared twice in the --import-marks input.

 * "git rebase -p" used to pay attention to rebase.autosquash which
    was wrong.  "git rebase -p -i" should, but "git rebase -p" by
    itself should not.

----------------------------------------------------------------

Changes since v1.7.10.4 are as follows:

Johannes Schindelin (1):
      fast-export: report SHA-1 instead of gibberish when marks exist already

Junio C Hamano (1):
      Git 1.7.10.5

Vincent van Ravesteijn (1):
      Do not autosquash in case of an implied interactive rebase
