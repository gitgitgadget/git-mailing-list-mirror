Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E86920988
	for <e@80x24.org>; Tue, 18 Oct 2016 12:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753111AbcJRMET (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 08:04:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:65336 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750703AbcJRMER (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 08:04:17 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MaJPk-1cGKOV0zcW-00JrFx; Tue, 18 Oct 2016 14:04:07
 +0200
Date:   Tue, 18 Oct 2016 14:03:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 05/25] sequencer: eventually release memory allocated
 for the option values
In-Reply-To: <xmqq4m4avlr7.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610181356460.197091@virtualbox>
References: <cover.1476120229.git.johannes.schindelin@gmx.de>        <cover.1476450940.git.johannes.schindelin@gmx.de>        <b771bfbc88734b74acda0c377446e984ca81fd9c.1476450940.git.johannes.schindelin@gmx.de>
 <xmqq4m4avlr7.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rgkUWLnzgJZuZLUPUGyOkjt/pO6ryNl+wFCHEmJKH4iSNqsDZMx
 XSGMwBcV1YhxfKX0hmMqzfwFV3MsX002daGZH81NgCR/gGlKecIQYTKG5gyj5kJP/qHgeMt
 wWnFx4E+p8n+6vVJb5p3Z6XHxSGbznYNnRR8scUDqsO0Z8bJStuAPE2Ufj0n5xC+zhTjhWe
 SyLGrwpVwslm8tbJ1Bc0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F8KkfQ1ukl0=:XOT6uLTYtRgdD3eywnv47d
 wLvTIiG2/M5noJUvk/unCjkENliLsw1HCQJ44bOUYmSk/XHzrFA3CMtj+bdaH+8JH62DSOYNg
 fA4RsHtjHtf/lpl9/vBmLih/AUii2VQnmDcJ0A8qZnTIU7VUk7//Ac8YDmJ6ZrcmUGtRLEwq+
 AW6k7B5+hK2HGztFoaZTINaslPeijIScoCNXuCQjWvRakzSDSZe1RxexsXm91lWOICz1IDwC1
 7daqD9eqRaGBLtDtuO/GqaLkp9FZajlbU+IXBgX1MZkajIR7MatHsb6oQnvM1/sCMEAC+pyqH
 D1d3mV7ZVKsLNvni8vsQnt0HKyjVD1LY7+vyVW9VbxkaSIxHNnORjmv15+7mel2st2fezJhYb
 YGyBQPka5oNGnVLNAuyiVejQAP8KdVefmm4fYpNA6/BD1Jtb92lOt8KLNGKfJBDcKIqr6/Djk
 jiaCT8s4E//w48wLmyf/XzhBx0Xn6yUlniPsxctC1MdQJK7gafB55/dkAAl9WrEBINSTYPqgz
 1HIElqJSnlpJdURl6axFVt/N1Qd3JcqzKIBkr4Jrs/oaNLsyXCXK91DrS9sB8yufxG82Q6qjR
 qTKa6T8vA/f2cxGEXa7Bo6qSSlsOS2/ntlgqWRduXD+vjyLnqgNpSpBTqwzNJywMEBy+8K83C
 OH5t4coDim39Q+HX5i4gmdFm4jtxicX0wvZw78Skr7pX4akOPcl7gdPSnIV4anErXQTm8q2t8
 sevuyL5GlQbj7WbVlbAuSY6f+5wsWorpZEAUz0Vz2wAjr+haziVv2TdG8o6jnqEmfVyQGgqGa
 T6LlYdh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 17 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > The sequencer is our attempt to lib-ify cherry-pick. Yet it behaves
> > like a one-shot command when it reads its configuration: memory is
> > allocated and released only when the command exits.
> >
> > This is kind of okay for git-cherry-pick, which *is* a one-shot
> > command. All the work to make the sequencer its work horse was
> > done to allow using the functionality as a library function, though,
> > including proper clean-up after use.
> >
> > To remedy that, we now take custody of the option values in question,
> > requiring those values to be malloc()ed or strdup()ed
> 
> That is the approach this patch takes, so "eventually release" in
> the title is no longer accurate, I would think.

To the contrary, we now free() things in remove_state(), so we still
"eventually release" the memory.

> > Sadly, the current approach makes the code uglier, as we now have to
> > take care to strdup() the values passed via the command-line.
> 
> I obviously disagree with that statement and the _entrust was too
> ugly to live, but it is obviously subjective, and it boils down to
> who has a better taste.  Let's not go there.

Changed.

Thanks,
Dscho
