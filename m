Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12E5620248
	for <e@80x24.org>; Fri,  8 Mar 2019 18:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfCHSov (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 13:44:51 -0500
Received: from mout.gmx.net ([212.227.17.21]:43107 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfCHSov (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 13:44:51 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMTZa-1h9SYL2DnS-008NvZ; Fri, 08
 Mar 2019 19:44:39 +0100
Date:   Fri, 8 Mar 2019 19:44:22 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] line-log: suppress diff output with "-s"
In-Reply-To: <20190308162031.GA17326@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903081942340.41@tvgsbejvaqbjf.bet>
References: <20190307194514.GA29260@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1903081636350.41@tvgsbejvaqbjf.bet> <20190308162031.GA17326@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Z61hG+VHBf7UgwcqFSrv+y++xov+/ZCGM75oXr8iPCDxawqoNXy
 +Jpc6jQN9mZN1BFCsFfkI0c6+lCEmYapbcq5gFLahE/iFNU2o2Ayu0U1Q0rUmgLyj5gCu6B
 a+kxP3UrOmbnzeSsHZjx9LfcwAntJQyPw/BRCPOvZ/Q+iw7a+1sxC069A1i6MxndPbct+SX
 MC8Hv9hFKY476CC8hPqIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z2Ox25PoUfI=:RHtjo4+3FFaH29SyWDqHrR
 TpdpXNDcvv0v4PEoc0/LDzwG6dPObK4N1OUhLyP3lnqzZxhPlFOsrCq/G9mDKMnOsib+qDd62
 zP2mD2HH1EBsiC0Qm7P4f7CrW2esvqd7FXkMfMWuLuQ8HLLWRNxRlK6RQGITwVuUC098w5gS/
 dufUItJyyIVg+DagJDNR3Du1mAzFDj40QTJQdc0prd3sL8bvUWXJIFjGjddYe36Qv36jOSVL5
 sQ1CmmJak/6mWqxe+4Iic0Dfw+Yj5qSp6k9m7PmstiMQW6CYWU28eDvKHpS802GMjDbdKZEDn
 137CotPVg+CYdcbm3NoJ7Avh1n9IYuZJL2jlxyZSKsuEABP+cTFV2kU6Iha4zifB4a+BaZP9P
 BIfAzQzJYtRIrGMubLR38xcngKgRphnl5x/URSPL4eNPjdB8lhlXg49xFQvvchdUrbR+bMAtK
 sSnVG9dZLZ0ASgo1EOPDWMltCKcW3t25/byGqxXHiy4D2d1CgEtDXWyWYamrnqLB+1HNlM+0j
 cCI/kszGmruyrwYHbztLZHIhy+bOr2Xwqoi+ijYvqv9gx3syaXrXS/y8fDgLJ+uy2pvdRCIVI
 puDOqjhTO+4Ycu/GLEC7mucaHBM2iqq7ap8HVZ3ihwJVCkHYvRYRCUHTtMrGIEs2SnH/AXq7m
 43RrdWpKze6GX14uItvcug6ejBWmm/U6p6xLzFql0E73am3kB0flTolBq2yfUIXJdSzhHJO2p
 fLs6lzeAqQ7+Vv/okXfhKMs0mbQqK+AZrDkzsxjdZQg1eAX+3Zb9eibWcvECUdq3/6J7ZQCXO
 6XbzTCGghNR7sMMQ5NtT+/o/pw6nugbxSSjxI604OEsPo/HJn+UXJ2kvaCJ7U9d7tNnmLqXEh
 N286TvUw6kLsdACS8ffutVn3BcANNqs847B9Da7B4WO2xMxQdptoUIu1BarIoPuPveROD3B1h
 SKEkW5p52yw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 8 Mar 2019, Jeff King wrote:

> On Fri, Mar 08, 2019 at 04:38:44PM +0100, Johannes Schindelin wrote:
> 
> > On Thu, 7 Mar 2019, Jeff King wrote:
> > 
> > > When "-L" is in use, we ignore any diff output format that the user
> > > provides to us, and just always print a patch (with extra context lines
> > > covering the whole area of interest). It's not entirely clear what we
> > > should do with all formats (e.g., should "--stat" show just the diffstat
> > > of the touched lines, or the stat for the whole file?).
> > > 
> > > But "-s" is pretty clear: the user probably wants to see just the
> > > commits that touched those lines, without any diff at all. Let's at
> > > least make that work.
> > 
> > Agree. The patch looks obviously good.
> 
> Thanks. This leaves the other formats as silently ignored.

I'd be fine with that... but...

> Do we want to do something like this:
> 
> diff --git a/revision.c b/revision.c
> index eb8e51bc63..a1b4fe2aa6 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2689,6 +2689,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  	if (revs->first_parent_only && revs->bisect)
>  		die(_("--first-parent is incompatible with --bisect"));
>  
> +	if (revs->line_level_traverse &&
> +	    (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH|DIFF_FORMAT_NO_OUTPUT)))
> +		die(_("-L does not yet support diff formats besides -p and -s"));
> +
>  	if (revs->expand_tabs_in_log < 0)
>  		revs->expand_tabs_in_log = revs->expand_tabs_in_log_default;

Since you already have that patch, why not go wild and apply it, too? ;-)

I guess you copy-edited the code from somewhere because you usually do
leave spaces around the `|`... I don't care, though ;-)

Ciao,
Dscho
