Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56CAD1F453
	for <e@80x24.org>; Sat, 16 Feb 2019 17:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbfBPRCj convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 16 Feb 2019 12:02:39 -0500
Received: from elephants.elehost.com ([216.66.27.132]:45360 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731594AbfBPRCj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 12:02:39 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1GH2X3N011844
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 16 Feb 2019 12:02:33 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Max Kirillov'" <max@max630.net>
Cc:     "=?iso-8859-1?Q?'SZEDER_G=E1bor'?=" <szeder.dev@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <001201d4c617$de429540$9ac7bfc0$@nexbridge.com>
In-Reply-To: <001201d4c617$de429540$9ac7bfc0$@nexbridge.com>
Subject: RE: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results) - Good News
Date:   Sat, 16 Feb 2019 12:02:27 -0500
Message-ID: <001801d4c619$68ae9160$3a0bb420$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFycQzmW9pNbu02MZcMspejNiBnQaanUEsw
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 16, 2019 11:51, I wrote:
> To: 'Max Kirillov' <max@max630.net>
> Cc: 'SZEDER Gábor' <szeder.dev@gmail.com>; 'Johannes Schindelin'
> <Johannes.Schindelin@gmx.de>; 'Junio C Hamano' <gitster@pobox.com>;
> git@vger.kernel.org
> Subject: RE: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results) - Good News
> 
> On February 16, 2019 3:27, Max Kirillov wrote:
> > On Fri, Feb 15, 2019 at 04:13:15PM -0500, Randall S. Becker wrote:
> > > Sadly, the fix does not change the results. In fact, it makes the
> > > hang far more likely. Subtest 6,7,8 fails here, at close()
> >
> > Correct, I did not expect it to help, it was for the other issue.
> >
> > As for the hang issue, from your another message it seems to me that
> > perl waiting correctly, there are really child process which do not
exit.
> >
> > What you could try is
> > https://public-inbox.org/git/20181124093719.10705-1-max@max630.net/
> > (I'm not sure it would not conflict by now), this would remove
> > dependency between tests. If it helps it would be very valuable
> information.
> 
> Good news. This patch does seem to do the trick. I wonder whether this
fixes
> the Azure build also.

And apologies for the stupid wrapping done by my mail client when I pasted
the diff in. The patch is available from the link above anyway so you don't
need the junk from my mailer anyway.

Cheers,
Randall

