Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 721E21F406
	for <e@80x24.org>; Tue, 19 Dec 2017 16:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbdLSQMl (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 11:12:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64353 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751122AbdLSQMk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 11:12:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A0BA5D3AFF;
        Tue, 19 Dec 2017 11:12:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tPb4I7Q4I96VUA0V+9KYu+Sekbw=; b=mXtr7v
        LK/H/ja+nEp1YPt+Q6CKHXUVldkiCi0gvBWKfKxF2WgNL/fKlIyCpZq8V1yTZlMp
        LV1+fkfLjOpbtry3isW6ZIE9UVFFvQnN1vB3xoQu4QvsdyfyCqR3972CpmTzm6iR
        VRFGrJX7nT5uvLmGp1cTT5IhmUcIVBeUgYIlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EtV5JlbWoAgp4mMJ2H+SDFoQraDXYngO
        e2FZ9Fo7du33tQeF7a/7uixZe5yYmN6agN16PEBQQJj7QH/aZX8P17wA8vfZZwxr
        rpOKNd1U+MFDhQodqjGXNJ53dIOSpED38in0aMFQLLtqnTKJXkMlIF2ylPrKCp6W
        0iIODWdgwRM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9871AD3AFE;
        Tue, 19 Dec 2017 11:12:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0FCB4D3AFD;
        Tue, 19 Dec 2017 11:12:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub Zaverka <jakub.zaverka@deutsche-boerse.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: difftool uses hardcoded perl shebang
References: <f5d4c8e7bceb410a95a34a8cce4c31dd@deutsche-boerse.com>
Date:   Tue, 19 Dec 2017 08:12:37 -0800
In-Reply-To: <f5d4c8e7bceb410a95a34a8cce4c31dd@deutsche-boerse.com> (Jakub
        Zaverka's message of "Tue, 19 Dec 2017 13:28:09 +0000")
Message-ID: <xmqqpo7awvbe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F146C7E-E4D7-11E7-9AE8-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Zaverka <jakub.zaverka@deutsche-boerse.com> writes:

> The below email is classified: Internal

Internal to what?
