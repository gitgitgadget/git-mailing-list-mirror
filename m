Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 638151FC19
	for <e@80x24.org>; Sat, 25 Mar 2017 00:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935275AbdCYACG (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 20:02:06 -0400
Received: from mout.gmx.net ([212.227.17.21]:61471 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933519AbdCYACE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 20:02:04 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M81vR-1bw0Y809yb-00vhOY; Sat, 25
 Mar 2017 01:01:57 +0100
Date:   Sat, 25 Mar 2017 01:01:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2 2/3] sequencer: make commit options more extensible
In-Reply-To: <xmqq7f3fa3oz.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703250100340.3767@virtualbox>
References: <cover.1490194846.git.johannes.schindelin@gmx.de>        <cover.1490285210.git.johannes.schindelin@gmx.de>        <75e2c4fe839602af19811ed3e251eb583ff6c8ad.1490285210.git.johannes.schindelin@gmx.de>
 <xmqq7f3fa3oz.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iu+x9B4vy2UTcpWAdECb/UV9Rht1U7lVX7397yjdWNoydJQeVsg
 /5Tn5GZMuu8CGp9Yr9uEYSpXo3udpOaMsrcuCeNRjL48UiYbFmGbI6c5FVClQegu4vU9z7l
 mhcP1+0mP+AeCBTT8+FrWcXom0oeiGg7zV5VRYdnmtcW71GlYN7EpqOhlNQF1dku6mPSnm6
 89waD9IFpBNX79bD6tZEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wkYQOr1MYcA=:vw7Om1XEn0W9dqb3Adq7Jx
 ZqiLEYdFpTCDKn0iyohMdJlyB40d8dKVoAHlu5VWGFgZd2WZmQJMZODk5DzZvkTxT85KOo8W/
 404YsPM8LehiZQcVBFh9kdT1UW2h6yBB1IfPNq1alYJy/C6Q4ayHdrCnWdCLWrAnMTqRVQKeM
 CKaoYWtQsH61R8G0wyEls+lDzH6Fpkuc7dumRK5sr3HTRuSQh5B0Zndik4EVU9yDKt7FU6xVY
 a6ewPEzhB5JmHmEVzPNIgfFc9UejeFU6BcK7FmVynFtf0zELJxQIBQLRaCJ5sBeLAddXjBc0C
 qhE2YhpbyPcd25cSGyQSjMnH5QZE0m59r/zxM290UAV/l/mhBgAeFOVgRDA+knT/yyk8pE9nO
 n5B754B+7FMqcMwiLNZa8fd++fecolYI/kg8cIXxu3rK9qNHY/dgSiRCMKIfCy5nbIPIoOuSU
 eL52DapHI1UdErtZg8MWriF43w/eo/4ZQk0e/sp0sBvQl2XqvUdHv/i25VHeG+if4EE0N5AuD
 xictDrJlLyeNAVJfLPqTZOASR5/k3UxihWpbj8fF+/E0nrdVF924Eji8e1BUjXe33juBqIwIC
 1jKZKi5poxZo144TYqkZ8fbfJoHyJdZAsAV3PYc5hAipo8DYScT07XeaerihBDVAABe2mcZiI
 sprX30TemyCHF7Jkg1eQESCFLNeE+Y/B1CIAAg/AtHwtFzNdV4xNoV9EKf+nJ49DFa/OBnGos
 XcPm+OV2fS2XpVHlYaK3y+nzJqc/a0zPUGuIFSflrggJMeoaLg165s7/CU6qifYvWBmYCs5El
 aC1waKdoi7B8DZO4khlBKE+OzEPBA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 23 Mar 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > @@ -926,14 +930,14 @@ static void record_in_rewritten(struct object_id *oid,
> >  static int do_pick_commit(enum todo_command command, struct commit *commit,
> >  		struct replay_opts *opts, int final_fixup)
> >  {
> > -	int edit = opts->edit, cleanup_commit_message = 0;
> > -	const char *msg_file = edit ? NULL : git_path_merge_msg();
> > +	unsigned int flags = opts->edit ? EDIT_MSG : 0, allow = 0;
> > +	const char *msg_file = opts->edit ? NULL : git_path_merge_msg();
> >  	unsigned char head[20];
> >  	struct commit *base, *next, *parent;
> >  	const char *base_label, *next_label;
> >  	struct commit_message msg = { NULL, NULL, NULL, NULL };
> >  	struct strbuf msgbuf = STRBUF_INIT;
> > -	int res, unborn = 0, amend = 0, allow = 0;
> > +	int res, unborn = 0;
> > ... 
> > @@ -1123,11 +1127,11 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
> >  	if (allow < 0) {
> >  		res = allow;
> >  		goto leave;
> > -	}
> > +	} else if (allow)
> > +		flags |= ALLOW_EMPTY;
> 
> Making "flags" unsigned was a correct change, but this is now wrong,
> as "allow" is made unsigned by accident.

Right. Bummer.

> Perhaps something like this needs to be squashed in?
> 
>  sequencer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index bc2fe48e65..6c423566e6 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -932,14 +932,14 @@ static void record_in_rewritten(struct object_id *oid,
>  static int do_pick_commit(enum todo_command command, struct commit *commit,
>  		struct replay_opts *opts, int final_fixup)
>  {
> -	unsigned int flags = opts->edit ? EDIT_MSG : 0, allow = 0;
> +	unsigned int flags = opts->edit ? EDIT_MSG : 0;
>  	const char *msg_file = opts->edit ? NULL : git_path_merge_msg();
>  	unsigned char head[20];
>  	struct commit *base, *next, *parent;
>  	const char *base_label, *next_label;
>  	struct commit_message msg = { NULL, NULL, NULL, NULL };
>  	struct strbuf msgbuf = STRBUF_INIT;
> -	int res, unborn = 0;
> +	int allow, res, unborn = 0;

I had originally moved it from there, to stay with the related flags, but
I should just have left it there.

Your patch looks good, you could do even better by reverting that move
(IIRC it was at the end of the line, and it was set to 0 by default).

Ciao,
Dscho
