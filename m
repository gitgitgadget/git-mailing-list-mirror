Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53A381F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 12:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757464AbcJTMQV (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 08:16:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:62525 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757451AbcJTMQU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 08:16:20 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MNw0t-1c0DLD2vLn-007TBC; Thu, 20 Oct 2016 14:16:12
 +0200
Date:   Thu, 20 Oct 2016 14:16:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 05/25] sequencer: eventually release memory allocated
 for the option values
In-Reply-To: <xmqq1szdnnvc.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610201415570.3264@virtualbox>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de> <b771bfbc88734b74acda0c377446e984ca81fd9c.1476450940.git.johannes.schindelin@gmx.de> <xmqq4m4avlr7.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610181356460.197091@virtualbox> <xmqq1szdnnvc.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:z7FjvELZHgLqgOsSzgmoGE/zyQzxGKiJE51CEQZqBp0OYvhjExO
 3vogvyNxYlmjhJwLXLwfn1avxGzk/C5A4RkmVeSCW+geCgBCSEwehEmvuoOSBIhlfcjGRfp
 By9j0PuENCiDi/hfCMGdUqqEIpf3z+Gk7K6RyitLnq32TTNtR7iLcSqP1J1GldaeHhiDrcZ
 0WH8U7i9bHeqqI2e3N+4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:k3R+qKj6xPI=:gRM+IKbSxxYL7sdKgdcOvE
 XzNOAkvqCzweOXadhtb3ro2xKIRxpdW9XsFFOlyZLC4SPBodH4du0AetreJxIUT5/NBanocHB
 r+JAQ4s7pn/x+gTlj/idscAxZ7VMYVEPFyp/5rb3A9vKDTkuHqaTWzKGc1i1+Us4rb7Q/OXx5
 SndkG4GGYGw7oPeFESFiCr93Beu9vpyE+UKJDi770y4JVGdGdNdndttztJkIQx/OUFrtsJuxR
 GLaUI3YVHk2nYO1a4PjcHmSB65MVo+DHVu0071ahflhrISOhAy1V5JkxujI6N/aNV4uJHD51y
 T8c7dYPftzLKyVTJZDewzvwRxLpsKcPx+fhpEXd71FaE2gvt9+wxNoVwBavupTfcL11Adqjn9
 LEoMDj+FvkfAcEwT2NiYCn7GxjxikQTxzEQfd0CGNeP2EOle+RDvkcWyQCdi+ApjlhNo1lfKT
 6pyDXkKHVVPeWHs9nZnfQomflj+NcASEYt06Yv7yaz0bNcqBCTpf8OMxe9wgvSy2zqO/IwYK6
 iKQ5A7omVNMnmh7UMOMKNHixa99D8Hz1Urnub/Tm4jJG43ExgMsmBkRObv7Z1UZoPQPM2arpf
 NnYecGq2noh5bGp5Gl53CZlrlQBXQQOpyiN+Mq5Cgy9G8sqhhKO7G+gm5uto5tFGN/13ekR6j
 vFSCfS2dtVDRwTM/chRg+frAzacx4MISWpHImH4/xUhb2xgK94a7Cif0uq0gr7kDt7YpsqT2J
 79xxwxCE7Mnxt19NlM3BgjE/goJGS22D6i9ath04mm0QP8P5zZt1P5NEiGLbfs80EhSn0GGWA
 K/QeB2u
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 18 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > To remedy that, we now take custody of the option values in question,
> >> > requiring those values to be malloc()ed or strdup()ed
> >> 
> >> That is the approach this patch takes, so "eventually release" in
> >> the title is no longer accurate, I would think.
> >
> > To the contrary, we now free() things in remove_state(), so we still
> > "eventually release" the memory.
> 
> OK.  We call a change to teach remove_state() to free the resource
> does more commonly as "plug leaks"; the word "eventually" gave me an
> impression that we are emphasizing the fact that we do not free(3)
> immediately but lazily do so at the end, hence my response.

I changed the commit subject, hopefully to your liking,
Dscho
