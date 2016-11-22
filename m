Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 030AB1FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 23:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934205AbcKVXfk (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 18:35:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50903 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932900AbcKVXfj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 18:35:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B57F526A3;
        Tue, 22 Nov 2016 18:35:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=6
        cIHUTZmhPlsOuMeDjStdHK3mXY=; b=cq+Ttd4NsarB2P2qronrdB6k6j8OVCL6D
        mVuErId5OBuxwx+5hZ3LhGcbuoKT2A4Xk3A81KbItgeo/UO8jwE7HbcEnMFdf6uL
        4aM4j15bo2guTkC3gDGHIZoIrjaEw6970xtZbY57c8MPUeVoSG9aO3RAB1A/GUZo
        MY/81Pluzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=S8B
        bvxkJHWHacG+VN2uZ9LIOjz0cMVr74OSmd7IqhBrQzbEI1TxW2czsmPTV1a8iYJk
        +av+LsNatlTzbxylGNNCuFmyba8ohfnMcUpk6JiTJHFTDoQc8gdQcISnDKloAtc6
        WpHrxkG5aJgxFBr5hzDoOut5hx67TadyRZdpq04A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2392A526A2;
        Tue, 22 Nov 2016 18:35:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 386F95269E;
        Tue, 22 Nov 2016 18:35:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Announce: delaying 2.11 final by one week
Date:   Tue, 22 Nov 2016 15:35:11 -0800
Message-ID: <xmqqoa17nl5c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5011ED92-B10C-11E6-B95B-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We'd like to cook and merge a few hot-fix topics to 'master' before
the upcoming release, in order to fix minor regressions in
"stripspace" (which affects "rebase -i"), "archive" and "mailinfo"
that were introduced during this cycle.  So I'll be cutting -rc3
soon this week, and hopefully tagging the final by the end of this
month.

Thanks.
