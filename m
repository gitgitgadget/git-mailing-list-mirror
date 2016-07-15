Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED967203C2
	for <e@80x24.org>; Fri, 15 Jul 2016 21:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbcGOVWV (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 17:22:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51731 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751957AbcGOVWT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 17:22:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E6DC2C803;
	Fri, 15 Jul 2016 17:22:17 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=f
	fRbEs4QDkqis76qWsqwL+8OCfE=; b=sfjX6AiIEvJciEUSFGiBgEDRzCaavQYEZ
	6xF3+1YiaU0H528UhqeXhwOoDWD7JTGvEjCVisoias0vwcFZ+6YWenu9TeAGmO2u
	kvTm9JMZsdc8zPVWAqWFLP9/QqZse79jA7c6HZFUnIFFRi4MHZtn1ZtJf5Z20cEI
	q8ZDmyJJo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=Gb0cnmXqd6mTWz7F0kB4D1/KtIKInZxfxcijwI91CUqmfJX0GizYNzuD
	ILVsdjA8VbIwbLeYZYrqvsZk0sB+Rj6b+vCKZu0hivRNEys9fScFo/Tc9lkxKHEh
	pfjM81010jhKgmoVnWG/2r9f1yq2Qmx+HZ7Qac6qifBpNJKeH1g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 51B592C802;
	Fri, 15 Jul 2016 17:22:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C502D2C801;
	Fri, 15 Jul 2016 17:22:16 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	git@vger.kernel.org
Cc:	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.9.2
Date:	Fri, 15 Jul 2016 14:22:14 -0700
Message-ID: <xmqqlh12lhq1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34A512C8-4AD2-11E6-8A50-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The latest maintenance release Git v2.9.2 is now available at
the usual places.  This is only a fix to the test suite; there is
no change in the actual code produced for your daily use of Git.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.9.2'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.9.2 Release Notes
========================

Fixes since v2.9.1
------------------

 * A fix merged to v2.9.1 had a few tests that are not meant to be
   run on platforms without 64-bit long, which caused unnecessary
   test failures on them because we didn't detect the platform and
   skip them.  These tests are now skipped on platforms that they
   are not applicable to.

No other change is included in this update.

----------------------------------------------------------------

Changes since v2.9.1 are as follows:

Jeff King (1):
      t0006: skip "far in the future" test when unsigned long is not long enough

Junio C Hamano (1):
      Git 2.9.2

