Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F09C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 04:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E2B2206D4
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 04:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="lr7n9gGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgD0Eev (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 00:34:51 -0400
Received: from mout.web.de ([217.72.192.78]:50749 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgD0Eeu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 00:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587962088;
        bh=0jiHQpOmpo5opSJIbjGGj/2GeVQoIcbc6J3y/pcLWxM=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=lr7n9gGr617EY3nLey2krPuujDiMDjMEtnC5UG6zuTIDUnwk7rSTLf74vmAh9qoP5
         9D8ayAFeSYBXk09drf0ycyfUgGQakIa+CdDtAcWsocMDfP8hC4yMyhgF6e1ceYKQSO
         cGCDLA+PsSGciMjustKLuB4ihRn/Zhz1J4gaKH3Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.209.41] ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LpwB1-1iwuml2tJn-00fmDe; Mon, 27
 Apr 2020 06:34:48 +0200
To:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Compilation errors in git.pu/refs/reftable-backend.c
Message-ID: <575af27b-3823-2db5-ad3b-3c6cd7a95faa@web.de>
Date:   Mon, 27 Apr 2020 06:34:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MTZEDAoARUDzyrnhN+PbyG64gKeBBKe5kjMPQ0FzF5/olibczN6
 L5mFYiU4+n0KYAjDBQ7cLgICRGv2C3zqD3xT6hU+pgSvl+J+xRcy6kY8yccc8cnPjxOrYTA
 L9KeLvyBpICGeIuOjXQEgrJOMEkjaNWxVSTltDgc+IeZo91CgMc4cUPsZcf9Ny7WKiYao1j
 ft8iAdDilY1idOHPJRqzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XBZDKcZ8i00=:VchD6joqTHV02cEK+3K0bp
 b0po9T7mVrEy3AVJOvWveNLp0rWjpgT1t2oEciwpnM8Exq3T9sFX0htPPfpGRMZTFBO2UfDxl
 C2dEt9vjjP0rw9dK21utk0AGUncKGzl9IHorK6MQJfLPW0W2HxRpwyfaVmAZJd+E0ueUL30Lw
 dB4JhnrBI9WK15NgRCGMPTQs1fLEOHyG8Edv2nkWfbmFzxTEewZcn3q6w4CsCzEqjRVVLuWlu
 eiBsSJQoyWkucQxStDHRvTeWvGzFewr1av/vReoaVicB9kJuOSmEoxNLa2I/arC5j42j3Dxqr
 F2nAMB/m7W/sFt2g1zLHm1JrXCIpwnZq4lnXcc8bBEB3PflqgtvW1zv6B4i1TaP24qajF5GRv
 N1c7IZkIpo9GprxuL+TON3Uekn7z/xDedN1cQ8x3pKC7Rc4B6t/h1/M3uf+KPxRZowljcIO7q
 pYE8WpgMuJMUkNcFgwry4++kLTy/hopi3Ax/RvJxiPc3wmNFN7lWtMsFg6jsUo0IZQ+urFrps
 6senIajdno91Gkp3VX0aZcl3HCclzzQ4WcbIApYTEme90DGYqOiDSHBbeD+CLYW2H1kirRiBp
 pwb4fMwjqWKHklQu/Rk7t6whV+TFDIvAqQbQeh4Ok9W5hJ1LWPaY9nAgCnoW7rMtrjXRX6m7L
 F7/mviw0l86i+mHV+Sn1o69trdzeWMahnW13xB9uAR5x9cRKHxxNTEZf8k/HrDq0aCHHpNLRA
 JXmRHftpzAYiMsvog35LNOP6ly2Po57HAh+kWdsbifBXw9lnjV9y7EwIO+qEG+htCHfTsWXRZ
 UTWOS75kzfex2/BEEfNwYpiZwA1MVZlHAmt1ZNC/e0POOHvZxJzwXec5qHYYpx9u83TuqPq1Q
 UI140ukpr8FNJuMxpk0zgCd7dURKBi2G0uDsyzrGTyGwvH+dLdh8R9ruZ/9SPFITgkS4aOJ7d
 h7aQduf1oyrvlrobdnoNcOqEVcW+i68yXzQmhPAzTwZ4r+Swe3xb5CdLHBmQIJLrEF4KRjMTU
 UD+xu2p6a8B1NTRfv/M/OPrWlDonbivkIQfh4wtZvnef19Dm5CKBf4VFQObOrrFQXsVS+uQQx
 7RYYqk5zt0INqejRGuCGU+L+4Hs8LBKsdhdR35qqUa5QwZjrUlXj54Fh1/dZImPyF+PJrnPcX
 iYqKQqECvJm3nx02do0jok5lEo3U7jK4mIVYUqc5XgtQUBXNErVe58/SxvMDWSLxTuKL9uPKu
 RqxA/r4xwL6gO1ICU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Folks, after the integration of the reftable branch:
Merge branch 'hn/reftable' into pu

My historic (?) compiler stumbles over this code here:
refs/reftable-backend.c
   for (int i =3D 0; i < transaction->nr; i++) {

So I think we could easily avoid the (for int i) construction.
The other observation could be, why we use an "int", when "nr" is
defined as a size_t ?

struct ref_transaction {
	struct ref_store *ref_store;
	struct ref_update **updates;
	size_t alloc;
	size_t nr;
	enum ref_transaction_state state;
	void *backend_data;
};

Thanks for working on Git
