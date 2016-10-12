Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B4F020989
	for <e@80x24.org>; Wed, 12 Oct 2016 12:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754228AbcJLMBl (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 08:01:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:63837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754381AbcJLMBc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 08:01:32 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LkSOt-1bIlbB3zFD-00cQBu; Wed, 12 Oct 2016 14:00:23
 +0200
Date:   Wed, 12 Oct 2016 14:00:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 13/25] sequencer: prepare for rebase -i's commit
 functionality
In-Reply-To: <xmqqwphe8zl2.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610121356510.3492@virtualbox>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de> <9b2782e64f678ab2d261042b63fafc3e4a519295.1476120229.git.johannes.schindelin@gmx.de> <xmqqwphe8zl2.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eeTa2cRBXHyznep4K7ucHTXN8v15uBA1qxzlL0S0qWoxQHErfwg
 ZQg06H+7ARHgzg1FQKizOoAsfvl7Niokxu24tgP5Gg4k1fp3VDG5siay9hnUkf5weZXu1dh
 C+Gf51rz6Now4vO0tIDP7n5M9w7zQoa9ZAyvEL8SSh9lpEGvkU/nTNdDoCom7bX2il+qAGp
 9GyzUVhJGfY4JwsAM3mmA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jADkK+anWO4=:jWPKz464WOzwVuuCoP4fA8
 XrcpoC8GS/Hrrl1tUKfQSBbypJqx5F5a13hv/RhJoWQKgSSsWVYjDR0FfIl3lPCO0HM0yvUCM
 kbfjSb9fk/oKDyvPg6AhL1didjZcM6SQxqR9+5GTHkWzHuPGEITMc98RefxEqGGzKTVXfwuy7
 DnA2PZyfcNaIox7l/h+Cyp2jRQjNhr84CrDPXrFqyDHo8QN45k00PxO7Bm5FCYcmGpFUu1CK9
 zdjL94ByTWHUsgdab39ItSm21HQU5qxD5xGDbQFhyRkpNvsB/4AQa/zkegM33xr2l9yKAOWvs
 udv5K/7H2Sm0j4M4uDqhA/t4OBG2HuOBSnOfIxihGXZO08ArtgfsMmT+Famhy/gW2M1aryZ85
 ouZGFI27ak5JLuL3CkTGwj25YySh9txWlJIIp5soqOPzEUF5ydWfWn5Y9EGLphIR5l5yKWke3
 FGe//7oaE9FkWPiFFIRxsbdaVKIbBGkziAuwvEmUeRbvxAsS8EVzs81qGON7oaFJJ/4pIbR6e
 CA4RRa9fwturRa3m7a+NEGs2J0wWki/B0fBE9mcsj3r9fS9xLfGNBYvpPke/ou1Xv1wWJ8SMI
 PIUG2ag5qezK2pOrhdeVvv4fmb/zODZfvV1Uq9mHks6zFkFifcDiPZtyD5zQEBrO9eAtsoQPv
 tn3yp7DakYyfP4jbEiF9cnlo8g0LdnQNtxXbqGORNo+FF22/3XrZEZEZ58WChsEhDm12pbQ/k
 DRkbOs8U7zkEwUy488iLDD6npHBxg2wWfHCYUWClGzmTvlp060RFwwPg8spBinKA8hFC/xbnc
 HlnexJg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 11 Oct 2016, Junio C Hamano wrote:

> > @@ -370,19 +383,79 @@ static int is_index_unchanged(void)
> >  }
> >  
> >  /*
> > + * Read the author-script file into an environment block, ready for use in
> > + * run_command(), that can be free()d afterwards.
> > + */
> > +static char **read_author_script(void)
> > +{
> > +	struct strbuf script = STRBUF_INIT;
> > +	int i, count = 0;
> > +	char *p, *p2, **env;
> > +	size_t env_size;
> > +
> > +	if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
> > +		return NULL;
> > +
> > +	for (p = script.buf; *p; p++)
> > +		if (skip_prefix(p, "'\\\\''", (const char **)&p2))
> > +			strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
> > +		else if (*p == '\'')
> > +			strbuf_splice(&script, p-- - script.buf, 1, "", 0);
> > +		else if (*p == '\n') {
> > +			*p = '\0';
> > +			count++;
> > +		}
> 
> Hmph, didn't we recently add parse_key_value_squoted() to build
> read_author_script() in builtin/am.c on top of it, so that this
> piece of code can also take advantage of and share the parser?

I already pointed out that the author-script file may *not* be quoted.
sq_dequote() would return NULL and parse_key_value_squoted() would *fail*.

To complicate things further, the sequencer does not even need to access
the values at all. It needs to pass them to run_command() as an
environment block, which means that we would have to reconstruct the lines
after parse_key_value_squoted() painstakingly untangled the key names from
the values.

In short, this is another instance where using a function just because it
exists and is nominally related would make the resulting patch *more*
complicated than it currently is.

> > +/*
> 
> Offtopic: this line and the beginning of the new comment block that
> begins with "Read the author-script" above show a suboptimal marking
> of what is added and what is left.  I wonder "diff-indent-heuristic"
> topic by Michael can help to make it look better.

Maybe. I'll try to look into that once the more serious questions about
this patch series have been addressed.

Ciao,
Dscho
