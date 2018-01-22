Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C34121F576
	for <e@80x24.org>; Mon, 22 Jan 2018 05:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751041AbeAVFyF (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 00:54:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51749 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbeAVFyE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 00:54:04 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2EDDBC5F1;
        Mon, 22 Jan 2018 00:54:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=h
        n2uRtIDbH3tt5DtOfB/UbbrMJA=; b=v64lh3Xch14YQLMpjOI2BmjTb/lFtG1qC
        FoncG7CxH4s1bm2qWrzD0jpRDmOmEoWk5OQPYY0EVsEypQRjIolRbYD6wP1l6O/M
        WOHy07x/CvD2NiDP8k+AutMDl7vtYiIqvI0yMJzodtULkOiNWsggmkG9lFLCU1rA
        gPfzUU59XQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; q=dns; s=
        sasl; b=MvzerU2bzSsijwvt7ZDFvdXBVYXVW24H9+sQ4iX33N5ZGb+xUJepl1RN
        ipaL52M+7A4vDMhpICIM8yORXSIENhNHmc4J5bLertEX9l65FjkqGT5GyPKGr1zV
        8wUZuXaho6qzSQD5cAhLsn0AdtQrHjPmNLuF7kzi0WniN9HrlTQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 073FFBC5EF;
        Mon, 22 Jan 2018 00:54:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E89D8BC5EC;
        Mon, 22 Jan 2018 00:53:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.16.1
Date:   Sun, 21 Jan 2018 21:53:58 -0800
Message-ID: <xmqqy3kqmoax.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4693AAA-FF38-11E7-AFE5-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.16.1 is now available at
the usual places.

This is solely to fix a brown-paper bag bug that broke "git clone"
on case insensitive filesystems of certain projects.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.16.1'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.16.1 Release Notes
=========================

Fixes since v2.16
-----------------

 * "git clone" segfaulted when cloning a project that happens to
   track two paths that differ only in case on a case insensitive
   filesystem.

Does not contain any other documentation updates or code clean-ups.

----------------------------------------------------------------

Changes since v2.16.0 are as follows:

Eric Sunshine (1):
      t5601-clone: test case-conflicting files on case-insensitive filesystem

Junio C Hamano (1):
      Git 2.16.1

brian m. carlson (1):
      repository: pre-initialize hash algo pointer

