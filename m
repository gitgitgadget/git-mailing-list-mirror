Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D4A91F453
	for <e@80x24.org>; Thu, 21 Feb 2019 21:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfBUVaj convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 21 Feb 2019 16:30:39 -0500
Received: from elephants.elehost.com ([216.66.27.132]:13598 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfBUVaj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 16:30:39 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1LLUW1l071245
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 21 Feb 2019 16:30:33 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        "'Johannes Schindelin'" <johannes.schindelin@gmx.de>,
        "'Duy Nguyen'" <pclouds@gmail.com>
References: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com> <012601d4c8b5$54f1b730$fed52590$@nexbridge.com> <xmqqftsiw8l8.fsf@gitster-ct.c.googlers.com> <001501d4c9fd$bf80dfb0$3e829f10$@nexbridge.com> <20190221210654.GT1622@szeder.dev>
In-Reply-To: <20190221210654.GT1622@szeder.dev>
Subject: RE: [ANNOUNCE] Git v2.21.0-rc2
Date:   Thu, 21 Feb 2019 16:30:26 -0500
Message-ID: <004c01d4ca2c$ac757e60$05607b20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQC1VVUPHT7/O/TkZraQz8YJYJGYJwJcqRQXAcGx2NcCbRJ2oAIrBmt9p+P6Z6A=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 21, 2019 16:07, SZEDER Gábor:
> On Thu, Feb 21, 2019 at 10:54:31AM -0500, Randall S. Becker wrote:
> > /home/git/git/t: sh t4153-am-resume-override-opts.sh ok 1 - setup ok 2
> > # skip --3way overrides --no-3way (missing TTY) ok 3 - --no-quiet
> > overrides --quiet ok 4 - --signoff overrides --no-signoff ok 5 # skip
> > --reject overrides --no-reject (missing TTY) # passed all 5 test(s)
> > 1..5
> >
> > Technically, we have TTY, but not that dev. The TTYs are not under
> > /dev/tty*, however.
> 
> The TTY prereq is not about /dev/tty, but about whether 't/test-terminal.perl'
> can simulate a pseudo-terminal, i.e. the necessary Perl modules are installed
> and working appropriately.

Good point. We don't have IO:Pty on the platform.

