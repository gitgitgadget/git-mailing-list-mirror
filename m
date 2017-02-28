Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D144201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 17:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbdB1RiH (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 12:38:07 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:53923 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750957AbdB1RiG (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Feb 2017 12:38:06 -0500
X-AuditID: 1207440e-ccbff7000000340b-2c-58b5b49d88fb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id B3.D0.13323.D94B5B85; Tue, 28 Feb 2017 12:34:21 -0500 (EST)
Received: from [192.168.69.190] (p5B10410E.dip0.t-ipconnect.de [91.16.65.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1SHYHWs015520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 28 Feb 2017 12:34:19 -0500
Subject: Re: [PATCH v5 24/24] t1406: new tests for submodule ref store
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-25-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <7e5ef9e7-bd90-1917-d8eb-c6310c2744ab@alum.mit.edu>
Date:   Tue, 28 Feb 2017 18:34:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170222140450.30886-25-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqDt3y9YIg+7NOhZdV7qZLBp6rzBb
        9C/vYrNY8vA1s0X3lLeMFjOvWlts3tzO4sDusXPWXXaPDx/jPBZsKvXoaj/C5nHxkrLH/qXb
        2Dw+b5ILYI/isklJzcksSy3St0vgyljwZAJLwWm2imddM1gbGOexdjFyckgImEic39nN3sXI
        xSEksINJ4ueTg2wQzlkmiZPXJjKBVAkLuEns3PcOzBYRSJNYPPk9M0TRBEaJNQ2vwTqYBW4w
        Slya+BGsik1AV2JRTzOQzcHBK2Av8WuvAojJIqAqMXVlNUiFqECIxJyFDxhBbF4BQYmTM5+w
        gNicAhYSU6dMYgOxmQXUJf7Mu8QMYctLNG+dzTyBkX8WkpZZSMpmISlbwMi8ilEuMac0Vzc3
        MTOnODVZtzg5MS8vtUjXWC83s0QvNaV0EyMk2Pl2MLavlznEKMDBqMTDm9G5NUKINbGsuDL3
        EKMkB5OSKG/QDKAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd4dxUA53pTEyqrUonyYlDQHi5I4
        r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IEb/FmoEbBotT01Iq0zJwShDQTByfIcB6g4VM2gQwv
        LkjMLc5Mh8ifYtTluHH8wBsmIZa8/LxUKXHeCSCDBECKMkrz4ObAktQrRnGgt4R59UCqeIAJ
        Dm7SK6AlTEBLXqiALSlJREhJNTCKBxlKHNjQLv953xuXwvo636zNSdpLjrImyMya+O3n45wa
        7djk9+v5Gl2a3228I8j6i4nrhdY55wrtZWmcGw2Ph31JbOZ4Wv/v/dL+LN/8G6FrIwycbFZP
        5r+u9vfY8bdP/s2WifZ/veREwV6eT/1vWrveu+59rireF+ixIeHRvOV1c23iXysqsRRnJBpq
        MRcVJwIA2zKVWC0DAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22/2017 03:04 PM, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  t/t1406-submodule-ref-store.sh (new +x) | 95 +++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100755 t/t1406-submodule-ref-store.sh
> 
> diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
> new file mode 100755
> index 000000000..3b30ba62f
> --- /dev/null
> +++ b/t/t1406-submodule-ref-store.sh
> [...]

I haven't actually read this far in the patch series, but I noticed that
a test in this file fails:


t1406-submodule-ref-store.sh                     (Wstat: 256 Tests: 15
Failed: 1)
  Failed test:  10
  Non-zero exit status: 1

I didn't have time to look into it more; let me know if you can't
reproduce it.

Michael

