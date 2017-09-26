Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B965202A5
	for <e@80x24.org>; Tue, 26 Sep 2017 06:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754027AbdIZGJF (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 02:09:05 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:56821 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdIZGJE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 02:09:04 -0400
Received: by mail-pf0-f170.google.com with SMTP id g65so5054241pfe.13;
        Mon, 25 Sep 2017 23:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version;
        bh=ijD2MVKnOV9bSk/dUQqlWwZ1woQopJjDgd64K373cfA=;
        b=nvRZzmGH+cMxp5Hkzu33I25pDuMw3ciSVVAAfS6n47e9gBfsMSoM/EZ0TlAu7zlhsA
         MfjYEa6sVD06CWggJXrwcpiqR0hb9bfmcG2YOSf+sRjxPmdo1kLVtShCqYLWv+lDi+MF
         gAd+GTx0cSyzqP+f6hKgFKPFCukaWwYp3cnsDL1fGfrZEh3TnNDvEY2wERrnLsVe9qgV
         pUm/IrMG+auQNtpzZm0xbi1ICJ44Q+mfCWwM7rizJXnA7y5Vrk/upl80Ow7G2/IXTWAl
         wt55qmt6W7lhjoAjZlACHiGTzeOdn/4gpjYsCN5jlYEnmj0xPjjMqLg0rO7PCqcfQN32
         aNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version;
        bh=ijD2MVKnOV9bSk/dUQqlWwZ1woQopJjDgd64K373cfA=;
        b=DQ815REMB3xbVNRHaIlmDs/VW3wKnzGM7jUnTqTosnqCUtKHF/vobyVrRKwSOxNQla
         XSwTBP3oBHgGwJPbgKWInty7mhEZ3KtDO9Ls3U+fKOXY/4pRSgZAYKx7SRr1bCYsxqge
         T6+LUS68eWWPax9KT4LFjognlHs1Ulmd3BJArF0EzneZr54qBlt8FWl2XDW70/zxBn9l
         uf5QWUnu8l8NNkt93ENC5EukgJlDJJFDOGvzROdmN8VAzLK0X9dWw3pn9iHrEeL5sSzv
         86NNVcHCJQVWul7C7MRQ1rQ1Ytp4R9/ZaK4dXDsbKiYI+YCH2pqx18RsEbccQbkf1+Ac
         6XBA==
X-Gm-Message-State: AHPjjUgznLCDOQ/fa/xC0P6QvzdCRVCglMTJVfcSYx2s/tMjolqXWT3L
        5pEGAOzMt4SUczEE7NLkDuJ9mZS5
X-Google-Smtp-Source: AOwi7QDXhCV9fNO5xDyfovC9I/nGiuxj/xIKX1MKA9HP2nqKxr7ADnmhCdwsCRRBhYQXhJ1lOWqFVg==
X-Received: by 10.98.60.14 with SMTP id j14mr9696537pfa.51.1506406142900;
        Mon, 25 Sep 2017 23:09:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8cad:f525:a0b8:9738])
        by smtp.gmail.com with ESMTPSA id c16sm14615510pfj.123.2017.09.25.23.09.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 23:09:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.13.6 and others
Date:   Tue, 26 Sep 2017 15:09:00 +0900
Message-ID: <xmqqy3p29ekj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maintenance releases Git v2.10.5, v2.11.4, v2.12.5 and v2.13.6 are
now available at the usual places.  These are solely about hardening
"git shell" that is used on servers against an unsafe user input,
which "git cvsserver" copes with poorly.  A copy of the release notes
for v2.10.5 is attached at the end of the message, but the notes for
other releases listed above essentially say the same thing.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.10.5',
'v2.11.4', 'v2.12.5' and 'v2.13.6' tags and some of them have the
'maint-2.10', 'maint-2.11', 'maint-2.12' and 'maint-2.13' branches
that the tags point at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

Note that the committed version of the release notes for these
versions all incorrectly mention "git daemon", where they should
have said "git shell".  It has been corrected in the attached copy,
but because the release engineering was done several days in advance
and the tags have already been shared with binary packagers and
others at the git-security@googlegroups.com mailing list, these
release tarballs are issued _with_ the known typo to avoid confusion
of having two release tags with different contents.  Sorry about that.

----------------------------------------------------------------

Git v2.10.5 Release Notes
=========================

Fixes since v2.10.4
-------------------

 * "git cvsserver" no longer is invoked by "git shell" by default,
   as it is old and largely unmaintained.

 * Various Perl scripts did not use safe_pipe_capture() instead of
   backticks, leaving them susceptible to end-user input.  They have
   been corrected.

Credits go to joernchen <joernchen@phenoelit.de> for finding the
unsafe constructs in "git cvsserver", and to Jeff King at GitHub for
finding and fixing instances of the same issue in other scripts.

----------------------------------------------------------------

Changes since v2.10.4 are as follows:

Jeff King (3):
      shell: drop git-cvsserver support by default
      archimport: use safe_pipe_capture for user input
      cvsimport: shell-quote variable used in backticks

Junio C Hamano (3):
      cvsserver: move safe_pipe_capture() to the main package
      cvsserver: use safe_pipe_capture for `constant commands` as well
      Git 2.10.5

joernchen (1):
      cvsserver: use safe_pipe_capture instead of backticks

