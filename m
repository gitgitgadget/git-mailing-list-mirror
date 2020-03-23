Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75036C4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 23:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C7620714
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 23:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ddCw0UIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgCWX0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 19:26:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63396 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgCWX0s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 19:26:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 26879BFAAA;
        Mon, 23 Mar 2020 19:26:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=1
        F97N76gxng9lvoc5MgE7oGn5Tc=; b=ddCw0UIWskggDN1lRfq3mhGwIgLcYNMfX
        UBlqSa8J4yAtKcDx2TG60VX4jcv3R+4VkKad8O8ZDWSaMJ0hKP0y8NCr5HQsd9FQ
        F4JFOd7evSALia2FKKTPo3lqgq6ou8iqiL5efpQR69JGpjWPn3UsADLcow51sNNZ
        g3NpTIDl2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=lfL
        /x4CTTXkO9zt+n4fnsuV6ZgstksABKsEJgi73nOrY2jH+QqTYJAV6crz1mOALi/q
        vNKHPzJbd7e46DWdVXKDdPIzyh0Dsn59Ojh0rVKAh+C4HmJBQQ+6CdPnsgtMDtOA
        hHnsfx94Ga9BN0FQDiLe5S8pzQ3dmCP9TD2PlUBk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1DD02BFAA8;
        Mon, 23 Mar 2020 19:26:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 468C1BFAA6;
        Mon, 23 Mar 2020 19:26:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Season of Docs?
Date:   Mon, 23 Mar 2020 16:26:41 -0700
Message-ID: <xmqqh7ye3b66.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C17176D6-6D5D-11EA-A9B5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a companion program to GSoC we might want to participate.

  https://opensource.googleblog.com/2020/03/announcing-season-of-docs-2020.html
  https://developers.google.com/season-of-docs/

Many places in our docs clearly show that they were written by
developers, which we may want to rectify.
