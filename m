Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13E91F859
	for <e@80x24.org>; Sun, 28 Aug 2016 20:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756056AbcH1Uf2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 16:35:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:37137 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754218AbcH1Uf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2016 16:35:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 919DDABDE;
        Sun, 28 Aug 2016 20:35:25 +0000 (UTC)
Date:   Sun, 28 Aug 2016 22:35:24 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
X-X-Sender: jkosina@pobox.suse.cz
To:     Joe Perches <joe@perches.com>
cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        git <git@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <levinsasha928@gmail.com>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] checkkpatch (in)sanity ?
In-Reply-To: <1472413969.26978.108.camel@perches.com>
Message-ID: <alpine.LNX.2.00.1608282234290.22028@cbobk.fhfr.pm>
References: <1472330452.26978.23.camel@perches.com> <20160828005636.GB19088@sasha-lappy> <20160828075632.GA1852@p183.telecom.by> <alpine.DEB.2.10.1608281152080.3321@hadrien> <1472413969.26978.108.camel@perches.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 28 Aug 2016, Joe Perches wrote:

> Are there other existing tools for blame history viewing?

fugitive vim plugin has 'Gblame' command, which I personally find rather 
useful, and given the text-oriented nature could potentially be useful for 
your needs.

-- 
Jiri Kosina
SUSE Labs

