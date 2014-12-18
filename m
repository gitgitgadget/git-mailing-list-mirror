Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 15756 invoked by uid 107); 18 Dec 2014 21:11:55 -0000
Received: from Unknown (HELO cloud.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Dec 2014 16:11:55 -0500
Received: (qmail 28320 invoked by uid 102); 18 Dec 2014 21:11:44 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by cloud.peff.net (qpsmtpd/0.84) with ESMTP; Thu, 18 Dec 2014 15:11:43 -0600
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbaLRVLZ (ORCPT <rfc822;peff@peff.net>);
	Thu, 18 Dec 2014 16:11:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55478 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751107AbaLRVLX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2014 16:11:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A87EE27F3A;
	Thu, 18 Dec 2014 16:11:23 -0500 (EST)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=V
	aPfbUy2huFTXE1Ia1zlMXRvFjw=; b=w/vZ8qmCkO/jsChzXBCdN3sLo4wb9EQKY
	C/Np0a5SLqW7s8oProE3epson7hNE0z9g7yD3iTawsKvybgFppAkwlhTDJv8dqLf
	ONHp2wD27gakogYYFbEkvV1HUOFS9v1aoS/4LXinpHoAJwFr0FRDEPBnwtdtG1Y9
	m4//pR/L50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=JO3PM/JusOUONJceC7wqJlWaFQzvaYXKTnpIpNvNrD16680x6uV0aWvk
	x4V6UX4KMEuyC3lu1d1VGQ8n/RKtbhHFZ3jQg8+CtKITFieAg1z0JOgzUVG4e0PN
	5DAD0EOL3Gv9tBBuoDdlQrqEI7UhHmhQ5v9ke6i9JFlVEjnmoy4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9ECF827F39;
	Thu, 18 Dec 2014 16:11:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 242C527F38;
	Thu, 18 Dec 2014 16:11:23 -0500 (EST)
From:	Junio C Hamano <gitster@pobox.com>
To:	git@vger.kernel.org
Cc:	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.2.1 (and updates to older maintenance tracks)
Date:	Thu, 18 Dec 2014 13:11:19 -0800
Message-ID: <xmqq61d87jew.fsf@gitster.dls.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B8274E0-86FA-11E4-A612-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The latest maintenance release Git v2.2.1 is now available at
the usual places.

This is a security-fix for CVE-2014-9390, which affects users on
Windows and Mac OS X but not typical UNIX users.  A set of new
releases for older maintenance tracks (v1.8.5.6, v1.9.5, v2.0.5, and
v2.1.4) are published at the same time and they contain the same fix.
Various implementations and ports, including Git for Windows, Git OS
X installer, JGit & EGit, libgit2 (and Visual Studio which uses it)
have been updated at the same time.

Even though the issue may not affect Linux users, if you are a
hosting service whose users may fetch from your service to Windows
or Mac OS X machines, you are strongly encouraged to update to
protect such users who use existing versions of Git.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.2.1'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Git v2.2.1 Release Notes
========================

Fixes since v2.2
----------------

 * We used to allow committing a path ".Git/config" with Git that is
   running on a case sensitive filesystem, but an attempt to check out
   such a path with Git that runs on a case insensitive filesystem
   would have clobbered ".git/config", which is definitely not what
   the user would have expected.  Git now prevents you from tracking
   a path with ".Git" (in any case combination) as a path component.

 * On Windows, certain path components that are different from ".git"
   are mapped to ".git", e.g. "git~1/config" is treated as if it were
   ".git/config".  HFS+ has a similar issue, where certain unicode
   codepoints are ignored, e.g. ".g\u200cit/config" is treated as if
   it were ".git/config".  Pathnames with these potential issues are
   rejected on the affected systems.  Git on systems that are not
   affected by this issue (e.g. Linux) can also be configured to
   reject them to ensure cross platform interoperability of the hosted
   projects.

 * "git fsck" notices a tree object that records such a path that can
   be confused with ".git", and with receive.fsckObjects configuration
   set to true, an attempt to "git push" such a tree object will be
   rejected.  Such a path may not be a problem on some filesystems
   but in order to protect those on HFS+ and on case insensitive
   filesystems, this check is enabled on all platforms.

A big "thanks!" for bringing this issue to us goes to our friends in
the Mercurial land, namely, Matt Mackall and Augie Fackler.

Also contains typofixes, documentation updates and trivial code clean-ups.

----------------------------------------------------------------

Changes since v2.2.0 are as follows:

Hartmut Henkel (1):
      l10n: de.po: fix typos

Jeff King (8):
      unpack-trees: propagate errors adding entries to the index
      read-tree: add tests for confusing paths like ".." and ".git"
      verify_dotfile(): reject .git case-insensitively
      t1450: refactor ".", "..", and ".git" fsck tests
      fsck: notice .git case-insensitively
      utf8: add is_hfs_dotgit() helper
      read-cache: optionally disallow HFS+ .git variants
      fsck: complain about HFS+ ".git" aliases in trees

Johannes Schindelin (3):
      path: add is_ntfs_dotgit() helper
      read-cache: optionally disallow NTFS .git variants
      fsck: complain about NTFS ".git" aliases in trees

Junio C Hamano (6):
      Start post 2.2 cycle
      Git 1.8.5.6
      Git 1.9.5
      Git 2.0.5
      Git 2.1.4
      Git 2.2.1
