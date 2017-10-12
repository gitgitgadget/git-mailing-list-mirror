Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25B9A1FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 00:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752804AbdJLA4W (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 20:56:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51182 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752626AbdJLA4W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 20:56:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A367CB50DD;
        Wed, 11 Oct 2017 20:56:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EZvBEV/b3b7jJ8cMmNY96MZZtsg=; b=WaS7BQ
        hRSYEEjdBjmbluUj5GRu251z21KmhxFNx8kBS7JJWDqDMiijvFB52wKZKiUUGiuj
        T7HDVblUdJenWrX0rh3neWPas1uqRE7dqsif2T4RBfQTMhPaDaEQWrL9cf0WMilI
        h9i12jTkI41LQc2NJ8CoYW51vsgRbCM+ps/gA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DNqoMP6w13V+VoG5BuWjn1smRxrZoXmC
        /Juy8PRdL14AW121fLfuEuPorYFsAbxj/3K/4IIvbhgf2s3s98NX+F8gKdY7UqEz
        v6Hwk3k62zvGaVA8jzRDZK73udS3J8vxAgGXxb5VCu2PhTyFxA9ilzCNP12Fa5Jw
        gC4en7VW4j4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AC1AB50DC;
        Wed, 11 Oct 2017 20:56:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 033ADB50D9;
        Wed, 11 Oct 2017 20:56:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        git@vger.kernel.org
Subject: Re: [RFC] deprecate git stash save?
References: <20171005200049.GF30301@hank>
Date:   Thu, 12 Oct 2017 09:56:19 +0900
In-Reply-To: <20171005200049.GF30301@hank> (Thomas Gummerer's message of "Thu,
        5 Oct 2017 21:00:49 +0100")
Message-ID: <xmqqmv4x2ngs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29850B48-AEE8-11E7-8586-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> git stash push is the newer interface for creating a stash.  While we
> are still keeping git stash save around for the time being, it's better
> to point new users of git stash to the more modern (and more feature
> rich) interface, instead of teaching them the older version that we
> might want to phase out in the future.

With devil's advocate hat on, because the primary point of "stash"
being "clear the desk quickly", I do not necessarily agree that
"more feature rich" is a plus and something we should nudge newbies
towards.


