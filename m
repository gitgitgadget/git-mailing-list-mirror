Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DC38211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 10:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeK2VSg (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 16:18:36 -0500
Received: from mout.gmx.net ([212.227.15.19]:51195 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbeK2VSg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 16:18:36 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LjZhg-1fqlaM0tRY-00baT0; Thu, 29
 Nov 2018 11:13:38 +0100
Date:   Thu, 29 Nov 2018 11:13:39 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
Subject: Re: in 2.19.2 t0061-run-command FAILs if . is in $PATH
In-Reply-To: <xmqqpnuor6qs.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811291112460.41@tvgsbejvaqbjf.bet>
References: <20181128100517.28d44804@pc09.procura.nl>        <nycvar.QRO.7.76.6.1811281041400.41@tvgsbejvaqbjf.bet> <xmqqpnuor6qs.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VX3afk4i5OnrnK0zvUSbKgWer2ayKCf+YQjWUpUhEJSFVAwx0wN
 wemxHD4zFeKr4gO3/paqYY9Y1LNjFErBcfOUXTMOHCZgkor6K016+dZep4lewqR0o4Pogy0
 MmZrHO3I2K5xc0JOucx4EA+bcRI0pJFLRCDs78ZK/9y0R9hB4zdH4BthYbm8K8Vw9ZjRTF0
 AYkfYEdeAd7AeSWDF1HBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BVeON4P/9Jc=:yw0OYjq8oFCQkh3ngAOBa4
 CZiqg+o5/BXktVwYMkRV83lh1+70ujxgSHQxwrBbq9CaVjiQcR1oDbd81HVVZPC0uvN7nmR7R
 mVoOHdGhXwLjVcNGaIeBOVR9lmMgQScI0SXjb7owRgJJhaBstWREKnNX74LC/gRrDnju4asj1
 J6HUxSQjJEx7kL0p1VSJ3pirteD+Np9m835aNcka1enWGwfQh4h9gcQxb9tPjMxQDoSEvmGWh
 krVyyYbpGyyFgVorcvBdt//d119T9/nTdehbx7Rv0RZcvMYdYx6RxTN3cA8uvKWbNFYTJL2uY
 xp6/LT1/sGVsQcqKADMPJlt4jsUruiOxPD9yx7cUgYebPRU5yyNKFDWI0Qj4KBTYT4YolNFzu
 BEbobwNy0vUkfxeNjbcAWirV+Cpue4sB+ZnAaCjF4HrxkPo2HkZ4W7qjeUn8kuFMfX1q5Og7K
 hGna+4AzNWEmIxgtgPULnrDmVHZepZnk4kI0AuQztVwc/Ld4ILkq8GM66q8aWhm41wIDgNDGt
 x8dswE26f30DiBUSqtxVyVLrUjM660LbN9t+ITwWxghnmYF5TwsRAMSWqTMDEuogPhKKr+FUV
 t6kUDpFylnxgn9AlL15sLW849V2J6qAc9GmohqX8scv7QieXLRmxDz9BglIE5BEHBs+RhmXdS
 RPOJNfq2xveSwirT97JVF0V3nKXEKecilvw7to1YQPy8bPq4KVuDQfmlrg232mHuIjxc8W0Gc
 X2biqdvghGn0Y+YjnxQA3Rpr+APL2OCYPzDijQfCbpeIf61pkSb/Ibtk06Hx9EVUs5g10nvsM
 egqvT3YJdeuPzSd6jBZTG3YQpm1HECLZ01mpx4VXEUDZLlP8gZZR858ncG/u46aG4TGzgJxZY
 NJU2LxDg91Brwp0a6/hd5Tq6fGSMeyy8miQU1I6Wj5S7vUhocBU3MJfrTy+hEZbRAdFrLQxtc
 6fP1dzSppIg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Merijn and Junio,

On Thu, 29 Nov 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > -test_expect_success 'run_command is restricted to PATH' '
> > +test_lazy_prereq DOT_IN_PATH '
> > +	case ":$PATH:" in
> > +	*:.:*) true;;
> > +	*) false;;
> > +	esac
> > +'
> 
> An empty element in the colon-separated list also serves as an
> instruction to pick up executable from $cwd, so
> 
> 	case ":$PATH:" in
> 	*:.:** | *::*) true ;;
> 	*) false ;;
> 	esac
> 
> perhaps.

Good point.

Merijn, please be sure to squash this fix in before you submit the final
thing.

Thanks,
Johannes

> 
> > +test_expect_success !DOT_IN_PATH 'run_command is restricted to PATH' '
> >  	write_script should-not-run <<-\EOF &&
> >  	echo yikes
> >  	EOF
> > -- snap --
> >
> > If so, can you please provide a commit message for it (you can add my
> > Signed-off-by: line and your Tested-by: line).
> >
> > Thanks,
> > Johannes
> 
