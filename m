Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	CHARSET_FARAWAY_HEADER,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D9591FF40
	for <e@80x24.org>; Sat,  3 Dec 2016 16:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751311AbcLCQk5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Dec 2016 11:40:57 -0500
Received: from mout.web.de ([212.227.17.12]:53473 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751241AbcLCQk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2016 11:40:56 -0500
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MYvxn-1c8QAC1IsV-00Vk0Y; Sat, 03
 Dec 2016 17:40:51 +0100
Date:   Sat, 3 Dec 2016 16:40:49 +0000
From:   Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] update-unicode.sh: automatically download newer
 definition files
Message-ID: <20161203164049.GA31244@tb-raspi>
References: <1480762392-28731-3-git-send-email-dev+git@drbeat.li>
 <1480771173-731-1-git-send-email-dev+git@drbeat.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1480771173-731-1-git-send-email-dev+git@drbeat.li>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:YQRMrAa2MXOcfttY3sLPSdmMCafVlCXI5b2R2Dd6j+7jyc0vD6l
 3UpErkAxBBGIu+iMuMg46LZZVjqeyAHNuGacYPGUInI/57VNfG5S6YFtkwnpYkveJtgQCYV
 HZeoc3xLtAZ+lndOVyaankTDC8Gj8/L/bwAAWmEYybkn3EaDNzS9nRTPeOidEkPd9MdV/gq
 ny9YS4sGUoXIsXkVOhmGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X+FNv9k8nSE=:+jnS7IzHP9wczO5QyW+zvM
 622ykiEm3eNgDjBPeA8vDDxZQTIpFNHoHWvHG3KewrssZqRAB42PBJRt28nYC0CoQ7v+tgjA3
 qUYp8kd2mketXueYiI+WuH2J/PLxTy3nKydVlw35RHRTj8bdRElMVz/hdslH/Cz0HBWsMH75D
 2OXKPMtJCN7lzTIr3N3tDRuy54B/t+KLjwRzWyAkzl+KACoe39uxZrt6sIF1GnfatRb4yQ/Uu
 L/XgGTv875zJ/t0BAuM2bOUAwyJOT8d27jeuJVlCgID6JG6q509z97oPKn+w+fJhUBi+WbphI
 sMTugVrN23I63I6rfpdSDFjyV/eVJiGLNAUvBnpjqSVHCjpTBYrBR9cQPyVhI8LlTtZ+m9szt
 yPTZT5qczJwTZXBvth+6E560M3pKBCVKvZQZyfIvEwbAguaUpbwBuaApCztTeIgtor+Ijf4oZ
 ydKEplzXDGZYbnV+g+PmuXINaqlMrwY+rOjiJbLyNG5LRJ41RqUYhHXHZj8jicC5P2gB+4/5X
 Hq9/48172Cf/0m9d4f5EuOYygc7465S0Rqu1E8/FRi6CnwXh8WosMTFhNLYvhhUpjqHVFmkd2
 BvzaQj2oiuwMIam1T9Sa3m00LZOHNikhkaoaM3hKSS5RyZu22FGDSrQZj32yS5QOwVJlDynBH
 dSyXqC/R8SrHChdyoUU+tFO9wJZXHGcpMzJSccvPcAWmXrTG6z+BxqMoxTc5RM8itWsBItmNz
 goJE8dAtWttGz/vmO4vl/e9QyBaEKLFCOh0FextzHLbwsPC+rGSn2zSCIzo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 03, 2016 at 02:19:31PM +0100, Beat Bolli wrote:
> Checking just for the unicode data files' existence is not sufficient;
> we should also download them if a newer version exists on the Unicode
> consortium's servers. Option -N of wget does this nicely for us.
> 
> Cc: Torsten B??gershausen <tboegi@web.de>

The V3 series makes perfect sense, thanks for cleaning up my mess.
(And can we remove the Cc: line, or replace with it Reviewed-by ?)
