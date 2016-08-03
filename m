Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEF481F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 16:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757896AbcHCQP7 (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:15:59 -0400
Received: from mout.gmx.net ([212.227.15.19]:52761 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754311AbcHCQP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:15:58 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MN1j6-1bbYP21dQu-006gvt; Wed, 03 Aug 2016 18:15:52
 +0200
Date:	Wed, 3 Aug 2016 18:15:50 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC/PATCH] rebase--interactive: Add "sign" command
In-Reply-To: <xmqqr3a5al7z.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608031813410.107993@virtualbox>
References: <20160803084743.3299-1-judge.packham@gmail.com> <alpine.DEB.2.20.1608031621590.107993@virtualbox> <xmqqr3a5al7z.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:u93OrT7l6Q3NtKA316+1zDzgVE2/nBsjtioywYAky2ZIyWuSzzB
 cRjHAjfCIeDy+GRimZn/okwlaAuQeNToy4LsPZxzFucM8+3bCTCOedx0f7EpqoyozmItngY
 bUrff8xJwyeJwFr0NYiCOWyCbcwMtc/1YHl/9pnYNnvAbsFMF4UpWJGg96QtzqHNB08e1VB
 hRWrMMChp3PCUs0Z/kuVg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:CWBVdTJI5nM=:4ebHxJDFr9p/tE5zo87MlN
 GJ56ZrHe44O3swZRg04ZN+Q0JnResmrDA2tDp90oVQaa5KCmjeH/i9og+RTR1eeRdXmRLHgl/
 Of5oP3tKBbhrW65vyFRTpvZlHaUJ2/w8NWxNfEsYkBpOLqF7FJkXyfoOgj1zJpzpUThKtEW7L
 Yu9JJDlMmlUdFdgX4cUTwlqnOgWEcFDDj9mIGw4e9sgjVY2WOLynniantwxTJjrflP5L76i3V
 /ZbkfPq1NOkr86vvzUtj3T95e4vJZvGNuvMe5LcSbjp8NZgm76qwS1c3hWmDuKqEZhQ2mhGGY
 5c8ac7CdfFIb1kIe9wwhyroHe7idesZwh/Vbi3xkxVPrTj7E4qZH6Hk/UagkvOlZsw8gjmgyJ
 gj4Yu78BjC9gtU4zLftTO0leZWkRl3dhupll//sTis48xmQ/MDXPJZ5BTCxf26TRZdWeNp66y
 nw6+6Vnu6HSvrg7wOI4UM55vTo/3lczR2+9JvSTKf7htw8+zjYyZr74KJHxyPpyS/WzmyIiGh
 PmtOn6QXDdR0GtsPNSOFGIXTErtG9UrIzYjgcb69yTwxZadhWZMkrKeok6w72NMCyQcvWawxN
 jIjMl2W1PmxMh8Jw+NRCELAnxf2GiQfZHS2B5X1Q14sL+9xqYDW+dQ7j4z4qJPJuUQVhR0WhW
 756bjEVwRdhAteQprnXGhFkPIasCmjDMiHQJz8yjFqv/y6BdaIFbZWx4CCBV2w2NTBHuvHq4Q
 LVCaw5mXKFeM+uRsoPvwkcSlPqaxzzVyaE+MW71mgMB5NR1fVzNgTlYAPexVJNx5HCnPDi4hL
 jTmAb4o
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 3 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > ... my Git garden shears [*1*] (essentially, what
> > git rebase --interactive --preserve-merges *should* have been).
> 
> Any plan to fold it into "git rebase -i" as a new (improved) mode of
> operation, by the way?

It was my plan to integrate it into the sequencer, once the rebase--helper
landed in `master`. Little did I know how long it would take to get this
done...

My loose idea was to deprecate --preserve-merges after introducing a
--recreate-branches, or some such. But enough of that. The rebase--helper
needs to get here first.

> > However, I could imagine that we actually want this to be more extensible.
> > After all, all you are doing is to introduce a new rebase -i command that
> > does nothing else than shelling out to a command.
> 
> Yup, I tend to agree.

Awesome!

Ciao,
Dscho
