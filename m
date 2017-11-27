Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C33B520C11
	for <e@80x24.org>; Mon, 27 Nov 2017 21:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753199AbdK0Vl6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 16:41:58 -0500
Received: from mout.gmx.net ([212.227.17.21]:64068 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752976AbdK0Vl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 16:41:56 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYcJi-1eg6W50ELa-00VNxr; Mon, 27
 Nov 2017 22:41:51 +0100
Date:   Mon, 27 Nov 2017 22:41:37 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Liam Beguin <liambeguin@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH 3/5] rebase -i: add exec commands via the
 rebase--helper
In-Reply-To: <xmqq609we20v.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1711272230490.6482@virtualbox>
References: <20171127045514.25647-1-liambeguin@gmail.com> <20171127045514.25647-4-liambeguin@gmail.com> <xmqq609we20v.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:66cJaUuwnucy/WAZOStgOLQ+KFy2WXYBZWwlMsXffVEiOO3EQql
 N3cfHH6rRb+Ma7ergclCtee2CGOvewd1dHsI/w3C+YtHjV2FEwkVIw/TlJ23OkzYeM1UKoT
 UObyCpI96O+IDuyDajKGQkyDfQ9eC5CV3LFxZcye0e/zBRZAYrwzJ8+lg9Gcp3BlUqiwKJx
 YFnlI0/MsZiGG5g1DoeCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w2z+11FG03A=:5cpQE3PJQ8rs9oF3IdN5hI
 6ikl3ZYngyc9HLEMTbRvm9Oz/khIynfRMkUo70Ph3k2BQNZRp28uHzDnNl1GHhPwVzNsQDk+I
 xOkGuX91oBlnHjPR/nzZRie2syFsTihNU5iX9PnhEDtDBpY5d5686FloKIwgIwQbTuYxwE2dN
 z2Ljhr3FuYmIK+k0hrEQDZY0aLOPNF8xMYLMC01jQPkVRwamIaKJve36xn25Vh7GJqKjTfX88
 fGgHKjL3eEKnoqbN5FhHjPYSY+74K3sM/+kCitFOC+jiuEtX8jKrCiB4D7T4w1d8FQr0W+hrV
 UxJdi9Zzs8iuhoaCpjifcdhRtadDLriVwatkojzr72JQt5DXCm4KEOK5r9K5EZtgoI0kADZNr
 tOSIZ76PEbrAmuzkAxM+CRycUDIUErHiZvUckVlvupucIV4FrYwJLXjTaawIi4aumbDgEYt1L
 MaGdgGSQziry52gAv6HgDPn9ut+651N0VphFQX6bfWu31TKinSfoheynh+ZPOz1ynj9Z7sp0x
 Zk4iOiwArQH5Ai1s5is/XnDjse0PKNxM7QsE5tcLGTOMFLqeCX2MPJdtGijI6MVPHAo0cr1CT
 D2fXjJyhptrHl2cRa/Z4/KtW8v9xYTjOMHqxcHKzq82rYo3lRtl2wpSguyF/5GBkGo5wCqTLR
 sMlMg1XjmmGnzzf8LMwwliWXC7TAFg/arpeIs5djVdu/LtOGbIAUy6dQ4yCJIMtcs8SkcPoMW
 ydrHUBNlhFKQjyryksM39OdkOkaS0XhD54R63DPk/2DJ7BafVDnj43ma0J+3mgFCUeUL+GpPp
 gr/r/V0m1Bfwis5Zsgjw5EwCH3wTz1u96rNe5RjwUt/bfrSfNI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 27 Nov 2017, Junio C Hamano wrote:

> Liam Beguin <liambeguin@gmail.com> writes:
> 
> > diff --git a/sequencer.c b/sequencer.c
> > index fa94ed652d2c..810b7850748e 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -2492,6 +2492,52 @@ int sequencer_make_script(int keep_empty, FILE *out,
> >  	return 0;
> >  }
> >  
> > +int add_exec_commands(const char *command)
> > +{
> 
> As the name of a public function, it does not feel that this hints
> it strongly enough that it is from and a part of sequencer.c API.

How about a "yes, and" instead? As in:

To further improve this patch, let's use the name
sequencer_add_exec_commands() for this function because it is defined
globally now.

> > +	const char *todo_file = rebase_path_todo();
> > +	struct todo_list todo_list = TODO_LIST_INIT;
> > +	int fd, res, i, first = 1;
> > +	FILE *out;
> 
> Having had to scan backwards while trying to see what the loop that
> uses this variable is doing and if it gets affected by things that
> happened before we entered the loop, I'd rather not to see 'first'
> initialized here, left unused for quite some time until the loop is
> entered.  It would make it a lot easier to follow if it is declared
> and left uninitilized here, and set to 1 immediately before the
> for() loop that uses it.

Funny, I would have assumed it the other way round: since "first" always
has to be initialized with 1, I would have been surprised to see an
explicit assignment much later than it is declared.

> > +	strbuf_reset(&todo_list.buf);
> > +	fd = open(todo_file, O_RDONLY);
> > +	if (fd < 0)
> > +		return error_errno(_("could not open '%s'"), todo_file);
> > +	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
> > +		close(fd);
> > +		return error(_("could not read '%s'."), todo_file);
> > +	}
> > +	close(fd);
> 
> Is this strbuf_read_file() written in longhand?

Ah, this is one of the downsides of patch-based review. If it was reviewed
in context, you would have easily spotted that Liam was merely
copy-editing my code that is still around.

And indeed, I had missed that function when I started to write the
rebase--helper patches.

> > +	res = parse_insn_buffer(todo_list.buf.buf, &todo_list);
> > +	if (res) {
> > +		todo_list_release(&todo_list);
> > +		return error(_("unusable todo list: '%s'"), todo_file);
> > +	}
> > +
> > +	out = fopen(todo_file, "w");
> > +	if (!out) {
> > +		todo_list_release(&todo_list);
> > +		return error(_("unable to open '%s' for writing"), todo_file);
> > +	}
> > +	for (i = 0; i < todo_list.nr; i++) {
> > +		struct todo_item *item = todo_list.items + i;
> > +		int bol = item->offset_in_buf;
> > +		const char *p = todo_list.buf.buf + bol;
> > +		int eol = i + 1 < todo_list.nr ?
> > +			todo_list.items[i + 1].offset_in_buf :
> > +			todo_list.buf.len;
> 
> Should bol and eol be of type size_t instead?  The values that get
> assigned to them from other structures are.

While it won't matter in practice, this would be "more correct" to do,
yes.

Ciao,
Dscho
