Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C4FC3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 14:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F6120838
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 14:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QKqU3PCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgCCOSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:18:14 -0500
Received: from mout.gmx.net ([212.227.15.18]:51811 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbgCCOSO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 09:18:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583245091;
        bh=vY/t39dGRfWhXyzMt4BesalAkpZ3OK7RIawBg6lKCPw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QKqU3PCNSVNTcEjVIMEziePcZW0cEemsIxYdbrdgg9YegdwD3eVVY1i5lrv0StkW0
         ruQzdY3jaCh59njog2TqLZuPcf448pUUDFp2PGLKQXxXd0jURqFPM/No7oeo6f0HUO
         E8lLjLFlDa5uo77JDR1bFeKNrAkJ67sbf44UjwDo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.213.69]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MiJZE-1jcQmj1zqI-00fTck; Tue, 03 Mar 2020 15:18:11 +0100
Date:   Tue, 3 Mar 2020 15:18:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
In-Reply-To: <20200302230400.107428-3-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.2003031516501.46@tvgsbejvaqbjf.bet>
References: <20200302230400.107428-1-emilyshaffer@google.com> <20200302230400.107428-3-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1DiDSSS3fFP7O6MB1TrkF/DFAi6Cj3ucefVt6KsFDm1xmmzml1F
 8KGq4jgYrzaF/XP50weE/UbK7URylCN2eOz5nHnHa98es68FV83nDIpZIfFJeOtUSK/ZhRb
 8AWzSl/vSjqmX1clM5oBOFYv2oDJ4dhomsUAYgulN4j7VCrdb2KA5c8VB9htOawqtNrE3Xj
 pRiUQvG1VJb22z0BqS80g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5beR1Q//SEo=:1OedKhxDGKbCS+LEL7+4Jq
 L6tYkdV5UEDkjdCz8Rk5AJNYDNa4/VbxWlveG3G6hQDo5XB+4q3tRfTniiOkZNryFi9seNy3y
 iYL383LkEUqf3Fk24fr3YCTkkfndXurnyNQX33LSzYKkq4dqi4KKVdnW6zezQKaL7goqt8mix
 0F6UYiI80owTvOXtDngJ/q5eASW9IiwuG8bjW6XKkRjPgI9SLKieHpwXjZ/sujbmu0CD2tawM
 uqsUbL9pZOhq8vSB8oOeK6R1rVFo0XuoqBA/sf2u3nZX3kIjmyXghIMKB+t1PJ2BvHJV6/te9
 ydo7xn9ghWOu3T4EujQlp4pQsXC0arX+dhr3FkZyGW2Q55u7hJclrR0VGYkLCuibayoZq2GcA
 xG7Jil89yBMVB6ewppL2CDQ6mfvhDz3dZTytE8feoggPuW7UWcHKLjsvqkorCHts24nplbvvd
 M35TVDBgphvo+ZB9JNc7IrWR6Ui1rzKtwy1E+rhBdNu3NL+1v72oF6A3hURpC9uFeKjLsLx5+
 RWG+a4bx8KzTlfJuZMFOOtlA+Knam/ETcdzvxXhAEFtn6wMb0wflHzGr/IGNoQES1xq8Fw7iu
 P/Upy03JtmNB4PmdUI9Hilc6BHlDBBbzovwXkMAoR4qjRiZCdRscK0GmHTvJQBOZsYhcsl+NW
 D6ovZZpXv5//1lo7I/8HxdCN1w+PfsfQHdOELl6PK0N+VYOgqxM856zbrdEZfFCH9rSEEejH9
 1ICh4pPjZSCP3AxofalM88wZuU5xrt3XtRuO7sWNKyGsOqSb5jo6hlr8aivb7BuSf+XGLePuc
 hJWdiwlTdtInVe7w/98P2Fw9Bf+PGXNR5NLj5iiCUQR0D+qrqoP9Uc/0EssTo6O+tWpvnVEVy
 Lb1XKXBqxKc/u8WpmJj99fVMY/YgziJNJX7JU9qlxJWDcuwYSwSKz3jXwedF23k15yfNjNG6F
 Nu5NRzC5NRgl12PsWwzCQ+Ryobia1bvwGXE8X7ZbAG8jPbOqQwfUBlweIXWp2GW6JKQvOj6Bc
 vtUiWHRHARwzNay2mDPfK0kcUTlcWpSEF9l4BjwN0VqHM/rDkgTcrWgfTXAUaftDT/qeVx3wq
 7xEUqGWz2WopiZ9Rb7cqf6Lw6w2e0zQ4bt6yKK/s4W/6nFK1+LoUvBchrwifcdrIJvVGH+BzY
 agq46c5CIMqUQddijgHM/03XiMsZBNWesmYTLddvm7K+YjbWd7zXWyudOO2on54KaisV6nvZk
 bDqi300xzcIwMCuVc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Mon, 2 Mar 2020, Emily Shaffer wrote:

> +	char *option_suffix = "%F-%H%M";

Unfortunately, this still is not an `strftime` format we can use on
Windows. I still needed to fix that in the previously-mentioned manner to
fix the test run on Windows.

Thanks,
Dscho
