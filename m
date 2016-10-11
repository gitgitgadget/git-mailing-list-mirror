Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16386207EC
	for <e@80x24.org>; Tue, 11 Oct 2016 10:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbcJKKz0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 06:55:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:59149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752019AbcJKKzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 06:55:25 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Ldttv-1bCdkW2lrX-00j5NV; Tue, 11 Oct 2016 12:55:15
 +0200
Date:   Tue, 11 Oct 2016 12:55:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 07/25] sequencer: completely revamp the "todo" script
 parsing
In-Reply-To: <alpine.DEB.2.20.1610111221530.35196@virtualbox>
Message-ID: <alpine.DEB.2.20.1610111238470.35196@virtualbox>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de> <4e73ba3e8c1700259ffcc3224d1f66e6a760142d.1476120229.git.johannes.schindelin@gmx.de> <xmqqlgxvdf90.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610111212090.35196@virtualbox> <alpine.DEB.2.20.1610111221530.35196@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:f+JvxhzEXtcyqVSXsyRBhg7cRyLDhsq7dAzhcbpe3O3xUF0JdKg
 06SsCiFV1lPrAwWFrjusI+BwMTlsrs8RHd93uWjjQuYhnLoSsxh+YO/2KKRbw7fWeoPnO7U
 lN2vvEg8B8JZM+qqsXffaodk/OIM5ywZ8Uet1xL0oCrmxSg0he+3t/27q+A03FnfLY1yhAZ
 jJCs4J788uk6Z5ZEq3Ipw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dcQgtAZMc7M=:DuRkQGicgT8tBXqPRRlX1p
 zk44s7zCWvSjzDAivl1jgkgX055nONL3FrgP6A2t5oqL93bkf9Hg52Cl0jLxcgMPYHGhWqUPE
 xzAmv72TvKYp0h9prqCWjjaFoVNIHOI2BIGNL8mN3a3a2ow/QHVtKRqmLcuU8uYAK1u0xu6Xd
 Mwv8fLSzLv+/0Wc3MEMDAozW1lzNx7VcfLGc2/U5d9r2djnyldxKTiT0vfDgcSQXsKFdK+cRX
 I/rHFbopt4zSKg32uYsiHfNSr0K0KT4ak5g1TBraqhuke9TN9xS7lUh4Qqya5zCA/tGItPPB1
 vgACJVvqpJDZDksBsWN5UMTwmrljSYp7yd5hNl2P7z4eOlkLSqd/zXgtg4+c5Ki6Lb7CQRqZ3
 7ydZE+cTfL/sxF1tK/IJRV6xbnEbVlcpIZWPlhjrxQOyf/f1yuiW5Of+KN0wPpKfiNnEQRi95
 gkVcu4we8WmHSw7PF22xkWyDaG/jFQ4dj1OdiapABliI4FaL3U/hwJHpHDkUqAXvrPOSIpVLl
 EMGAVdG5p9Np24Fc+RGR2Jnb2wK33wY3LEKuIBQ45VwcCEvonKVp3ks4AacJ/0EcKCaEa2gDl
 k57Dxdj5yf2Sq0XKrJR+4STC5EKoPdumA3/vSveGxaO8liQ6F4vfpxTrhcHa610QreClRbkCk
 BMyZ4Ji1oIzv/ykofddM+xdxRRC5Sn7fwk405yD6F00p7CnxhdpBKwuWgcgZ5FW70KDmtqNzM
 PaaNRHTmcyUWxpwjiHa25i+gXvikb3z6FGQvG7+J8Wr0cEDioMS/KM5frY1t/NakZ/2n6/uZq
 du+7nM3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 11 Oct 2016, Johannes Schindelin wrote:

> On Tue, 11 Oct 2016, Johannes Schindelin wrote:
> 
> > -- snipsnap --
> > @@ -906,11 +904,13 @@ static int walk_revs_populate_todo(struct todo_list
> > *todo_list,
> >                 item->command = command;
> >                 item->commit = commit;
> >                 item->offset_in_buf = todo_list->buf.len;
> > +               strbuf_addstr(&todo_list->buf, command);
> 
> This would be command_string instead of command, of course.
> 
> > +               strbuf_addch(&todo_list->buf, ' ');
> > +               strbuf_add_unique_abbrev(&todo_list->buf,
> > +                                        commit->object.oid.hash,
> > +                                        DEFAULT_ABBREV);
> >                 subject_len = find_commit_subject(commit_buffer, &subject);
> > -               strbuf_addf(&todo_list->buf, "%s %s %.*s\n",
> >                 command_string,
> > -                       find_unique_abbrev(commit->object.oid.hash,
> > -                               DEFAULT_ABBREV),
> > -                       subject_len, subject);
> > +               strbuf_add(&todo_list->buf, subject, subject_len);
> >                 unuse_commit_buffer(commit, commit_buffer);
> >         }
> >         return 0;

In the end, I decided to actually *not* use strbuf_add_unique_abbrev()
here because it really makes the code very much too ugly after the
introduction of short_commit_name():

-- snip --
@@ -1093,10 +1093,16 @@ static int walk_revs_populate_todo(struct
todo_list *todo_list,
                item->arg = NULL;
                item->arg_len = 0;
                item->offset_in_buf = todo_list->buf.len;
+               strbuf_addstr(&todo_list->buf, command_string);
+               strbuf_addch(&todo_list->buf, ' ');
+               strbuf_add_unique_abbrev(&todo_list->buf,
+                                        commit->object.oid.hash,
+                                        DEFAULT_ABBREV);
+               strbuf_addch(&todo_list->buf, ' ');
                subject_len = find_commit_subject(commit_buffer, &subject);
-               strbuf_addf(&todo_list->buf, "%s %s %.*s\n",
                command_string,
-                       short_commit_name(commit), subject_len, subject);
+               strbuf_add(&todo_list->buf, subject, subject_len);
                unuse_commit_buffer(commit, commit_buffer);
+               strbuf_addch(&todo_list->buf, '\n');
        }
        return 0;
 }
-- snap --

I hope you will forgive me disagreeing with you here.

To make it easier to accept, I reordered the short_commit_name() patch so
it comes before revamping the todo parsing.

Ciao,
Dscho
