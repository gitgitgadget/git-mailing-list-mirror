Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E0E81FE4E
	for <e@80x24.org>; Wed, 29 Jun 2016 11:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbcF2Lri (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 07:47:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:56658 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993AbcF2Lrh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 07:47:37 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LrJTs-1bUE12253k-0133yA; Wed, 29 Jun 2016 13:47:32
 +0200
Date:	Wed, 29 Jun 2016 13:47:31 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: preview: What's cooking in git.git (Jun 2016, #10; Tue, 28)
In-Reply-To: <xmqq4m8c7uo6.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606291345440.12947@virtualbox>
References: <xmqq4m8c7uo6.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VasHkmrFq06ryMMlXmgAAKx5+xIhoEbQz7kUqnEsjC6WEZ7dVOr
 73quRw4GX4r6gTfnD1ZjB3fBKA9zOStAUN+goeucMDjR9l/ovYogkzTB5avL4LyY8jZkHWL
 q3x8I47E5Wjy8nZtzIYSEPBbrEyahiLzZ0naYgMCYtQ5g3agT3Mm630KPKWx3vk2/3aLFMZ
 vBxMb/Oa5VplXE9sDAEBQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:ZU2wxt7GB60=:f+j64wFfa/VSxzDgYfTtGC
 OB46byL/X/eMOHiw+kLWF0RT7MbH6+AXTgfiZyzaKLGAfLk2HjGfGUnI1+BrZSR8QeqG7BpV6
 hOyFWRd2LBSBiSlnGrZ2qjTkpougIr7PXIWdO0gkbzKIiBhj9mHn5VMsoGLryNhOHunCb6XGV
 bLGBBUktMsZxx5cyKaT0RtRcVINsncsaih7bTG55QrSVURqft/FecBJHbkbo86H2+Anm34otT
 QyhlAPlC5khyQa8mQKG5sFihVD/meIxVNLeAq6vbGcTywmSWSm1X44Tr4bH+shYumTYFvuHLD
 WBo+WIq1CqdHdSb5UXS4T7M1x2VUyMT5SJTUA3hR7xx1a57QF0M8UAVUWV0xZdYvJT6vJPnP9
 3UG6JlumY6p0GmqnLX+5sAER6KYiYo2uIU47PQRDVEwnW6tNxAFQuUIVDeznHjsmQMU07oGrQ
 VIV8KzzzsqZXnVSn9mXSSZdPDE9SxhpJY05N0TsPB8UwkDNPjrJymW2AwFJQO+YdzMw4b7/gv
 IECFQNYmsVkL3Q99prUqONsPxNYX/z5z1pSEg0E9qEWU4Ej8eUk3UVnDmQGEp39Am/7jHD9RG
 KqyTlsi0JSAQrQDuS6zzB70V6r11C7VMpl0orDdszkVyzJ2lXrCGwcCnIUvPG1uqjy0cxJyIK
 NV0X/wNB6XNeYONCgudTCnyCYMRJqmWtO7i8WS3OqXn64C+Bcj1jC+gA7M1edawXLWvMHACT+
 cg0duv1Hv8e+oPlCIPDw/hwMI2wM8AndjCme7k5ktN6s+70ZAvEXqaEEYb9SoNSDqSifLiV7S
 tjio0Cl
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Tue, 28 Jun 2016, Junio C Hamano wrote:

> * jk/ansi-color (2016-06-23) 7 commits
>   (merged to 'next' on 2016-06-28 at 354989c)
>  + color: support strike-through attribute
>  + color: support "italic" attribute
>  + color: allow "no-" for negating attributes
>  + color: refactor parse_attr
>  + add skip_prefix_mem helper
>  + doc: refactor description of color format
>  + color: fix max-size comment
> 
>  The output coloring scheme learned two new attributes, italic and
>  strike, in addition to existing bold, reverse, etc.
> 
>  Will merge to 'master'.

Please note that those "colors" do not work on Windows, at least as far as
I know, I only skimmed the code in set_attr():

	https://github.com/git/git/blob/v2.9.0/compat/winansi.c#L175-L314

... and it looks as if italic is plainly unsupported, and strike-through
is not handled.

Ciao,
Dscho
