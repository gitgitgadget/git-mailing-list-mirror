Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB2621F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 14:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933290AbcIAO54 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 10:57:56 -0400
Received: from mout.gmx.net ([212.227.15.15]:62091 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932474AbcIAO54 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 10:57:56 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lbdl5-1bDshs2ymh-00lESF; Thu, 01 Sep 2016 16:57:47
 +0200
Date:   Thu, 1 Sep 2016 16:57:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 20/34] sequencer (rebase -i): copy commit notes at end
In-Reply-To: <1472714431.4680.1.camel@kaarsemaker.net>
Message-ID: <alpine.DEB.2.20.1609011656340.129229@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>  <7427d5a9e76264252540c72c5a70e71c3d470667.1472633606.git.johannes.schindelin@gmx.de> <1472714431.4680.1.camel@kaarsemaker.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2069680547-1472741867=:129229"
X-Provags-ID: V03:K0:qjhL/dpNS22jy5nWUuN8m9tfNeC8dM414Tw5Q0Od/44Q0LuhKY9
 xtqshzLqAViV5Rz9w/KdfAgKCOHW9euzby8D+4O5uLhFWNJJL59bJQxYu4WHNQwftznkRPu
 QFyEFgU9bNv8PRF2pNliQ2I1mqvi+jg5hNitShYC2Or4/GL7UFIO7Z9KCUzSA2AeYCm2dzK
 tJxbFNbXWeB5eIxCCj22w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vgG1ZSFn620=:HyuN+EWxhAE+2UgehnmKja
 WBNjEr1rVNYoRkNXT2QGISFgRTsFMPT2CZHiuvqmuWjDErtLZ9bXTgaUoLnDQh0paAG7nhxWW
 VhXLNDUjG0Pxb22qqIs5NpdAz1gxRKvDdjJuj2m88JKbmWu7vGpzZFAKmcrFrVwSaGyq2EF5+
 TX6BdRXILxeA1F+g9sGHBJgX4L2PnFKPqyOc1BVCJUFBAn4dmqZxU1fcJAQPfv7msNh6QvLdn
 b+rs7gesVzo5QViOJ/b7q8hNLbQiD4VKxcN7gXsMOJDoAj5UihZgp11ETPNplcl0B3XABIPDv
 j3Lv7gsZRC5aF5LNI8SzN+NdTNuAmYOWBTCWqg3b/7KGk1/d3AQmJcfHwrUiZW/ozDFNQr/ir
 v3x6W5ppcY5Pn4exKbBUtW45zMcjJBkT4MbdNYIlU+zUeZ/DUSQXHEmlMWBP43wIe+BJDDt6z
 lCG8cjZbZLNxnuCb4CAcULDdhnv+kWwOvLvG74+Jm1ei/ojPtMoeugvh6uw2hJMveDuGA80Db
 PW93aSw1Sgu60yNhaf+JauK+5DL2mklio8uEosPjnIuGW8EDRK9GZ9e6obzMOb0xw2ZRQHeOB
 zcuIQd1BsTs8DcgAwtMslAv8UzyYfHlSSqklTFgP4U2TX4Ih8IeCXKsFvSDr4EqRDqzx5NgY0
 vAfQxwEhzAsXtPkPFWEuODZ+sewctr6hdD/iAlhGkw3rrQ78AC3IIX6MKZpsAttx6f+BqPYEH
 tIrNnFe4D7w2xzGC219oBLKl/bV48MF+SnHbyB2jDjcQqxdB+nG23iXK2+nN0WYi3o9TN4cfm
 4TZHhlw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2069680547-1472741867=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Dennis,

On Thu, 1 Sep 2016, Dennis Kaarsemaker wrote:

> On wo, 2016-08-31 at 10:55 +0200, Johannes Schindelin wrote:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (!stat(rebase_path_rewritten_list(), &st) &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0st.st_size > 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=
 child_process child =3D CHILD_PROCESS_INIT;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0child.=
in =3D open(rebase_path_rewritten_list(), O_RDONLY);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0child.=
git_cmd =3D 1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0argv_a=
rray_push(&child.args, "notes");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0argv_a=
rray_push(&child.args, "copy");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0argv_a=
rray_push(&child.args, "--for-rewrite=3Drebase");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* we =
don't care if this copying failed */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0run_co=
mmand(&child);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0}
>=20
> I know this is a strict port of git-rebase--interactive.sh, but
> shouldn't we at least warn the user that the copy failed?

At this point, I want to have as faithful a conversion as possible (except
that I do not care for the speed of git-rebase--interactive.sh, of
course).

Besides, I am fairly certain that a failure will result in an error
message. We just do not act on the exit value.

Ciao,
Dscho
--8323329-2069680547-1472741867=:129229--
