Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E881720954
	for <e@80x24.org>; Mon,  4 Dec 2017 16:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754268AbdLDQKB (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 11:10:01 -0500
Received: from mout.gmx.net ([212.227.15.19]:60025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754117AbdLDQHB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 11:07:01 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MRWzQ-1eWnO12vyC-00SfdM; Mon, 04
 Dec 2017 17:06:53 +0100
Date:   Mon, 4 Dec 2017 17:06:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v2 6/9] rebase -i: update functions to use a flags
 parameter
In-Reply-To: <alpine.DEB.2.21.1.1712041643250.98586@virtualbox>
Message-ID: <alpine.DEB.2.21.1.1712041706120.98586@virtualbox>
References: <20171127045514.25647-1-liambeguin@gmail.com> <20171203221721.16462-1-liambeguin@gmail.com> <20171203221721.16462-7-liambeguin@gmail.com> <alpine.DEB.2.21.1.1712041643250.98586@virtualbox>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WopfiIeCWhGIjDWSOWSFzEkpvSDlo8bbm0pA4jMp/4HV9oLMdl6
 DQm9JiXYLK1Y2w/yNQsSLgzg8/ZOmcRAqnfov/O+Tb+SXI6fgT6ylPkfblDymiK4nr9efsb
 ClPPOo2VBGsPZZakYVRysbZX/Y+kSYkBNvGkqxKvyAnssWItnRzvlAd7beLTLtlxXIxXUPR
 6mcvZstNYmkIEsuOd0J9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KijGminsUZw=:dd2CZn+j+B1Fb+TeGMD0jS
 XEj8h5cbYwX09CC+z8QcQICNx4bOYwBJu+2cQqs4JxwSqLoXmG9x3NkxZk1JRhRlDl7yuqNXm
 PkvWpTiUJwcYTmlIF7w2wBoAi1FaBLxd48WYueR06OpfTIzEhKXh3SgSBrC6TC9RLewyeLnfI
 BCJAkvicIeG0v+FxF1eDWXJhO+2s2X07lW476UUSd0BJYDP3XYQCGkhmZlBDEdBf9/0v8EhK0
 zUQcViAs/ojwalXcMyQAegNlhX7HoD+gunxABvdB/JwozxuoVKUej9HjInAWZoyeeS3D4lDmg
 c12rX6pUBdrk0o1RpbzGHaukrl3V0GJ6RVWyf9Wiba9ZNovli4Fz+c/m4RVJNR3UwhIAWdi0a
 zGS/yn6uTSXzbASVcgZHb4yDgTNvoGHRfzk2l9TTcNqwZexpdX9S88v1nhWVUy+aPlM2Pxohr
 O523a12kOWD+gClEmbudZJPu9/dzsasxlIm9YBNsZua5c9cpzXXMbu0X7iwgBzmdwFUrJuM0E
 GEjBUejpPJYzjQL9gYaR4OVOsNgHoP3RtctF5FEO4FinLIDDyF/EI+9yvp22TELMHaf7nQtiq
 7XWdtrfOa/ydqeoftpM87KK4hgyGOl5YEw9yZPZG+CmkE+J7RdXb+dXE8nOpt7xflhpMsNrGb
 HdI9LCfo4KfIx7aj7/dwTIcaiC3XwYibhj7AUuJibXj/0ue/2cHK520ki9iFWzkmeDih/nR+f
 QKVk8I4OI4My6BiorP0g+ffwA7K4MmDm5zpnD8qsCvg14wfgrGQ81q7A8llefDZLfnk8mnh+H
 Uyb5M//lTTOpNfH2fhoxPZgXGHSGXpv14hZ83fvKiai36smYRU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

On Mon, 4 Dec 2017, Johannes Schindelin wrote:

> On Sun, 3 Dec 2017, Liam Beguin wrote:
> 
> > diff --git a/sequencer.h b/sequencer.h
> > index 4e444e3bf1c4..3bb6b0658192 100644
> > --- a/sequencer.h
> > +++ b/sequencer.h
> > @@ -45,10 +45,12 @@ int sequencer_continue(struct replay_opts *opts);
> >  int sequencer_rollback(struct replay_opts *opts);
> >  int sequencer_remove_state(struct replay_opts *opts);
> >  
> > -int sequencer_make_script(int keep_empty, FILE *out,
> > -		int argc, const char **argv);
> > +#define TODO_LIST_KEEP_EMPTY (1U << 0)
> > +#define TODO_LIST_SHORTED_IDS (1U << 1)
> 
> Maybe SHORTEN_IDs? And either revert back to transform_todo_ids() or use
> SHORTEN_INSNS...
> 
> Maybe also TRANSFORM_TODO_LIST_* and maybe move the #define's above the
> transform_todo_ids() function, i.e. one line further down?
> 
> > +int sequencer_make_script(FILE *out, int argc, const char **argv,
> > +			  unsigned flags);

Ah, I just realized that make_script() already takes `flags`. Sorry for
the noise,
Johannes
