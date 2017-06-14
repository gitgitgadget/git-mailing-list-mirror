Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F368D20401
	for <e@80x24.org>; Wed, 14 Jun 2017 10:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751726AbdFNKV4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 06:21:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:49790 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750756AbdFNKV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 06:21:56 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzYY2-1dqgtW2QRG-014hOM; Wed, 14
 Jun 2017 12:21:44 +0200
Date:   Wed, 14 Jun 2017 12:21:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v3 6/6] Use the early config machinery to expand
 aliases
In-Reply-To: <20170614060502.ljuvdxcbara3zfjx@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1706141221020.171564@virtualbox>
References: <cover.1497355444.git.johannes.schindelin@gmx.de> <822765b002488f03523bf440097492be3c14931a.1497355444.git.johannes.schindelin@gmx.de> <xmqqk24f97ud.fsf@gitster.mtv.corp.google.com> <20170614060502.ljuvdxcbara3zfjx@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:P7SpEnoOBU7SXyU8+pjeMRxYxVt7HV+VW/dNl8e++9ikw8iDWAt
 w3NX6yncGn4FL1/K4MOVzm+x2nte53GINf2v4Nbkev07vkoCQ/XHr144G1Z1DUnnsX5CtTc
 sFcGiGKwbDM8q9kcmgoo6VZVthe/26zcDSk1UFznBqyXFbxZ9g2/5TJP3DtdEhFAvZDckVs
 EEh3G1hefyULz3x7FXq6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rfx12+FJKTI=:LMy+iYQKCGSpSODU+XUzcK
 vryVvxZRMOJtN3mS4FZQxojxHEd4zvPHzmBA3BgVLN2igz0BwJSRqqMrVNITmaasu7XbI5jh8
 6/WhA/blKsg2bjnLNQGiXy3NNUU7wpF2u36PswVoUB3gI6kfZj+ZyL5Fb47K5+BR6Bw1c7A+0
 lCYYTsuHgWiRhK6fKhh0vUBWDUuJZKi55qE3Klgs3t2wX2cKvDVh9S13qBvtJf847gzBv5LGy
 1Z3g2MYxKQ9GHcAvnasyF3lo3JTffZNdVCFl6iHTseyy0qHLkOik1cOy4E3j6O2w/zDlygDD0
 ztHl0TbgdCjoG3XLkkhw63iPbDAhwupJZfuGXSc5IOZvlsxXJFp5Sffvz4cdVxCJWfwKSmYJ3
 Lu8ZdUkHgoZS/n38I4df3+yHJk1dzCza8hbcPIEcEhlt2QPPCrE0ib//u13Y5ko7qRshr/ge0
 fLzLdbmmbsFKr9/E6ynSQ9FEEGoGsp+hkKylAL+od0/o77gJTSwMo1ZN1Z6KTIpT7FK6oyQ+u
 8BlpD8VnqYXO0ercdeJ6icE2CEgZZFjTRNyhv5qA9Av47Nk6KFGIyhj057jqKldPH+Md4K7Pe
 HqPlyOOl4ZcayE044GeLCiTw2OQ20rhQC880NGu6h62SjELImuc9OWYPe7neNv1FJOSpaW4H3
 f59C0lw00xSRRCF7+6Qny7NWT9HnoYhbynkrLR81SC59xKJDliIs9r4TYdt//DjLqVC/tT5ft
 F7lNy6InUDbyEk5Znhq2ok6+x7RdFRy0s8SLqowS1g5BZiqrHcID44xQ0//d1tfa65o/tM2kw
 CBlXUPu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 14 Jun 2017, Jeff King wrote:

> On Tue, Jun 13, 2017 at 09:21:30AM -0700, Junio C Hamano wrote:
> 
> > >  alias.c          | 31 ++++++++++++++++++++++++-------
> > >  git.c            | 55 ++++---------------------------------------------------
> > >  t/t7006-pager.sh |  2 +-
> > >  3 files changed, 29 insertions(+), 59 deletions(-)
> > 
> > Happy to see the deletion of all the save/restore-env stuff.
> > 
> > Except for the puzzlement in one paragraph in the log, looks very
> > good.  Thanks for a pleasant reading.
> 
> The whole thing looks good to me, too, though we should decide what to
> do with the point that Brandon raised.
> 
> As far as the "streamline" puzzlement goes, I'm OK with either of:
> 
>   - taking your suggestion from the other thread and actually doing that
>     streamlining, which is one less thing to have to explain
> 
>   - leaving the code as-is and tweaking the commit message (though it
>     made sense to me)

I fixed the thing in the way you suggested (which worked after Junio hit
me with the cluebat about skip_prefix() and git_config_string()).

Ciao,
Dscho
