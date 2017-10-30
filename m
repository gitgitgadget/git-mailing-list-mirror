Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E6BB1FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 17:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932546AbdJ3RYp (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:24:45 -0400
Received: from mout.gmx.net ([212.227.15.19]:54363 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932434AbdJ3RYo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:24:44 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MfEMs-1dopd42r6Y-00OsJp; Mon, 30
 Oct 2017 18:24:40 +0100
Date:   Mon, 30 Oct 2017 18:24:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2017, #07; Mon, 30)
In-Reply-To: <xmqqr2tl40pl.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1710301823480.6482@virtualbox>
References: <xmqqr2tl40pl.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+JuHWvv/olcOa0cUor0oPd94hOuxmLB1KYVxYXB/xXVTTADXFWO
 cttUryLKl9u1YnySnYm3JsIHcsYvg2fXXiMKW0Cra/okEwZNNqF5OfQ9p7X3U/DFJlOs3qw
 JSbe9no49rDB55SZtFMfisU61UgJBIyiI6+vTmCkP9BLSRmNlrmWX/h/MWr0pJ28U12cvBd
 lA9WBGGp0G3nK6aH92a0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/f7+spL7kQw=:mzlefFgrL4+ndUKwssz3oJ
 //QOezUC0ERl69HH9NCn1+lByCMbCKJKiMuXxELaOL9SSMVDUiDwKbdyUQzg0Gyiw5gjieALR
 p0aswcvU9mvB+rEbOHIXQxoWE3/o9w1JjkpocizxoGbDII1Wjl1LmnaFm6gHmtWKNKZBl5QVa
 Tauq1TR1ozqbcjp7qKky0Xtv2cfdouLcQ3lJJjWk2gXVOU1eFOopDM8aBsIOjJpW8TAXAkeCb
 BNNBzeWRAtDz5eSDaeeUXKSIQjUAuX4hOD1VgYK39l2VBvWPpIV487YlFSqKNJawzxxHNCO8x
 mmjzXak4MzEosWdaanuqR+htMAnajbP/ug5Z/oGZ28+h2XXmztu4UzO46D0YVL++GFbTEbZtN
 v+yCvFCq8Qlm/Qv/EwjixUECgiXmZl8ON488fM6lwC4gQMYGUebfN/PJiCsPETXgCNHcqTQuw
 Yh4x7UBW9E4fgrlNZ0Fsq5xB8AL3BM21cU02uAo4Ne8KeOc4NccTpikhgwBHFxs3Km9JAONVm
 T/8CU7WzZmnmkyIDXjneTlixJZtiHVQ72UqYBrFc21ylsrSeNZAFBUTUNN8o/Nv3JFjRGqYcy
 4PAP4ESBQg2sflSRcvNW5Apr3RaaZM4q3Vg9QPxEJ+d3kxvsstpZNpEeHQ+RPnSX5i2wShzLR
 gOqekPwlf5d/JWFyrXjUCpsfHee3+Oazh6OqocjbCIpCoX+vWkhtm+nO0WhQpiDxas66O0YVb
 XqA4VVrLkNEjcXAvkfKhxqslqkIV61ggCr9DKSRtaXhZNHrZ7intv3hAAqfbWv/Fsh2A5vtog
 zkH/Em+m6C0JdfnNbLkxnu0MERZPOpE4pPWN8HCSd/gq6bCqIXAq4RFgcF6OVyoR1EhFkuF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 30 Oct 2017, Junio C Hamano wrote:

> * cc/git-packet-pm (2017-10-30) 7 commits
>  - fixup! Git/Packet.pm: extract parts of t0021/rot13-filter.pl for reuse

I am really terribly sorry for the breakage I introduced here. Junio,
would you mind amending this commit by deleting the "SVN/" in
"Git/SVN/Packet"?

Thanks a lot,
Dscho
