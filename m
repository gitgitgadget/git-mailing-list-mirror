Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27E7E1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 13:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbeGLNfw (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 09:35:52 -0400
Received: from mout.gmx.net ([212.227.17.21]:54455 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeGLNfw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 09:35:52 -0400
Received: from [192.168.0.129] ([37.201.195.126]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDn8s-1frNF90wgg-00H7Ky; Thu, 12
 Jul 2018 15:26:09 +0200
Date:   Thu, 12 Jul 2018 15:25:51 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
Subject: Re: [PATCH 0/6] Compile cleanly in pedantic mode
In-Reply-To: <xmqqin5l4w3r.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807121524420.75@tvgsbejvaqbjf.bet>
References: <20180708144342.11922-1-dev+git@drbeat.li>        <20180709192537.18564-1-dev+git@drbeat.li>        <xmqqd0vwaxrq.fsf@gitster-ct.c.googlers.com>        <3f0ab3f42606d2251a6574d6fb45bf11@drbeat.li> <xmqqin5l4w3r.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lbZJJTuCkcr34/oXI72zKNVM7e5pHdEdwWxZSy+0xVrqxQltwg/
 LBp4oRU3lRtTm0+YlS7j7KjgL6hzN9MJZvkdBn+Glhw7NQkVf6rqqRUVVcfQNoSnvGg3fCX
 i+ofFd8f7CjDUkw37jHpKRzObqh127goYI/MDUO1jyoE4k/0lHAGejvU7HfT7OPcrEciiYp
 FLoOVjC7oyD146C4gNyqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T97DiuUa/c0=:NEmT+V2pYkQdZUzjCqAsm7
 Pw5sHUGeMrDNshQtodNPscleLtYl3ewY7CigoUBvNs7Hn1nIATBF7TrCYcorEd7g+/eejzIQn
 RIcEkIgWjBr4fz85AJ2L65hPFebmP72Y7P6kSS1tw7017JUi8Fu/fwNgrsLTQgLnGe9SVNLwg
 oXlAOwVO5hlBZmC7JZ6GDi2Y63ObL1GsYatiBPJaqUwuCwRMj2lTxZRRNIIgQOgDFyWdq+hr0
 e/ljUeF1MgrvRSnOzLqUDYZwPeTF1H5CGvAN7FtqRs0OCWqtGU9/+403hw0zg9hoDia0ARnuk
 f/MhwMSRfoNxgndpkSo+bVW17qo/1smzyKPeAoNEJ5tzjI5BJ65kPiIJW+BiObfFqsEYgUmLP
 bjmkYMGEQd0ZoT9OZfYsh4VD7dEz/Ud0ETRQzmMh46Q5pahK6hfMzcGCb0BbqS0bO8km6xV3g
 FJF7McIfLN7ANLiAgAvk4RBeA1HPd2zsAj0I6uGLAQwsc7XvuobJli9PG5dZt5mLnondNCnZN
 Gg2BmhPg90xV/mOiBrjujOou9KizUqr+1IDr68oLUV5GiICXZujJOgOyWK/M+1ldXgKe3+rOz
 VKnABIz0W363g/rCYrllW1u1FTsTFpZgdnkOX8Suf9s0TGvXOxmqjuhZ9bN6+8wXZstEMlHYC
 gXnQLEp22zqEIRlOj4e5pJdQNtTlUQVLetrgYoZ+CXIiFxQ1l8Lyte2M1DaScUE7Y2Gu8y3eW
 kqeIg8Rx+iIpv3IfA4Tyl9soAHLLMZdjgCtun6DyHYxD7n802zOlIF7Bq6s6jG//Qp3J1IqR9
 OBYtezY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 11 Jul 2018, Junio C Hamano wrote:

> Beat Bolli <dev+git@drbeat.li> writes:
> 
> > Should we add a "pedantic" flag to DEVOPTS that would simplify
> > building pedantically? It would also have to set
> > USE_PARENS_AROUND_GETTEXT_N so as to not overwhelm the developer with
> > too much output.
> 
> That may be something worth discussing before doing; I'd prefer to
> wait until these 6 patches, plus the unsized static array one you
> did spearately, graduates to the 'master' branch.

If this change to DEVOPTS was done as 7/7, then this would be very easy to
guarantee (or as 2/2 if you want to graduate this here patch series faster
than the static array forward-declaration fix).

Just an idea,
Dscho
