Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 251F320281
	for <e@80x24.org>; Tue, 31 Oct 2017 03:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbdJaDQG (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 23:16:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52786 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751900AbdJaDQF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 23:16:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4AE93A7793;
        Mon, 30 Oct 2017 23:16:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cLqPwkwlwdL5nBXRn9twp93u+RU=; b=ca+3Zw
        eFg8EpglATYYZZozoetmCfk95nrkSud3W2o/qP7tMefFRTh0lJK8NySA6PO8l+du
        tDQ5iLGEr52p1XkQpjTYR2maKj/CQdpvAe/60Z7s3r+KH7NubPEygLJVSeYoNzGG
        V7vpnSvVR360stqPlvJVqxiJD5TLsiP7qKbH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Uaf7ngK3WZ1ooz5HYNTv2XJ2ltT25P1H
        ZgBivxC0jAb/AmXeAPf9RrGhoAsesRzxYYYMYJhYyfe/J8WYiidoUT/Nj3ZFpl3V
        IGPkOiXOYFBGKkd/a4oFCAEOLIv7+zXkDlCsRJONno8vxOmVaScWseIpUzMJ3HWF
        bPMVG6khytk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 444B7A7792;
        Mon, 30 Oct 2017 23:16:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A4CFDA7790;
        Mon, 30 Oct 2017 23:16:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     jameson.miller81@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, jamill@microsoft.com,
        peff@peff.net, sbeller@google.com
Subject: Re: [PATCH v5 0/4] status: add option to show ignored files differently
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
        <20171030172140.235797-1-jamill@microsoft.com>
Date:   Tue, 31 Oct 2017 12:16:02 +0900
In-Reply-To: <20171030172140.235797-1-jamill@microsoft.com> (jameson's message
        of "Mon, 30 Oct 2017 13:21:36 -0400")
Message-ID: <xmqqh8ug2ej1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3DBFACE-BDE9-11E7-9F5E-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

jameson.miller81@gmail.com writes:

> Only difference from previous version is to update the commit author
> email to match corporate email address.

Will replace; thanks.
