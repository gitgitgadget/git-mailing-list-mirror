Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4951C352A3
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 23:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A91F20726
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 23:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=juraszek.xyz header.i=@juraszek.xyz header.b="HgGEAm9a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=juraszek.xyz header.i=@juraszek.xyz header.b="AAFkkdYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgBOXgq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 18:36:46 -0500
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:43459 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbgBOXgq (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 15 Feb 2020 18:36:46 -0500
X-Greylist: delayed 834 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Feb 2020 18:36:46 EST
Received: from MTA-10-1.privateemail.com (mta-10.privateemail.com [68.65.122.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 5C7A780814
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 18:22:52 -0500 (EST)
Received: from MTA-10.privateemail.com (localhost [127.0.0.1])
        by MTA-10.privateemail.com (Postfix) with ESMTP id 23E8860038
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 18:22:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=juraszek.xyz;
        s=default; t=1581808971;
        bh=jVFobVcc4GLo0RuQtkPDOuSH/vHC8Voz5Ns2DA0Z0Mc=;
        h=References:From:To:Subject:In-reply-to:Date:From;
        b=HgGEAm9a74qLQAtrBANaaFkjDIBYyWrLb9iTaMw10iRrUsnE5Os0YLV/WUi2XmDj2
         ir2vzNB0n6leJLBYW5GsI2zbKxkYvsPLwR/7LoVCJax2hiwBWQZTn7FS0bA4/ng8cU
         mRQk4S19QJqOIYXI2ZBOAFr9QH5WaJ5Vxq+BJXTM=
Received: from arch2.laptop.juraszek.xyz (unknown [10.20.151.225])
        by MTA-10.privateemail.com (Postfix) with ESMTPA id 4245B60033
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 23:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=juraszek.xyz;
        s=default; t=1581808970;
        bh=jVFobVcc4GLo0RuQtkPDOuSH/vHC8Voz5Ns2DA0Z0Mc=;
        h=References:From:To:Subject:In-reply-to:Date:From;
        b=AAFkkdYQsqOSCah+reW4zmutA/mqytv8+k4dWit+OT+K2l128tbmtsjPt1NgN80Eu
         ZWEpkEPxCg+iiUJ4Y97Og+a9JxD3i5shiU97wMmepIsnkvOPiM0tSjjQorxKIoFiJq
         Lx4GETA+SO8JHFhd9dKHTRgaJw/OKlUhh74HQDuY=
References: <CAH8yC8mnjmz7cTGzkpVQ2+ss7VGuSZ84hY-kHs8h5k53uEGSCw@mail.gmail.com>
User-agent: mu4e 1.2.0; emacs 28.0.50
From:   Artur Juraszek <artur@juraszek.xyz>
To:     Git List <git@vger.kernel.org>
Subject: Re: What does Git call services like GitHub and GitLab?
In-reply-to: <CAH8yC8mnjmz7cTGzkpVQ2+ss7VGuSZ84hY-kHs8h5k53uEGSCw@mail.gmail.com>
Date:   Sun, 16 Feb 2020 00:23:09 +0100
Message-ID: <87zhdj4eqq.fsf@arch2.laptop.juraszek.xyz>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Hi Everyone,
>
> Forgive my ignorance... What does Git call services like GitHub and GitLab?
>
> Jeff


I believe "forges" is a word quite commonly used around when referring to them:

https://en.wikipedia.org/wiki/Forge_(software)

--
Artur Juraszek
