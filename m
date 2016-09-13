Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DC7C20984
	for <e@80x24.org>; Tue, 13 Sep 2016 13:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751711AbcIMNxL (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 09:53:11 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:35676 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbcIMNxK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 09:53:10 -0400
Received: by mail-it0-f49.google.com with SMTP id r192so36564101ita.0
        for <git@vger.kernel.org>; Tue, 13 Sep 2016 06:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yN+qBtzH41fXRghQue9TLKEs1Rpyrxrq+y8lVO0Vu+I=;
        b=Kx/8+uceC8uin0VRxY1LJZJoLysxCGeXccakHZQHppYYowfZFAxL44BNzd2pPJH3LN
         1HpAbMwguRMmEqeo2IJeoUrH+SLfdYDAzvOmYzp30VvKsVHOVG5YFRoRBl+1/fqH7OVu
         ATM92E4czDvXSn70azytj+xzRlWmhqrovR9T3weUtCyRTsCxpo6IdBQDe3mSfdv9Zd0q
         xrxnrsW+jo8QA3c2aD6ko+de+YWdzxADtMhPLb9BXO3FTipLqj97LnSzT88CZqipNzmb
         w9wODX0R03+QPA6RnR2NHEI7m8fGxdqUSPtdbHUuWqMAKLJYnqZMxQUPSZbMnXyMdjP+
         fp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yN+qBtzH41fXRghQue9TLKEs1Rpyrxrq+y8lVO0Vu+I=;
        b=kZ84wnyqNJCjlaZ4YrLFF7zXJn8xmcP3BRtNEep6Q1iqReM1ii6D1P6bNULQ4C9Ir4
         zaTMcD8pGW4hZmlLxMEeZM4blGoOKMIs21LyxI8BoiNlwAJTTkUWsFV9XFin8vHy+SH8
         ap9rHdFIKWvhgERHgxp0yeXMvDkC4cJW6eFz2r6Ddgdle2MwcFcpU5PDPZ9n2IdEWsHE
         wRzFMikPMA8M87skKm7TY/lKo6VWFbfdt8PQbZzfvn/QWF5NRIWdVbXKEMyWrNhSxw3p
         5HNSnVEG77DhxcPBBbf3eva840Gnk3X4ydfEOjGITNHVAicl06HO07JZMpxPHqxWXKNP
         rMEw==
X-Gm-Message-State: AE9vXwMIzUbSb6GQhV90VYT5rhYcu1s/A6gqSaUa/gqkaqv9es2ZViby6XqN8/JYsogiMi/ml3ZTXNXZ2IGDdw==
X-Received: by 10.107.23.134 with SMTP id 128mr1602034iox.113.1473774789326;
 Tue, 13 Sep 2016 06:53:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.226 with HTTP; Tue, 13 Sep 2016 06:52:28 -0700 (PDT)
In-Reply-To: <20160913133224.GB31326@ikke.info>
References: <de39c03d-e84e-8e45-69cb-a2e01fd25df2@gmail.com> <20160913133224.GB31326@ikke.info>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Tue, 13 Sep 2016 15:52:28 +0200
Message-ID: <CANQwDwfj7NSHnaGhLCH33w1Eg4r_NCvs9_e8Dj2fMMUc8b78Aw@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git User's Survey 2016
To:     Kevin Daudt <me@ikke.info>
Cc:     git <git@vger.kernel.org>, Doug Rathbone <doug@dougrathbone.com>,
        David Bainbridge <david.bainbridge@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Andrew Ardill <andrew.ardill@gmail.com>,
        Eric Wong <e@80x24.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Kevin,

On 13 September 2016 at 15:32, Kevin Daudt <me@ikke.info> wrote:
> On Mon, Sep 12, 2016 at 09:51:09PM +0200, Jakub Nar=C4=99bski wrote:

>>
>> P.P.S. Different announcements use different URLs (different channels)
>> to better track where one got information about this survey.
>>
>> Thanks in advance for taking time to answer the survey,
>
> Can we get a channel for the freenode/#git channel? I'm trying to announc=
e the
> survey there too.

Here you have it:

  https://survs.com/survey/c6wjrerw87

--=20
Jakub Narebski
