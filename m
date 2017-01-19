Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 193ED20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 21:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751292AbdASVI4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 16:08:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51985 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751220AbdASVI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 16:08:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D2055F5DB;
        Thu, 19 Jan 2017 16:08:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dwXcpB5nxJUx8LRTLfYpr+A/xt0=; b=o3ty99
        sR6iCETVFFYduFAdn4i8tNzHKQcXRb03usX826MeMnBsk7fUSQPcaXehbB3EeOGb
        Sum9uttk2Cuusj65zA6UFboddbooK8lWFomrGK10pfBuBHH1KYc4Lb3mzpTd4oJm
        KeERCk8jdvOuOxMacoO71BqhBtO8kYHxm2vSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gql6d0DoBteEv6jA/wEUv09n6zYMKzKg
        +QSMA7hEfnteaPm0EeCUwINBbuUElEr/qYEN88tWpPwmQjWhJ/fx9zvtuGDeEAkZ
        tMCJ4JlW89sUAT4ZYt908raNjr3LPIj4N19aexC01kSqucduAZ42uvGVxNDlrGc9
        MNsiFCF+qMY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 345865F5DA;
        Thu, 19 Jan 2017 16:08:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 845685F5D9;
        Thu, 19 Jan 2017 16:08:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 3/5] name-rev: add support to exclude refs by pattern match
References: <20170118230608.28030-1-jacob.e.keller@intel.com>
        <20170118230608.28030-4-jacob.e.keller@intel.com>
Date:   Thu, 19 Jan 2017 13:08:21 -0800
In-Reply-To: <20170118230608.28030-4-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Wed, 18 Jan 2017 15:06:06 -0800")
Message-ID: <xmqqbmv2zrju.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 690B81E4-DE8B-11E6-9149-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Extend git-name-rev to support excluding refs which match shell patterns
> using --exclude. These patterns can be used to limit the scope of refs
> by excluding any ref that matches one of the --exclude patterns. A ref
> will only be used for naming when it matches at least one --ref pattern

s/--ref pattern/--refs pattern/

> but does not match any of the --exclude patterns. Thus, --exlude

s/--exlude/--exclude/

> patterns are given precedence over --ref patterns.

s/--ref pattern/--refs pattern/

No need to resend.  Thanks.
