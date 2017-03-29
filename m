Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C07C1FAFB
	for <e@80x24.org>; Wed, 29 Mar 2017 01:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751818AbdC2By6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 21:54:58 -0400
Received: from mx1.riseup.net ([198.252.153.129]:53972 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751800AbdC2By5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 21:54:57 -0400
Received: from piha.riseup.net (unknown [10.0.1.163])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 2627C1A0994;
        Wed, 29 Mar 2017 01:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1490752491; bh=iwbVsy3jw9d/hTXW7e7Er6EcVfCiBPSssAhMX5V3f3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LzYDvb6aVnNyLw1/D/74pprSfF4RABm+3Q6IhUuJL/oh51BTiUiiOL3+kzHKW0DpQ
         XLs32B4VQRciDU0rLei8B5p6Z6vQWqBhO1G9kXfpSpWjFYYrhnbyJ+n7ce0ZA1+6S9
         XSWW7rQNDA8guccNwjyQLOXKSTPXASYkUwllAlAo=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: pickfire)
        with ESMTPSA id 249BC1C2674
Date:   Wed, 29 Mar 2017 09:54:09 +0800
From:   Pickfire <pickfire@riseup.net>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Subject: Re: Re: Microproject | Add more builtin patterns for
 userdiff
Message-ID: <20170329015409.tla6yx-2k%pickfire@riseup.net>
References: <20170328104652.XsS8a6ysu%pickfire@riseup.net>
 <CAGZ79kaLB3w1dkr-_+zTPTJ8Zs2POOVFcnuJ_CDT6sJi1TxMHg@mail.gmail.com>
In-Reply-To: <CAGZ79kaLB3w1dkr-_+zTPTJ8Zs2POOVFcnuJ_CDT6sJi1TxMHg@mail.gmail.com>
Mail-Followup-To: sbeller@google.com, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> wrote:

> On Tue, Mar 28, 2017 at 3:46 AM, Pickfire <pickfire@riseup.net> wrote:
> 
> >     EOF
> >
> >     echo '* diff="cpp"' > .gitmodules
> 
> Did you mean .gitattributes?

Yeah, that's a spelling error.
