Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7F7E203C1
	for <e@80x24.org>; Mon, 12 Dec 2016 20:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbcLLU7d (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 15:59:33 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:29597 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752366AbcLLU7d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 15:59:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1481576370;
        l=326; s=domk; d=b-i-t.de;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:From:References:To:Subject;
        bh=9Wmmp6sxIN6DrtO+CHTogRX+w1o4HXizdyP3Ht8srrA=;
        b=WKGwYw/6ayUP6z8kYu/7RhYrujgGkcUAZBwrhX6dX7z+0W43OH6XIi+bMLGR2IKIjm
        JRLNB5pDA7rIZqQt5jMTpOXxEtCl7yRddHZOXl+I4mvyoaXNRuzM8pm4Qw1rpmTpbs89
        YJn+VLsXUa+IAYoD3VGJkvRXWVagTeGeNt9uI=
X-RZG-AUTH: :O2kGeEG7b/pS1E/0QjKnx+zgSGDobGo6ayyb8wnG7jYw8Shi4OlnUleywpA8nM0=
X-RZG-CLASS-ID: mo00
Received: from office.b-i-t.de (unitoffice.heagmedianet.de [213.157.19.91])
        by smtp.strato.de (RZmta 39.10 AUTH)
        with ESMTPSA id 60b34dsBCKxUBPt
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate)
        for <git@vger.kernel.org>;
        Mon, 12 Dec 2016 21:59:30 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by office.b-i-t.de (Postfix) with ESMTP id A004254051;
        Mon, 12 Dec 2016 21:59:29 +0100 (CET)
Subject: Re: [BUG] Git-GUI destroys the author name
To:     git@vger.kernel.org
References: <588ac268-0a1b-6787-e6a1-4164e7e9a784@b-i-t.de>
From:   bitjo <jo+github@b-i-t.de>
Message-ID: <3bb063a6-7689-1f1a-39b7-95c315a5947c@b-i-t.de>
Date:   Mon, 12 Dec 2016 21:59:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <588ac268-0a1b-6787-e6a1-4164e7e9a784@b-i-t.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Addition to the bug

Proposal
https://github.com/git-for-windows/git/commit/30395c645adf21828bbccbdcd3c5c36c39f07050
should be considered and possibly implemented.
But as described in
https://github.com/git-for-windows/git/issues/761#issuecomment-221057828.
And then an implementation without regression is necessary.

