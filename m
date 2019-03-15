Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0440D20248
	for <e@80x24.org>; Fri, 15 Mar 2019 13:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfCONUh (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 09:20:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:57043 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbfCONUh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 09:20:37 -0400
Received: from [192.168.0.129] ([37.201.192.41]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mc9U3-1hMisv3UON-00JZIu; Fri, 15
 Mar 2019 14:20:26 +0100
Date:   Fri, 15 Mar 2019 14:20:10 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] difftool: allow running outside Git worktrees
 with --no-index
In-Reply-To: <20190315031718.GC28943@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903151413570.41@tvgsbejvaqbjf.bet>
References: <pull.163.git.gitgitgadget@gmail.com> <pull.163.v2.git.gitgitgadget@gmail.com> <8cca9f800c2ce269a2ae644e4c15dc4115d3b0e2.1552562701.git.gitgitgadget@gmail.com> <20190315031718.GC28943@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-810040971-1552656026=:41"
X-Provags-ID: V03:K1:6nEKHorIw/uJ0ctbRpFYejkhq1KMYJ4+EEAxN3v45K6kNiB0HIR
 U2oqHGYYhwfd1amzonYmZkKtNb7LEqrF0+jUrkv6zZknjAN09zNuhC1MAbfsTC+7/FPlPAz
 5jkXIGuuyhVHpePiuWq98r2lKtLiQD65x8Aj2nxYPEFL7lwmurbK8XMbx/5vuWmT9N3Dam7
 9vjTvL3979qWD9KZ9nHZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6By+Xhhi1xk=:BD5XaseW89L+V8I/KLmgxo
 AD/eawVZoFcrCHMQTQhWWMusHBNEJbPUnUM8w3PvxsKzp2YVy8QkxXzsDWwdrkPFQEerEYzlQ
 ryFwBGeEZ2OWFf6zDjtv/wLwUnHPrKIjxZ/xd72hhfQbZf9F9dWEItaB4lw49NG+a3BqRj4mx
 9tpj2D8m43VrbagQSHOBlGuSp8ZMIgdNiAzyFSq1cYDcWFzdAbZ01SqrL0hL2eIDOBntO7qxc
 MQGZOylcIAm9S5JNqEnyAmgrNFObsF+gKTInoUFQENtCsmoChEqiLvVst2D8WmFFzHcgUVeCP
 6SuLaV3h1FSe5jEI+o1/5DJOcxtl1XkbWSHS64u2WidoqXZ8tUTrpBvxbp6UKngwWh7nWd8Ef
 7ttJmIRPNF/sGDzvoHJMtCakz4WFVWfG9Cv5BZ+UtlSz+86uyh+dp2aZW0ADcXy4LDRhRMr+O
 f6C7re7F1JvmXGAzlCtViX92oXhDQROzgP/NS0oMU24Nw560z3gkNSeKSAWyTSqxM9krUzVQK
 7qRKF9Lex0bj/SbD8TqkNRBGGx4fzZ/2ZX6hBhXpjVTzph53wzFMSWRvFhPxZ3qCRIefXktlJ
 u8QWWoyaT3x/BXxw6PaXVN/qbS1e/Rrh77f6jHqt+sN1OdUBjjE5yBYT3vGBh7fSJngOZe50e
 B0IBiey71Ji3iui7oT9JYUhqtlLvfB94blatl+cwEhP1dfbU3+tLTOlRXJhLi+iGnoi/Raq57
 czGSBewV1eYbeyJDnna6BddwnoQ0z17D7s70y5AF/QK9V0jc/w5dBoaIe3MZSCYrqFP/3aeSq
 wd4DtmMu0KEiDEIMP4ABANB5EVIfmp1ozDjEsQl+HIgFH5raYDqVcNs9NNIQxutSgpGFpm6oN
 ZHukroCys5zNs+/XVBJOu084XCYq+8RzEuxQkFVDGMp4dhvLNtSlyWn82DgNrEbZw5GrOnJdp
 QPDgWZszAZsheUpXaGZwV7CV+HQICT+Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-810040971-1552656026=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Peff,

On Thu, 14 Mar 2019, Jeff King wrote:

> On Thu, Mar 14, 2019 at 04:25:04AM -0700, Johannes Schindelin via GitGitGadget wrote:
> 
> > @@ -714,6 +714,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
> >  			    "tool returns a non - zero exit code")),
> >  		OPT_STRING('x', "extcmd", &extcmd, N_("command"),
> >  			   N_("specify a custom command for viewing diffs")),
> > +		OPT_ARGUMENT("no-index", &no_index, N_("passed to `diff`")),
> >  		OPT_END()
> >  	};
> 
> Much nicer.
> 
> > +test_expect_success 'outside worktree' '
> > +	echo 1 >1 &&
> > +	echo 2 >2 &&
> > +	test_expect_code 1 nongit git \
> > +		-c diff.tool=echo -c difftool.echo.cmd="echo \$LOCAL \$REMOTE" \
> > +		difftool --no-prompt --no-index ../1 ../2 >actual &&
> > +	echo "../1 ../2" >expect &&
> > +	test_cmp expect actual
> > +'
> 
> And this fixed all of my nits from the previous version. The whole
> series looks good to me.

Thanks! (စ ͜ စ)
Dscho
--8323328-810040971-1552656026=:41--
