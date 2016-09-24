Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CC0220985
	for <e@80x24.org>; Sat, 24 Sep 2016 22:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965590AbcIXWf7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 18:35:59 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40610 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965111AbcIXWf6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 24 Sep 2016 18:35:58 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 849DD2031D;
        Sat, 24 Sep 2016 18:35:57 -0400 (EDT)
Received: from web3 ([10.202.2.213])
  by compute5.internal (MEProxy); Sat, 24 Sep 2016 18:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=iankelling.org; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=iv12C/V97txvx+LtOpNql9fNPRg=; b=WAeQEQ
        Yaxe8qvkdCWKzK9HsT1PRpN8VhhSWAlahFXdEjVym6WaEMy204ncGLZPa/vVp0s8
        wVknAD6L7uyljdOHUX511G7clfFFNKvnYmdi2HVbxQ4vIPyMW4J2T2Xel9eUqkkm
        sP1TNevlZ/rPBCZQ2oZtCQLiUhTdP3yrF4EvE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=iv12C/V97txvx+L
        tOpNql9fNPRg=; b=Y2jRnHAvtTYoauXVZAH/eaFWn3FYftBTqNtzLY/PrJBSj4l
        XYXtgxSJ/AS92+aDmiSh9ZWOBOmLr0c8yvs5CGGa35EPMy5iVB9OMmwFYnN1nQZc
        9xihWdydQChdKBw39+vrToxY4UEmss2JskfapmGvJ2MKSHj6m4+kr9u9NsXM=
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 593C62E184; Sat, 24 Sep 2016 18:35:57 -0400 (EDT)
Message-Id: <1474756557.3745593.735971977.2A054EBA@webmail.messagingengine.com>
X-Sasl-Enc: 3TZIBbJVLe/ZZ8yUeO78MLOOwuNpBomqhyC6oO2KvVHt 1474756557
From:   Ian Kelling <ian@iankelling.org>
To:     =?utf-8?Q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-3ce3fca2
Subject: Re: [PATCH v3 2/2] gitweb: use highlight's shebang detection
Date:   Sat, 24 Sep 2016 15:35:57 -0700
In-Reply-To: <946807ff-1570-2d81-1026-06529164f8ef@gmail.com>
References: <2a5aead0-d521-85eb-f304-7091683d8b40@gmail.com>
 <20160923090846.3086-1-ian@iankelling.org>
 <20160923090846.3086-2-ian@iankelling.org>
 <2a4c3efb-2145-b699-c980-3079f165a6e1@gmail.com>
 <946807ff-1570-2d81-1026-06529164f8ef@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 24, 2016, at 09:21 AM, Jakub Nar=C4=99bski wrote:
> W dniu 24.09.2016 o 00:15, Jakub Nar=C4=99bski pisze:
>=20
> Sidenote: this way of benchmarking of gitweb falls between two ways of
> doing a benchmark.
>=20
> The first method is to simply run gitweb as a standalone script, passing
> its parameters in CGI environment variables; just like the test suite
> does it.  You would 'time' / 'times' it a few times, drop outliers, and
> take average or a median.  With this method you don't even need to set
> up a web server.
>=20
> The second is to use a specialized program to benchmark the server-side
> of a web page, for example 'ab' (ApacheBench), httperf, curl-loader
> or JMeter.  The first one is usually distributed together with Apache
> web server, so you probably have it installed already.  Those tools
> provide timing statistics.

Good to know. Thanks.
