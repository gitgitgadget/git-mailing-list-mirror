Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E2D820133
	for <e@80x24.org>; Fri,  3 Mar 2017 17:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752451AbdCCRfh (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 12:35:37 -0500
Received: from mout.web.de ([212.227.15.14]:58331 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752329AbdCCRew (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 12:34:52 -0500
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LfRiT-1bupNv1YkL-00p8GK; Fri, 03
 Mar 2017 18:02:54 +0100
Subject: Re: [PATCH v1 1/1] git diff --quiet exits with 1 on clean tree with
 CRLF conversions
To:     Mike Crowe <mac@mcrowe.com>, Junio C Hamano <gitster@pobox.com>
References: <xmqqshmyhtnu.fsf@gitster.mtv.corp.google.com>
 <20170301170444.14274-1-tboegi@web.de>
 <xmqqr32gg0o6.fsf@gitster.mtv.corp.google.com>
 <xmqqa894fyst.fsf@gitster.mtv.corp.google.com>
 <20170302142056.GB7821@mcrowe.com>
 <xmqqbmtjcyug.fsf@gitster.mtv.corp.google.com>
 <20170302200356.GA31318@mcrowe.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <ae2b144a-5e39-8178-5161-1d8eb673b6f0@web.de>
Date:   Fri, 3 Mar 2017 18:02:56 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170302200356.GA31318@mcrowe.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:/DfCZZtnNzQKLl9t3yHmU6X02nJsN8HPjEfzR1NC9c3fokzHyiP
 jx5caex+6tt8QlpCLWekdhV0h9SaeNYxn50rL4oglu0yD25LjEk7pnJQQ384torWc9qojZ2
 TuYFeL6IvAd/rmS1lpiiCgAsReB9WtVf2QU0ZGoFsfIB7Mcml1AcfTqFR1GUsZGZ9OKIAey
 GzpQz9z6x8I0Xg8hNny0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YhicxoK9qwQ=:L02bZCz1dXgaL0SyIqzI12
 1vdT2BCboj+usq/TTtVVYobsDLtIOr9zuMRhpBUT82hucywTaqHq09KwA9MKOCoyFVOO2iFIp
 tedF+GUZSj4UdEFJeilb4LLbNVTTzpeHUY4qT6zzisw7P2dSf1Dn9y2vJyqpgZpqFQhsPGiqV
 pAMggidpFKRXqYTzvw93WLENP1KBYNT+V/9+SFWOYjzSPwJWDFvvOF6qF4apzFXvk169snqEa
 1oIKteXKlwSfSpUNYqgJqK1f/LQzpQ5Fl47qkzm8TsInfhk1a5qVf0t8BDB5IzDBL5l4FPi1r
 hn/Xkaz7NNOSYtg48gLfo4JAWFXGx3zLkOnrkP5jscLA77mwDseXegGdhuMRO7Q2cwQQdmb6m
 qX8FsrpX7LD5i4pVZZAp1gxgW4X1TR0KGBSdhAbIfwlUPhXaKyU8LOnGs8gjIFcIZFeJ6Vkju
 bOz7j4sJQ4qWqdEx36uCo5Qp7Ni+VvTM8pQ8aZjsL1XJXKKvDoA1dBLVFhPOxkC0/fGC7IQrk
 EsoUAH1F4jBB37/Os9T326eIOK/I9yzyGw0Eb4ZDAxCTiazqslOrrBwIhUwgIz17SfI1Yt4h/
 sbV1cp/8gF7u5qyqOUnol1/BOtFIVi9Mwme55wFiD+p7QqG6frVGIjy8SLha+cVofhXHOZilB
 GIR1o7dnhIcXUjzoQdGbNY482fZEYLEHy6zRRPVSqnJy26g3p11EfLrLWpmDHM/6Qe8XDyhnT
 FnurVS1Ht/+cIAlIHBoOM/o37z88IqHLXNQGrIyY3QKNJ45Jg+52DngD8vOkfypHYByyBd1MZ
 XvLChK7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Understood, thanks for the explanation.

quiet is not quite any more..

Does the following fix help ?

--- a/diff.c
+++ b/diff.c
@@ -2826,6 +2826,8 @@ int diff_populate_filespec(struct diff_filespec *s,
unsigned int flags)
        enum safe_crlf crlf_warn = (safe_crlf == SAFE_CRLF_FAIL
                                    ? SAFE_CRLF_WARN
                                    : safe_crlf);
+       if (size_only)
+               crlf_warn = SAFE_CRLF_FALSE;


