Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AF1C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 09:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B700611C3
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 09:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhJVJrH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 05:47:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:35225 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232038AbhJVJrG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 05:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634895888;
        bh=6h3ylan4KvKvAD+ekJ6jxTFEYS23f2izsB6M11IdloA=;
        h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
        b=VytngbXYnHyyQbUIN4ytgmIEdwvD0nQzTQn4WHg1MfwoFM+8bGMQTKeLF0aOZW3bT
         Gv3j3CtRtAX3yW2GGRd236nO0tSD8bcy48VyoiE+imUvpU02SPRnQRJksO+bMDdGwI
         qwvZVHJNxbjrZtuiA05ybUpOG+ECr+kdFaaRlyBo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.19.78] ([89.1.213.179]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhU9j-1n8GIt11Ep-00eZDS for
 <git@vger.kernel.org>; Fri, 22 Oct 2021 11:44:48 +0200
Date:   Fri, 22 Oct 2021 11:44:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: Let's have public Git chalk talks, was Re: Notes from the Git
 Contributors' Summit 2021, virtual, Oct 19/20
In-Reply-To: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2110221143240.62@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Q69oFCqOBGJDKgPM4cjEfwxN+vvxbX4is9MNq9s+Ra7Tk7PyhYo
 fw3+Sws9VNhNzzCZuG9LJoww7k1RCPoYHkiwUm6PHo/eOGFzxL+EDvEAnEZwo96cVYnFU4p
 +RHFKYTrm1o9DCIfxj0Z9mHtjWiTC12vWvz9EFNDB2/HJQzYZ0hFQgjYs/TfLY3XT9Hvjqf
 0otHNOE8sRPZQ0AM+Mmlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tx5/bIi70iU=:epfJ/L/nvAZ+xFm3tLZjho
 ev6DzIoKKhInLz9O6+GWSj4JMCS4LPd7m1QEwOSdImtZwBnZ3l8itsibGWUWb7O6BaoNWjLHc
 hKENbpvVk7CD6MaRwYemUBdX9B1bKNf9pDm3C6oQeEcnNibZJtqFfAYYenD7b8AAWTfCk7oSg
 tnLuOAPuDhNndc9Rz5zs54uN7PR10WG+GFSVcqfZDAP9wh0FdUsMrFrtJ4Dyc1usXLqM1Kf2T
 C4jOmd4Exfn003boDXDIQtN2Zl2Ag7sHWthFjcRJ3NkHwlQZA47KjVZi1DhtlzGcQ2GJ0zGS/
 aipgtTI8zzw9/1UvkBnYg1X6UT5Fcum0Hx6KYFDPV1QuJJ2uNWrpX2ePZtEIri9mdTXlBFIVh
 zWKVRQ58A9v50mJbQssBQlc/CLDKlduUmABSuV12+iPmWk2oS+tdnTQWk1Zn6JOEUeTrBjnHT
 XAk5KJY2adcaDZDZooMCIhj2VltBnFZeF+zy2SvODYkBcxs9pdJeBnTbf9RakcKktT3vM+P+D
 Qyg5OOSDNZmyLNfNAihpbbgbkWhf6hUVgNrTTOYGN9tQg7AF0PsdWDzy8V9WDXZ+xCyu3snYo
 bZp7JU8lX84fHrcb3hXBE/4sdS+XDZR+G0k2xOmjBU//CZi2gU95lLT8lVXzzMikftJYXTrBg
 AP+OINtpf6JVPmLWOpRcuAsBEoSxMpEkmrpciDyRZXR58110e5ZBSJSjh/ozqIAqjljAxGxpl
 iaPVNUE99pClPsuUus9RqbPngWMYPo4pMTJHR7CfnuGVgrTiZnOMHenyTWpTxe8V/vDDcCdff
 88GWTK2A1D0DBuuA84F5Pox3eL+rQjiZeFqLSH/zkXfa7cQuPMq4Yx7wXp0n8bav0InH+hSca
 YOryzBZ8bDNWP8XmDCiL+sfMDDE1CpbuK2VwGybcw1XbR7rS4JQDtIBzqNLKVwyqiEPf7NoqF
 9rJND2QFdTI3hNG3GG3f/SPNDp/mMkLzVYf/kDYH+NWNo9AvW8cx7tlbz+vjXBwk8FMRaSQVm
 sZLUaBEVd9iLyjWHj59BFwbOvoywpt2Bs7mk5cmEKPzg/PBtMfVdL52RKm5hQDRK/cgO46Q1X
 j1atPZtACrsPZY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

On Thu, 21 Oct 2021, Johannes Schindelin wrote:

> * Let's have public Git chalk talks

Okay, I give up on the mailing list. I tried some 20 times to send the
notes out in one form or another, and it simply is not working, and the
time I spent trying was definitely lost time.

So here is a link:
https://gist.github.com/dscho/003a0e112058e5794b5e08e84d34092d

Ciao,
Johannes
