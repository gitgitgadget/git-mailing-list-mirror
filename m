Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9B2E20281
	for <e@80x24.org>; Fri, 15 Sep 2017 20:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbdIOUPP (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 16:15:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:55736 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751545AbdIOUPO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 16:15:14 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MTBLi-1e1ETL2eik-00SBK1; Fri, 15
 Sep 2017 22:15:09 +0200
Date:   Fri, 15 Sep 2017 22:15:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2017, #05; Tue, 22)
In-Reply-To: <xmqqo9qbx14b.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1709152214100.219280@virtualbox>
References: <xmqq4lsz2x6r.fsf@gitster.mtv.corp.google.com> <7D99B245-4D22-4C9C-9C43-C8B8656F8E6D@gmail.com> <xmqq1so0wyjd.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1709151816390.219280@virtualbox> <xmqqo9qbx14b.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RlPFlm1M6MGUtEVo0CRUSMGGafC0nLTMGg2BkkTemIPaJKkpsN9
 CJiQDa1fmQTRO3eNv0xUkybszG2oL/vPmq7+iEc/KQuU5Kow10/C7qcglJ9Nw6rhqrjOhwX
 hqLIuFbXh94LoMSLPL6ZErbaf7zg/wm3uuSfIE10xOKEYfV7ple0OTxsmXXsbZeJvQkrtRY
 4aby5lPNuw2ElgmRBMzxg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+wrUscSYWH0=:q7Nc+Cs+DHaSsDsAQ0U/QZ
 n2cWaMk/4inKz5zln4HQwXo5ZnCBOoY2IjPBReIZ80fKLOE565tIFAMfzRzTkTxD3eW61lbRG
 pGEq6935ddjnbMQ4Tf7CFnPB6rlzFIXO1yyLOWgvfTplPi+98mqonBnei4xkOO0OyAXVUISE4
 Uf5t7FGOqRlAozvuzHumBXOIBHE7RYwcQ+8VsyuzEt9fgrfSVFe7Ev6xsOxwLDcaCgTW8frzl
 Ud4qfnkOWbzNiPP1nlWRnH7zqYl7tMzh/zymA2fqCwtx3xsjdnJTKvCOUcwJanHCevFZvAZLP
 Uu/SllIH6LfoXTMxRBbcsZNkUS6pknuWil0u8s2rA2YBKnh7C2vCDeZqWmJ1cm6/PpS5/hY6i
 f/rqjArB7nFjCF3BARtKHAlazQ0llHYSB9Ycf4b/P7771zbqEUKPqY7Rahg5jrK7V3WdW1NlH
 pl4QR8pDVhtXrndGuw0cFETpaTiQfUHfl7pj0sf4KDCXuY0LqZWGKhaLSqz377wQLYlmkdK1f
 MOln8+t67mREQIe7AoxiiRdbQj3FBqx/XYlohokCSMpdnYl8NHeCmsss+UjezTpQ/BEIhYvdB
 lLgNBMYmmYkWICT9fn1sJsaPwxaVNLYDtLAtxa/0Npr7jJGtIWVripYHJt5h8RtV45R0OrwZ9
 Hs46vuj+xJkp7LayYyrP7btZ/uUnAMW/wBpsesJE+dIB4fsSL4djMp1e5srtlJ7KVIoMGasml
 ccEm/zcbSbtBcvmnUFgom+Hew5sOm6xpNde7Vhj5GIoqZSYb7OkshF02nBz7LTlgxIZYCtSXF
 2CpfCNNyJ/8kArHXYSiYjeuTy4zTKY6gqrGfex11q7+HCrpOSc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 16 Sep 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > If you want *contributors* to ping the thread themselves, how about
> > *posting your updates there, too*?
> 
> I do not understand this comment at all.  That is what I and others
> already and always do by responding to the patches, and when trying
> to see if a topic is still alive, with thread-specific responses and
> pings.
> 
> If you are demanding that "What's cooking" report to be sent as a
> response to all the topics, that will *NOT* going to happen.  It is
> meant to give a summary of the current state to help contributors
> and reviewers be aware of what is happening across the entire tree
> and not limited to a specific topic.

If that is the case, you will have to be okay with others responding to
your "What's cooking" mails instead of the original threads. That's what
you are buying into by having these "What's cooking" mails that are in no
usable way connected to the original threads.

Ciao,
Dscho
