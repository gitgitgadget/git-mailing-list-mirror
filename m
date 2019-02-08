Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1011E1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 10:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfBHKPY (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 05:15:24 -0500
Received: from mout.gmx.net ([212.227.15.19]:37763 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfBHKPY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 05:15:24 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LztHH-1hEPNq3S6d-01536k; Fri, 08
 Feb 2019 11:15:22 +0100
Date:   Fri, 8 Feb 2019 11:15:16 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Luke Diamand <luke@diamand.org>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 0/1] git-p4: remove ticket expiration test
In-Reply-To: <20190207232552.4246fec6f3057aea05211141@diamand.org>
Message-ID: <nycvar.QRO.7.76.6.1902081114470.41@tvgsbejvaqbjf.bet>
References: <20190206151153.20813-1-luke@diamand.org> <nycvar.QRO.7.76.6.1902071343210.41@tvgsbejvaqbjf.bet> <20190207232552.4246fec6f3057aea05211141@diamand.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/YoL/qZ7Hp0FcywUrnhqii8P8UX+4SEPBHpCq6curWPEJBJN1kU
 hqTj0ApFIEXH6IdOMb+THdGD2Zwwz7x0xj6HOQVEaLnUA5W1dsM+n5wCGHXDCC20a04gysO
 MxrRDMqgypwSJfP5m1xaffdzjz0ldxmOj0wb55hIiWYmYfFIzpZQbFHVNOzarZ1ij/aOdBR
 IPVFWeM5my6akpAVwPqUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bqC0GluyTt8=:c1n0tCcSMCpU5hCRzTytSW
 YVlp9P4wGm1PIeDjj2qzjNaXU1u8PJ0HGe9AVe2Pr+4HGqnYdQnXSicYPQ/qQrv7rVCjCCX1t
 lXgQpnz+peAU/tIoZbCedSEgHYNz1xCGajztYjdg6uM/D7BIecVo98DI21ALarRs4cSgQ+F2D
 0QIFuL8VPFN3tSK4uASrsZUCuLtMpH3u0P6qztiPo4TDCL+7Ge0MCJ5wwYAq7y4ynAuXaJe7e
 wKQ8EZXnJdWU5zPTzTbCxbX0QFIwRirLxksz1zpA0/8w3iuhO7rHatUg8geCRCY/bW92CMlbq
 ZDNbUfcPOEL+dEGgKVXsfPFHLCV95pl+iVEFGqGR0PdtWDtaXQjR7+Gb1nfsaMmpJYcinSXLs
 jKm62ENwB2xxcOYKbQfVIc0+QtOeRO51zojRhj7tEpNyMU5WNlaB/VeHphOW609ojkXb5IO5W
 AjWvfKJ0QNpky+Ie/Rq1ZXjIJJ9LiHCmG3nDXxo7KFAV96hhRA+PtLyK8QIGGZaz4A4ppdu93
 8EpHdSwNCgqjq4BcHFOZa9uC8l2NUaF3i95wrq6TWyvgKsrKqE7XvGGO7Ry8k6KhMMg6B7/+q
 CMyQ81hOBxkAe9WB+tkbT3HcNBHAJirxQ8ndr9EyHVK3+2CsuiqrOiP2VggLi8tj9nAa5NIvi
 o2eGGy8ZEkgCIsIaXjFYDAoG3v4XLJ3tiDvjWz/VgJRQv8ZjZXDgYGBtukiRCUZGWFnI4G0My
 +wm8C7e+WYHb9nY5VoD2PykzIXWjOHGx+WmVRj69QJyvjxImz6OoahwCu3hTnkdLOK+ijfkDu
 4oioe2W0wvohG7U5SEGQ3FccdnWLfmChqqKVlGJWVRWxQjWxCBV7KaZHc2U9EGJez7/plE5pz
 B5UEAQEqJ8bI+KHHs9TS7IDySDrdPQyNm44XJTeuErdQYEhWL52lbJPRCQzdhfBJIyYDXElp4
 swqmpwooi5A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luke,

On Thu, 7 Feb 2019, Luke Diamand wrote:

> I've got a mocked-up p4 wrapper which returns whatever expiration time
> the test needs. I'll submit it tomorrow.

Great!
Dscho
