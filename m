Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44431FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 20:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbdBNUyS (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 15:54:18 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:21623 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbdBNUyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 15:54:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1487105654;
        l=513; s=domk; d=aepfle.de;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Subject:Cc:To:From:Date;
        bh=qoZn6Wso2VNfL1+TdkVxC1IyFa2iV7oHgicnsSCVoBw=;
        b=SZjPGJ98hsqmU4u+qhjoUjH4TzY0S4h1cRGSaGGs+OS7DIz/G2oEkCmzSyKtgFdJdP
        KsgL8+USIbDFhp7iaoU4d9s5mnS4TvNZlBAQga/vSKyv4Ossv+n5dtgbowE+qzONdpxS
        Z1RfTqBuNNiy9VpwpHYd35LUypp7bd4Pw6ZFo=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+zrwiavkK6tmQaLfsxs2aAREi5ot6NU0wDBWWeW25QkpkaVPRNR/WGwYzqxpk0rRpE0c=
X-RZG-CLASS-ID: mo00
Received: from probook.ubnt.lan ([2001:a61:3430:6aff:7470:afe4:5c34:8968])
        by smtp.strato.de (RZmta 39.12 AUTH)
        with ESMTPSA id d08837t1EKpAPhX
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 14 Feb 2017 21:51:10 +0100 (CET)
Date:   Tue, 14 Feb 2017 21:51:03 +0100
From:   Olaf Hering <olaf@aepfle.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: missing handling of "No newline at end of file" in git am
Message-ID: <20170214215103.7d5e5f4c@probook.ubnt.lan>
In-Reply-To: <xmqqh93w8q0r.fsf@gitster.mtv.corp.google.com>
References: <20170214201104.GA26407@aepfle.de>
        <xmqqh93w8q0r.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Tue, 14 Feb 2017 12:40:36 -0800
schrieb Junio C Hamano <gitster@pobox.com>:

> Olaf Hering <olaf@aepfle.de> writes:
> 
> > How is git send-email and git am supposed to handle a text file
> > which lacks a newline at the very end? This is about git 2.11.0.  
> 
> I think this has always worked, though.

For me it complains in line 721, which is the problematic one.
I try to apply from mutt via (cd /some/dir && git am), but that
probably does not make a difference.

How would I debug it?

Olaf
