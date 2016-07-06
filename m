Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23D5C2070C
	for <e@80x24.org>; Wed,  6 Jul 2016 15:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbcGFPhP (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 11:37:15 -0400
Received: from mout.gmx.net ([212.227.17.22]:56844 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932229AbcGFPhN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 11:37:13 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LvzF3-1bLpw432rt-017oxO; Wed, 06 Jul 2016 17:36:58
 +0200
Date:	Wed, 6 Jul 2016 17:36:54 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Jeff King <peff@peff.net>, "dmh@ucar.edu" <dmh@ucar.edu>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/5] consistent setup code for external commands
In-Reply-To: <xmqq60sivlrt.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607061736310.6426@virtualbox>
References: <7210bce6-093b-9fdf-9a9b-94059ad0d4e3@ucar.edu> <20160701040715.GB4832@sigill.intra.peff.net> <20160701055532.GA4488@sigill.intra.peff.net> <xmqq4m89vw5i.fsf@gitster.mtv.corp.google.com> <20160701223912.GB32545@sigill.intra.peff.net>
 <xmqq60sivlrt.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HEHZTlJ0RgpDmq3BscvQC2vj4b0c91WJJDaQzHpljd3bJmRbmkN
 a+16PvPGiOtNE48SYxDpB5gC4rO9Z3ck10a6tet2LhN+r6n4tlyukyyKp7OIIiVhdbMRNS5
 5Pcf4WUFzfa7VjEXCtb8dGPuYktgtPeGSbnvD7r716KsgAs5dhvEYBaRTLziVaLc07MvIYe
 Hg4Sy7SjpwplOFghA+FyA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:0/yMK7HZyzM=:iOIGgz7LHGKUq2BttE9uAu
 vF9oyclMY6kcmf9WCbK+Dst2BqUJi+mMAmkdPwkgBCqoYGDmEvUInb6w6B7HTHvzCiCNughR1
 bFE4CLMFtAQFeCKnFpS/hPTF1zjfkKXWFVNaVaeGEZOsBbBdF0fWZyjfQvlAelsacLZMIDI0z
 kxsvyG789n8JRHdPmvK+A+GGui6H76JAMv50mqolSVzdYVIV9kq80r7Tqz34I8i/G/REjR4N6
 lDLIPbnyiOpHpz55dgyvzV7FsKaXue7mzY9S3KJ11ESVi/04oVmP+T1btFmjxe20oG7icpKGz
 FpDLIoQE8l3MaOOIakvNHgE49dsUdnrS9MjOxbLqS2VDA49U9Wx6E3q1TjYNLZqATTisc/bVF
 rG1uNHPS+8Fag9jTSSrMcqRfRk9LqC3AYhKQ0wQiRL3P3p/vQ7lwaPnOahFoZq242Ul9RG0Zy
 C+gsqnfu4lBTUTf8z5j0Qy9BIgG9/cEKLwth810ca3O0G+Oi8OuEZWfyLv0bTOtpK+vC9EblE
 v5WKjeiktKWZZQYo1vGnKMeL+vwQvYGmjJyznSWV0G4rLX6IxcaZzkkFwWpMv6x+J/NhRFl8l
 3N8JQVY4/Zb62u28JjjknLAidKY+QPaAN73Frj7ddiwJ5VxfPu7iDxzZtMYEdHFsdm0bC6ufV
 yctCJkfNhdbmJ8UH9wgkmKCx7aU+V21AkVg1Mhn5b95BD4tkmvNQySLeGN2pvJ9qAf59pzVbh
 Ehh6o9sOXth05E+v2LMwXHSkhEGjWZ/D/RjlOGCfbOUWUajf+p5tmpnznbM1mg/vGBVn/xLi1
 jcxYlEK
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 6 Jul 2016, Junio C Hamano wrote:

> I think that amounts to the following single patch, which I cherry
> picked from the topic in Dscho's repository he mentioned earlier.

That patch would be fine by me, too.

Thanks,
Dscho
