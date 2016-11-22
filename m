Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E49841FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 16:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755867AbcKVQOP (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 11:14:15 -0500
Received: from mout.gmx.net ([212.227.17.21]:55162 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756044AbcKVQOL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 11:14:11 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXqV1-1cDFmA1C5P-00WpX3; Tue, 22
 Nov 2016 17:14:01 +0100
Date:   Tue, 22 Nov 2016 17:13:59 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: Re: [PATCH 2/3] stripspace: respect repository config
In-Reply-To: <CACsJy8D5oBR+vo2B+Ro2Q4SX0CG3jME4Gfs1_6AohccmpNvD0A@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1611221712480.3746@virtualbox>
References: <cover.1479737858.git.johannes.schindelin@gmx.de> <5567548295222401fab10d3f2901c1787afbfd07.1479737858.git.johannes.schindelin@gmx.de> <CACsJy8D5oBR+vo2B+Ro2Q4SX0CG3jME4Gfs1_6AohccmpNvD0A@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:PAHab+geGpZs+bqx1uyo+U19NSs4LRz0sijfF6IqhQyinSqvVCD
 +9Lw42vx+xpUHN/e2e7ITkSFVIJ+1d+OIyAafiIDCRVt2b6q7gTiBAK0yEsah964iX5ZW/k
 ZZL43wXlz184gtKVoW0kTHbLeSraY5UW2msBUixQHp/mE3Mr+hP3myHaaJLYEnLhrcoa7mo
 wZ1TNGkPtm01q7ThejXYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ktiBvayI4jw=:/9j8m3kn/LWaI3UyG6ztgE
 y9mp3EEhqy5eSBLRu/wvcc3QfdUwTZ4qKdzO5lD2cibyBdhuQHdO/tLrbU2TI+ddn4rwBDXto
 FpnzY9tNEh7r2g+ODvj3vHPt5xblOGs1O4U+VXG/s7TrQUYNzcddMg2y/RzrQoifts9TJ/YHC
 f7KG5ctcAhPfuvUUW5bJocZXQaEDd3ksL1+cdID2eHug8J5rh1rGP2cOMfSfhnz3gANre5a+Y
 Sm99HxHdWdH8FKhG+5256JVW7YLoWuR/+rzwmarOHsIyAVIBM8Ax1Of1jCDz9ZI+ou8FI/vQc
 Zshf7jNp2JiShRPa/fC8FGTxSsFhMlcXY8+UnLk2CnrDRMwdA1ZAP3Nr7xAH2EYFzQNiG78g+
 lIE+0rycm5wYyLZvSOeMqHBbYjh+3n+UjNl5mnEGlw7cUNfx9+glmypj3hVRGRrhEQoiNNmnp
 7Y3Qg/nOyZLlLbKelmLsRzohQIFhn4C0eMzRVGba8WWhvq9gF7O693GmD9Qs1SkgQ1NQq0J+I
 l5xj5ibpP+k5EobIy5tI2PsVsRJUR6P/bmI0qogSbuMuoQnjP4G5JFekM2+tqH7nY1KmjTPdz
 sHMEtRJ7NyufTnwRtKtNyrA71yaz8WOefpcpx2OIPQNPpMTHwbGBVWKtEdcbAgdfMSZygzFp5
 61r1zdlplWv3/BLR+INCAuabSvR3gjvvpgn35e057lND7gVNBpuWoZloCxKKeBb91WvGg9d87
 WOck1kt3v98/KmTO0nMvmU2BLWAM8KmRI5ZKtC0/NTkjLgmV0OzlPVL9F+p4BFwBvq6HG2ybt
 GgJ3UmG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Tue, 22 Nov 2016, Duy Nguyen wrote:

> On Mon, Nov 21, 2016 at 9:18 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > When eff80a9 (Allow custom "comment char", 2013-01-16) taught the
> > `stripspace` command to respect the config setting `core.commentChar`,
> > it forgot that this variable may be defined in .git/config.
> >
> > So when rebasing interactively with a commentChar defined in the current
> > repository's config, the help text at the bottom of the edit script
> > potentially used an incorrect comment character. This was not only
> > funny-looking, but also resulted in tons of warnings like this one:
> >
> >         Warning: the command isn't recognized in the following line
> >          - #
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/stripspace.c  | 4 +++-
> >  t/t0030-stripspace.sh | 2 +-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin/stripspace.c b/builtin/stripspace.c
> > index 15e716e..1e62a00 100644
> > --- a/builtin/stripspace.c
> > +++ b/builtin/stripspace.c
> > @@ -44,8 +44,10 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
> >         if (argc)
> >                 usage_with_options(stripspace_usage, options);
> >
> > -       if (mode == STRIP_COMMENTS || mode == COMMENT_LINES)
> > +       if (mode == STRIP_COMMENTS || mode == COMMENT_LINES) {
> > +               setup_git_directory_gently(NULL);
> >                 git_config(git_default_config, NULL);
> > +       }
> 
> This conditional config file reading is a trap for similar bugs to
> happen again. Is there any reason we should not just mark the command
> RUN_SETUP_GENTLY in git.c and call git_config() here unconditionally?

As I plan to slip these patches into Git for Windows v2.11.0, i.e. making
this a last-minute hot fix, I want to err on the side of caution. So I'd
rather keep this conditional (it might regress on the performance front,
or something).

Ciao,
Dscho
