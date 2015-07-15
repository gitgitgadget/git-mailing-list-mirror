From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.4.6
Date: Wed, 15 Jul 2015 14:43:14 -0700
Message-ID: <xmqqtwt5umfh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Wed Jul 15 23:43:39 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1ZFUSp-0003JF-F8
	for glk-linux-kernel-3@plane.gmane.org; Wed, 15 Jul 2015 23:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbbGOVnS (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 15 Jul 2015 17:43:18 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38811 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbbGOVnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jul 2015 17:43:16 -0400
Received: by iggf3 with SMTP id f3so46837478igg.1;
        Wed, 15 Jul 2015 14:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=LpxG/G/bJafhCneY0HN5OvBlYZspAj6i71LP5LoCO7Q=;
        b=yd5uqxSYNQWn6VZd6ne39tnk4MWy5wXdHsvSNJixvSiXv2+g1JVHmMzFsQ8a3ToK86
         RwzkzFtVnd89MCr9A4uAb/Nc8lGZ82HIDPUwKKF31eK9OIm7odwwxeFsil9qmxIo10r9
         U+iM/xIR9Sdd7Sn3YB/gE4UY9YOtw2uUOqku2jKfGYdT3AP+nb8lOgwiIZeg9kKCUHti
         Rl772HYOCZufHpux3RG6q/kJg/IrhHYMWXvi67MKBIKgBZIo/zenfQHk8RN4yn3Tw1nq
         s4aLkPCVMR7NTd8mX86cCIYPKRL2ztQ8JayCVMlN9CR5vi3l/ySDNRQSOlfRuDhbujbK
         vL7Q==
X-Received: by 10.107.138.102 with SMTP id m99mr8196323iod.115.1436996595568;
        Wed, 15 Jul 2015 14:43:15 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91d4:b530:378d:909b])
        by smtp.gmail.com with ESMTPSA id l62sm3614408iol.36.2015.07.15.14.43.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 15 Jul 2015 14:43:15 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273997>

The latest maintenance release Git v2.4.6 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.4.6'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.4.6 Release Notes
========================

Fixes since v2.4.5
------------------

 * "git fetch --depth=<depth>" and "git clone --depth=<depth>" issued
   a shallow transfer request even to an upload-pack that does not
   support the capability.

 * "git fsck" used to ignore missing or invalid objects recorded in reflog.

 * The tcsh completion writes a bash scriptlet but that would have
   failed for users with noclobber set.

 * Recent Mac OS X updates breaks the logic to detect that the machine
   is on the AC power in the sample pre-auto-gc script.

 * "git format-patch --ignore-if-upstream A..B" did not like to be fed
   tags as boundary commits.

Also contains typofixes, documentation updates and trivial code
clean-ups.

----------------------------------------------------------------

Changes since v2.4.5 are as follows:

Ariel Faigon (1):
      git-completion.tcsh: fix redirect with noclobber

Charles Bailey (1):
      Fix definition of ARRAY_SIZE for non-gcc builds

Eric Sunshine (2):
      ewah/bitmap: silence warning about MASK macro redefinition
      utf8: NO_ICONV: silence uninitialized variable warning

Frans Klaver (1):
      doc: format-patch: fix typo

Jeff King (2):
      ewah: use less generic macro name
      Revert "stash: require a clean index to apply"

Joe Cridge (1):
      git-prompt.sh: document GIT_PS1_STATESEPARATOR

Junio C Hamano (2):
      format-patch: do not feed tags to clear_commit_marks()
      Git 2.4.6

Matthieu Moy (1):
      Documentation/describe: improve one-line summary

Michael Haggerty (2):
      fsck_handle_reflog_sha1(): new function
      fsck: report errors if reflog entries point at invalid objects

Mike Edgar (1):
      fetch-pack: check for shallow if depth given

Panagiotis Astithas (1):
      hooks/pre-auto-gc: adjust power checking for newer OS X

Paul Tan (1):
      t0302: "unreadable" test needs SANITY prereq
