Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E5BA1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 12:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754748AbcHSMty (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 08:49:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:61502 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754070AbcHSMtr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 08:49:47 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MSutp-1biGGH281N-00RtQe; Fri, 19 Aug 2016 14:49:40
 +0200
Date:   Fri, 19 Aug 2016 14:49:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] cat-file: introduce the --filters option
In-Reply-To: <xmqqk2fe6njs.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608191446550.4924@virtualbox>
References: <cover.1471524357.git.johannes.schindelin@gmx.de> <f1e188907f31abef9e82bd6b0da120ab7d9bd4a7.1471524357.git.johannes.schindelin@gmx.de> <xmqqk2fe6njs.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:q8A8SyrWyoNoEOyt0t5R9PybGL41GuxnNyIZQX352rKMbzWeA0E
 LMc9obpXrc0tg8f/RuCpcy9/+48pIN/5imxA5K3ytU2NYUfZAZafW0ju7575EyYTPeMaIYK
 3Id/X6Rsih713dApJrZ9BB4TGv+Ga+uCvHn6R3WQYB73bfCgbuA5iIoXsZLFJmM1xAjOQro
 9aOd0DwJjqfsnEZnysZHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VBk/caSNFkg=:HehTYYMbnudC3uJ/BwZsuL
 0kexSnRKuVblGdufzd47HRnFsc49JrkAyviLVHx2uECjJBzcO6Idz+IBqY/4l3xB8QbNYnulZ
 mBRcOf224YQazy3jPXgEm1RXOi8QelpeGo8IDBTNtZ+szB0EviZEH3nbZ8AW+2geX/LWDN4LL
 +Xxw7//kegVYk45ENNWj55bXi7oCU42SM8ByerRKzw6oYi9n7ALej/xguMR/7gNuoEtrLylGw
 sP/JcaqJY/WQYEPRTGZIJCYRemaPzElQZk09blnnDt+UOMxHOwRE9CpQbne3QgLQ/O61lWh80
 +64//TYAc97pJt4Vu+fvGfjebjWuBxIp8YGbwjpOV+afd5GSjDKgpgunSxavJTXBILc5YxWK9
 mJJGbp36IXR+VZteaczm8sSpzAfKn96/yf/0U6eNfZeb+naf70rFE2jlmHP92KggROPD4tQDR
 OPypIyOcMqV56c+er1aeqRlDRbbfxiutaXDnbZX7cBLhwysPyzxr7eKKAPF64VA5QtkHq0CJq
 cbR95PZ7FO9DSh5GcinM/gfXgx7caCdUlIv1Aj7JbNmU/DK59thPMN6/ACO/cGPZQZrznw37s
 6xSFq869fkef8I9aZowGv2iCzKg+Hrnkeb7HUcX1eFIPcOX9YBzFwwkegGFR14RWlLBX8WxXx
 MGRnifFG5m/Lclil0D0/17DnA1M0d9RXbs7c4VLR7IDI5B+SLO2yefuwNMXTfzi9uu7BEdiFg
 nqiMsxzKkWZwltQgTlfwMFYW/g7tzBnyKOdSruwzkHP34j4p7w/3sjCXR7OdQ28UNRNV6secH
 ZBFSrbp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 18 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > As suggested by its name, the --filters option applies the filters
> > that are currently configured for the specified path.
> >
> > [...]
> 
> I think you can lose the last paragraph and enrich the first one
> instead.  The text as-given does not even say anything about the new
> option affecting only blobs.
> 
> 	The --filters option applies the convert_to_working_tree()
> 	filter for the path when showing the contents of a regular
> 	file blob object.
> 
> or something like that.

Done.

Thanks,
Dscho
