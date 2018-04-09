Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A992D1F424
	for <e@80x24.org>; Mon,  9 Apr 2018 08:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbeDIIc7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 04:32:59 -0400
Received: from mout.gmx.net ([212.227.15.18]:32979 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750982AbeDIIc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 04:32:58 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LgqQQ-1ek7lL33W2-00oBo5; Mon, 09
 Apr 2018 10:32:53 +0200
Date:   Mon, 9 Apr 2018 10:32:53 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     Joel Teichroeb <joel@teichroeb.net>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, gitster@pobox.com
Subject: Re: [PATCH v5 1/5] stash: improve option parsing test coverage
In-Reply-To: <a64d281b-a18c-7c6c-1524-92aef869209f@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804091032380.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180405022810.15796-1-joel@teichroeb.net> <20180405022810.15796-2-joel@teichroeb.net> <nycvar.QRO.7.76.6.1804061439100.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <a64d281b-a18c-7c6c-1524-92aef869209f@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:e8n90hl6d5DjiGSzfwWq9FmokcU6EZv1rpRvDVi57eWrDbyvBzm
 KK8bGlHugEpAZv+oMClhYiR23WDwJNKz6xYfsmjBdveLAaiJd5EuiIGJm+xcOjLkd4ukG8/
 dwR1YWwV1KhxI4GVXcw7B/saZwn2gKSPMCa5pQOkevEESiVBUsHwpNhebg9tkimqEvU4SYd
 5xXaLCSOqg5Tc58cGY7rw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bIHzQJogVKs=:KQuu3HVtsMyaloRr4qU+jz
 rFA8hc/9scFkHjiYy+FQskafvAiwKDeMxZ+JPNcT6aOr+ugXMs7xekQfJbVe0S/ZmVgtH0WQ8
 fI9rQ32+sfpOiPcQHtMkhDF29q3jrwlLTvBz+jx344lZFiLFNhAvtIzkw4csrH7CdRokRsdhw
 Fv6yxdPVSYON7LrWq4Puc2DuSzpA5TGbCFb/5nLV2eH0NEk0mYOMLqhKAh9LWbYwGyxL9lGzJ
 ffMXSea2U9KRHEwfqlRo8JumP5llK25CBwxFUN0c8ElaVFQFCSR5MA3IcjGUSUodj0FN+hC58
 mk/3UDTfwYMcXxyUY9anlJsJ14q3NthNlfJp69U8qA5QucRshpMjyrIkS77//C/KQP/8rzY9V
 GvSxMocftSIalgi5M3kSzt4iHeA9bfIImhBafNrSbarxVTY/NKsB/VezFN06NVR4pVpzx9q71
 Un4x0jSp7pXg7iR0+5G8RbK7m4QPbx5jhj2WLlUYTGzmcXgVAeViN5HUBwKQKqftd8/iF1UYg
 HhUsxW+K1b7OBJnohGqXZEO2ICQMwsvuAclZTbYituRoSwTFfsjLyR/GP/jjy0ZbdAlp0wt/3
 ogfRx52Hrq2T/EgUjoB//+c2nhON5G/j2b/SAGIu3U3/zXxnxeNNBXIVlrgiEg+uSSU8Vxmk/
 j2dB5zAQ6m8CeYnXQwClpQFRCGlLAM/CxgbcUqg7nUPcJvOVs+DdGyvSllR0Ygz+ghNXh0wNj
 Ypbrrt5zHFAF7Yw3C88NeuJkh8m+hQ0bBPvzvXB0iIKEHHtESGE2P+5gkhi8/sjSUWl5w202b
 DP37a5uOkSwBUbGsxf5aUaBIAB/GEBlm/bY1iOKet6NHQKPrtw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Sat, 7 Apr 2018, Paul-Sebastian Ungureanu wrote:

> On 06.04.2018 16:06, Johannes Schindelin wrote:
> > > +	git stash clear &&
> > > +	test_when_finished "git reset --hard HEAD" &&
> > > +	echo foo >file2 &&
> > > +	git stash &&
> > > +	echo bar >file2 &&
> > > +	git stash &&
> > > +	test-chmtime =123456789 file2 &&
> > > +	for type in apply pop "branch stash-branch"
> > > +	do
> > > +		test_must_fail git stash $type stash@{0} stash@{1} 2>err &&
> > > +		test_i18ngrep "Too many" err &&
> > > +		test 123456789 = $(test-chmtime -v +0 file2 | sed
> > > 's/[^0-9].*$//') || return 1
> > 
> > Not your problem, but if there is future work on this (read: if I get to
> > mentor a GSoC student, and if I get them to work on it: this idiom
> > `test-chmtime -v +0 ... | sed ...` is too common, there really *should* be
> > a `test-chmtime --get ...`).
> 
> Hi,
> 
> I submitted a patch for this [1].
> 
> [1]
> https://public-inbox.org/git/20180406221947.28402-1-ungureanupaulsebastian@gmail.com/

Excellent, thank you so much!
Johannes
