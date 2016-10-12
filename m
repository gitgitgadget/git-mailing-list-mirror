Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC4D620989
	for <e@80x24.org>; Wed, 12 Oct 2016 11:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753933AbcJLLx4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 07:53:56 -0400
Received: from mout.gmx.net ([212.227.15.15]:58484 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753558AbcJLLxz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 07:53:55 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MHoC5-1brHK22fxl-003amL; Wed, 12 Oct 2016 13:46:51
 +0200
Date:   Wed, 12 Oct 2016 13:46:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 08/25] sequencer: strip CR from the todo script
In-Reply-To: <xmqq60oyaf7s.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610121346360.3492@virtualbox>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de> <5a639610c09bf1dacc8143603f321a8ea23cd270.1476120229.git.johannes.schindelin@gmx.de> <xmqq60oyaf7s.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/lTGUPb999RdEEVAofDR7H9M55tOm0Qr08Mc1oFHRJ38nBAQCrR
 HL30zgkuZXUsPBCj+A8kfsJY3kF5g0k6nc9DTsTiC47MFLGc6eDm1irVexHeJNVIHLhh/6+
 FY67NawwRYR9Vgmt8o5b0JeDWf3+ETgVuL2PkHMayXNS/3yGpR/MQGrvcXgtXaqJLctewr9
 YDEP/6Tk1bxRJLCEeBTvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0DT0uChfHYU=:zO52AyDoP/MpP27X7/Jklx
 DI3MBI9Rc4ErvWZix/m8XCrJmzB1WK5v9Xb46zXkvZJS6BTfB2plnhDbY6fw2mgWG/hkFMDtd
 rGa2eAkc1xJPv6XaBvuQpHcdScxIRDBypIM2sC9v1QXMfkZgPcQPehXHvphrCVFg6iQu9XWl3
 bSuW4H83+SgxWEFV0+ufkuDuvQ0kfCz/px32xDVTrFlyfsUDJcTiK4PSl2pUXDCQaFd5AJYwE
 jZ39htBb7qUUPu0Ycq6rqPx+qHQs01Ypmr8K+eOyhdR6MqfFsyAvG1YA4oa8Cp0EwktxX/kSJ
 SHpeeVZorLWsGXdorLsAGPlngX7FYIKNYVBspbVVLtRu6KNtjyOZxATkrU0uXhbZfiIQgnEtn
 3dkGxGJTKH3cVFmo+E/vBm4VO2PrX8D9SkPfXdFF5WKzuDCluaMxDhdaFcDCrXhNvudYBnWvj
 KurOSXAiUUiqakSCRt34T7/wtMggCkxnC24If/hpXqliTpUVe2rEzyAi3ffdmuiKboCmzYPMe
 Er66IdIzRsDuG41Q9MrG9LP93Qms5HZJqJKYMKLFedyvpsqObB9pGeV6DPFZ2ZFPpVAYe9GKQ
 Y16lCzfCq3UdoTjkj9Cv02Bh24ZJPL0jN1H2jfX00Uu6rxxLuTv2WrgyFRiuKJE+UgtHCvL3O
 120gnEclwgI2evU3wBkfZCC+8+uQEWj3+YMfCBkcGs/qOd//Xi2419oyVo43BZQdeUGzy2wka
 dorhA+a/4k1BhqT3ra7tcKdVVkf4OQezDdUj6BQTh5RoVjVZFDcD3ehXtnCWJNRq1/PKcG6qp
 GYP9LV+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 11 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/sequencer.c b/sequencer.c
> > index 678fdf3..cee7e50 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -774,6 +774,9 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
> >  
> >  		next_p = *eol ? eol + 1 /* skip LF */ : eol;
> >  
> > +		if (p != eol && eol[-1] == '\r')
> > +			eol--; /* skip Carriage Return */
> 
> micronit: s/skip/strip/ ;-)

Okay,
Dscho
