Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SHORT_SHORTNER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A718C433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 15:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4C7A22203
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 15:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OyjYVjKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgJNPXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 11:23:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53231 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgJNPXM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 11:23:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 05F177BA71;
        Wed, 14 Oct 2020 11:23:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=B
        UTzT3LmHb1AB0CqUvVrDDOr7T8=; b=OyjYVjKIZKdq19TmRx+JJIeSY2OUxLA1y
        wdVWozSrfQ36T3nZnHkiOnV2IpMJg0s28Auzpm1RBvJOi+MP/buy7AYwIYfQ4B5z
        zuFEA8/wobD9iVJfr/EObN1iAnJYydevp2ZjW0XAoImzv4m5TK7ovQdIx5RlUys/
        BDEcYbRPfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=yL8
        9EvVt25tWVi07XXJR2FKyeaP07i7OjhEwruHKpvNaaeipf1p2fln+V6C/UU+pKo6
        Ysg+GxhKPVVahcldwMmc3hNsJO75l7uQoliX6CemTTWBqGI68zQlqdUwlQGZV9LW
        yLdjJ0TR0pwXMtBK+ahNTUOht4uJ7enhudJ61q+o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F2BA47BA70;
        Wed, 14 Oct 2020 11:23:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E22C7BA6F;
        Wed, 14 Oct 2020 11:23:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [Announce] 2.29-rc2 will be tagged tomorrow, not today
Date:   Wed, 14 Oct 2020 08:23:08 -0700
Message-ID: <xmqqr1q0j0gz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A7E4E0A-0E31-11EB-B9A2-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tinyurl.com/gitCal has today marked for Git 2.29-rc2 but I will have
to be off today, so it will be postponed by one day.

Thanks.

Oh, no, nothing terrible happned.  Just that HR keeps telling me to
spend vacation days somehow, so...
