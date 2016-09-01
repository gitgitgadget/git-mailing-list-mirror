Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 909681F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 15:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755814AbcIAPTf (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 11:19:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:50113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755803AbcIAPTb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 11:19:31 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LsCAp-1axJQq3ywB-013tES; Thu, 01 Sep 2016 17:19:24
 +0200
Date:   Thu, 1 Sep 2016 17:19:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 32/34] sequencer (rebase -i): show the progress
In-Reply-To: <1472718812.4680.20.camel@kaarsemaker.net>
Message-ID: <alpine.DEB.2.20.1609011717370.129229@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>  <3207457a57d056c3054faf718128fb5c806cb032.1472633606.git.johannes.schindelin@gmx.de> <1472718812.4680.20.camel@kaarsemaker.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1730601202-1472743163=:129229"
X-Provags-ID: V03:K0:bTEPUAKTUnqcPIyC78ldnYOmbXQ596GMn3Ha/wyxCYZL2ocIDVw
 ZCZMDYYiu+qB+OUEYkPjZ1MVg0TpVsC9IdBcXr/aoLqh8Wl97QnHYSifG3OrgUu0KSRBwEn
 qHW1DPuLz0SrUCRg3grvxeTdPqYpJG+y9/qDNF6T42IdcAoCrLxKC5KUhjY2L1dvSZ2Vfsd
 EnJ4hSr9yXO2fqETJkthw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2lRpu0Qrj8U=:OWEMS82kXf7QxG9HiE7Mxn
 X06stgiii/V5RIL0ZdjyF9nRXooAUU+Tf+g/5VW/dhKVfb9GpGIJ7+EPzO0Zw/qUrC1KdsIsF
 aHsxyIEACZ1isUfe5y1u4nKC3JvxYREGh/cZ714lT2sZ9z7DoBfs1lovMrKiYL6rsQJVktlgB
 9jJvTZgi2JmYBDJeHWq2xZz5XsbpsI8UWTuNDAauA+P7U2yLgI8Z/C3NWzYG1Rq2f5Ye7owRf
 bwkEDYmAVZaBud3VLR0nr3fU6Z+TFE1nfimHIKdjX0PWZTRReOOwdBAA50jHAmihYrO8GmJgB
 zLzTCJS0+RcqXHVjU40B3GUEq2XqdDg5Zf5pHKK56XMDQf5mdeErqQo93cTeAia1th2i0rq8e
 JSTgqmBuv1p0O4p7PLFfYQZ4ATp0MOxkCbH4J6di8SFEEiPWyubdOvgvnwFbxJzUdyVeyqAxh
 6SD8kZQm0VjD4agZyPF6gE8jn0sACbdXkVBgPWTRJSepGWmLo2QIjCzGMsCxoHGx7XmKJ76nR
 KuZ3CXKulDzYt0r955hok2Zt6GHYLAfgDyt4A2pGl2qNXd3dvCrdyBjrpTDQtYEXC2f4034aZ
 3fl++OVSODAJkmMRho8NjSeuU0ZcRpg9DokxakdTvz2eK2U3ovepO5BVBYLoiQCDT4CMD6KLU
 9xjCpV4otm0APTg7GbpKKu6Ad1W0TEYDl5V5j0zx+zu8LBdHAspl4OQj6Pgq4Cah+4PUgRJ5w
 1PYtB6Tvpr1OU47OdB0d3qwbXOynxNub9PdO/HCBr6ukucQ4PUt1o/DcxyrXLgja5/CI3w2N/
 9brs2hd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1730601202-1472743163=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Dennis,

On Thu, 1 Sep 2016, Dennis Kaarsemaker wrote:

