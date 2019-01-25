Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06AF71F453
	for <e@80x24.org>; Fri, 25 Jan 2019 13:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfAYNF6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 08:05:58 -0500
Received: from mout.gmx.net ([212.227.17.22]:34595 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfAYNF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 08:05:58 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LeSOH-1hYDtO47FV-00qBG5; Fri, 25
 Jan 2019 14:05:40 +0100
Date:   Fri, 25 Jan 2019 14:05:23 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Sven van Haastregt <svenvh@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] git-submodule.sh: shorten submodule SHA-1s using
 rev-parse
In-Reply-To: <20190124214953.GA19668@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1901251405010.41@tvgsbejvaqbjf.bet>
References: <20190120204653.3224-1-svenvh@gmail.com> <nycvar.QRO.7.76.6.1901221623370.41@tvgsbejvaqbjf.bet> <xmqqbm48fnl0.fsf@gitster-ct.c.googlers.com> <20190124214953.GA19668@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hUwi5k4TnT1yHi7el7GFnL9fjhnGTlMQtIRyMZ6Gx/UMS0T6TQ0
 Huzv+pURle+DYGpNNYSUVO7Pn8noyrrfHuXw4nn25KJojDEVicr+Cuilcax4N7heo8ogSbc
 B/TcM+P6JhErdzbzoEYDZYhnXf2xXVKJWji5kbKEhY+n+9bdCnwLAuEO6ntjO11tH5aCoJb
 SmNW2lR3sTqFxco96LJGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rhl5H2Q92tU=:9gggIGHG7csIk3dKb2atbL
 gooMOlZwzdssh6JJ10nEwqgm1yJHPauYr69AEIw+TYlkOJm/B4YimAcuj+QITmopUQ94vKK86
 DitenfgjP0bw471cr4dpl5QfKOb7cZmJPBcmiUCBBNk9HCKtmC+qL6X6n/mtBZMHWFQo/jena
 Dp+g2VI3OEbNMtJI4XMi6llSygjSQUW3U2A1BvO4RP/ugVry7vDFFg/Orihv66d2TjpSp+9d6
 uKPmVMFUxv6O28EmaC/c9gr0t+VPypCCEuX6mKxPYGno92eDRY2m4Uf3tqsjg3cr5EjWQr/WT
 ccYnUSvMccD4Y3uQpEKKo+dN/HS53yQMa3blSyCQSj36C0V0hHXWsOSf5X1d04Y8Vq4SCwU6e
 jtdd5xWXu0Cs8b5arfwJu4NugvUvT0ZbtjVKYpHYlzlaN441Aymq6j7vCTO/fFStGbsym840N
 iNNo47fNCYA7IpqhvBxwid4U73dw6YCodBUc6tvAt4kYjrltTtMj5ZGnDDbcWPZlkXxUKQxyJ
 ETCPqoXsblUXG7Lxhs9iNaQQKBm446ZjINYMTKPKhqvykyJT911upgO6kpw4hxlHL4b48EZG5
 9oQs7Ao0Qx9dce/4KVYGsyrzWkI4HZKPNykueEoZ5tEZ79VjBlFzyFZi+de9kIA3G30/+i7Ad
 kMbZ7u1COgA1Ky80gEb/LfcldM05tpDlYwFKpmV8OqBBg/YwHY1OD4rW++W1CkqFfwschplUJ
 bgL9pkR8xEdTQV1QV4IQIERTxiI8/7nOsoctVUsoWrKDdIm/JulTdFJ67Iky5bfZbnqzAJ43n
 j00V/UVHe9DKBr6zdbqTvBTHKUVghteL9XpNuYMPmb2ImsLUwoqUAS4jTd5csbxoXJRm8WNW/
 ymhtEQ0lGLFQYHZniwpmpG3BxZ9J1K2JMldLFx4rmus99LWQ9I2EXJBDN7K8oLmxiEi51MoHi
 5etXug31YGA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 24 Jan 2019, Jeff King wrote:

> On Tue, Jan 22, 2019 at 12:23:55PM -0800, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > >> +		sha1_abbr_src=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_src)
> > >
> > > How about `git -C "$name" rev-parse --short`? That would less likely run
> > > over 80 columns/line, either.
> > 
> > That would be a separate patch, either as a preliminary or a
> > follow-up.  The existing code has too many of the same construct.
> 
> It's also not the same; if $GIT_DIR is already set in the environment,
> that will override auto-discovery done after the chdir() triggered by
> "-C". It would need to be "git --git-dir".
> 
> Sincerely,
> Somebody who has been bit by the distinction many times

Ouch. Good point.

Thanks,
Dscho