> On wo, 2016-08-31 at 10:56 +0200, Johannes Schindelin wrote:
> > The interactive rebase keeps the user informed about its progress.
> > If the sequencer wants to do the grunt work of the interactive
> > rebase, it also needs to show that progress.
> >=20
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > =C2=A0sequencer.c | 33 +++++++++++++++++++++++++++++++++
> > =C2=A01 file changed, 33 insertions(+)
> >=20
> > diff --git a/sequencer.c b/sequencer.c
> > index 89fd625..e8c6daf 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -1218,6 +1218,7 @@ struct todo_list {
> > =C2=A0=09struct strbuf buf;
> > =C2=A0=09struct todo_item *items;
> > =C2=A0=09int nr, alloc, current;
> > +=09int done_nr, total_nr;
> > =C2=A0};
> > =C2=A0
> > =C2=A0#define TODO_LIST_INIT { STRBUF_INIT }
> > @@ -1329,6 +1330,17 @@ static int parse_insn_buffer(char *buf, struct t=
odo_list *todo_list)
> > =C2=A0=09return res;
> > =C2=A0}
> > =C2=A0
> > +static int count_commands(struct todo_list *todo_list)
> > +{
> > +=09int count =3D 0, i;
> > +
> > +=09for (i =3D 0; i < todo_list->nr; i++)
> > +=09=09if (todo_list->items[i].command !=3D TODO_COMMENT)
> > +=09=09=09count++;
> > +
> > +=09return count;
> > +}
> > +
> > =C2=A0static int read_populate_todo(struct todo_list *todo_list,
> > =C2=A0=09=09=09struct replay_opts *opts)
> > =C2=A0{
> > @@ -1355,6 +1367,22 @@ static int read_populate_todo(struct todo_list *=
todo_list,
> > =C2=A0=09if (!todo_list->nr &&
> > =C2=A0=09=C2=A0=C2=A0=C2=A0=C2=A0(!is_rebase_i(opts) || !file_exists(re=
base_path_done())))
> > =C2=A0=09=09return error(_("No commits parsed."));
> > +
> > +=09if (is_rebase_i(opts)) {
> > +=09=09struct todo_list done =3D TODO_LIST_INIT;
> > +
> > +=09=09if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
> > +=09=09=09=09!parse_insn_buffer(done.buf.buf, &done))
> > +=09=09=09todo_list->done_nr =3D count_commands(&done);
> > +=09=09else
> > +=09=09=09todo_list->done_nr =3D 0;
> > +
> > +=09=09todo_list->total_nr =3D todo_list->done_nr
> > +=09=09=09+ count_commands(todo_list);
> > +
> > +=09=09todo_list_release(&done);
> > +=09}
> > +
> > =C2=A0=09return 0;
> > =C2=A0}
> > =C2=A0
> > @@ -1900,6 +1928,11 @@ static int pick_commits(struct todo_list *todo_l=
ist, struct replay_opts *opts)
> > =C2=A0=09=09if (save_todo(todo_list, opts))
> > =C2=A0=09=09=09return -1;
> > =C2=A0=09=09if (is_rebase_i(opts)) {
> > +=09=09=09if (item->command !=3D TODO_COMMENT)
> > +=09=09=09=09fprintf(stderr, "Rebasing (%d/%d)%s",
> > +=09=09=09=09=09++(todo_list->done_nr),
> > +=09=09=09=09=09todo_list->total_nr,
> > +=09=09=09=09=09opts->verbose ? "\n" : "\r");
> > =C2=A0=09=09=09unlink(rebase_path_message());
> > =C2=A0=09=09=09unlink(rebase_path_author_script());
> > =C2=A0=09=09=09unlink(rebase_path_stopped_sha());
>=20
> (picking a random commit that shows this 'symptom')
>=20
> You're sprinking a lot of is_rebase_i's around sequencer.c to make sure
> there are no changes in behaviour. I wonder if the right balance has
> been struck between 'no changes in behaviour' and 'common behaviour'.
> For instance, in this case, maybe it would be a better idea for non-
> rebase uses of the sequencer to also show progress.

Actually, adding progress would make for a fine add-on patch series. I
still would like to have as faithful a conversion as possible, and
everything else can come after that.

This strategy has a couple of advantages:

- we can concentrate on correctness for now,

- I get something to show for my time with Git for Windows v2.10.0, and

- the add-on patches do not have to be done by *me* ;-)

Ciao,
Dscho
--8323329-1730601202-1472743163=:129229--
