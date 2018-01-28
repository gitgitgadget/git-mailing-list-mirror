Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B3511F404
	for <e@80x24.org>; Sun, 28 Jan 2018 15:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbeA1P47 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 28 Jan 2018 10:56:59 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:8193 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751733AbeA1P46 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 10:56:58 -0500
Received: from HousePC ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id fpKCe02b8pb8rfpKCehUes; Sun, 28 Jan 2018 15:56:57 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZM2noTzb c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=6DslxY4WbQ7ft0SL-p4A:9
 a=QEXdDO2ut3YA:10
Reply-To: <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     =?UTF-8?Q?'Michal_Such=C3=A1nek'?= <msuchanek@suse.de>
Cc:     <git@vger.kernel.org>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>
References: <20180126183230.0ae0c76b@kitsune.suse.cz> <20180128151536.GE431130@genre.crustytoothpaste.net>
In-Reply-To: <20180128151536.GE431130@genre.crustytoothpaste.net>
Subject: RE: git send-email sets date
Date:   Sun, 28 Jan 2018 15:56:57 -0000
Message-ID: <001601d39850$a0a48ae0$e1eda0a0$@iee.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQFpbSVXcJPa+wgPC+olz2bAKHOILAIBla23pE25Z4A=
Content-Language: en-gb
X-CMAE-Envelope: MS4wfL8RozZNEysq/74lg67R/xc3CJvfIhsqRhepz7GW4+ZkB/RYZPkCSMvy8KDuO4TeHdm/1x9iogLUrWlNd842Q94/ph+1EpCaYQUlIJFPp2kYg3hHrUaB
 gdqNlGogG3aVMGuERIEEB3Tv1dcjLde5leS6ysxwBh2fnTpPkz18qtlxlEwxDs41JT4SrnMuZYodZsPynf9abK+bjmbD368fUxiquLkJazbKeVQsAIYfrncI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Behalf Of brian m. carlson
> On Fri, Jan 26, 2018 at 06:32:30PM +0100, Michal Suchánek wrote:
> > git send-email sets the message date to author date.
> >
> > This is wrong because the message will most likely not get delivered
> > when the author date differs from current time. It might give slightly
> > better results with commit date instead of author date but can't is
> > just skip that header and leave it to the mailer?
> >
> > It does not even seem to have an option to suppress adding the date
> > header.
> 
> I'm pretty sure it's intended to work this way.
> 
> Without the Date header, we have no way of providing the author date
> when sending a patch.  git am will read this date and use it as the
> author date when applying patches, so if it's omitted, the author date
> will be wrong.
> 
> If you want to send patches with a different date, you can always insert
> the patch inline in your mailer using the scissors notation, which will
> allow your mailer to insert its own date while keeping the patch date
> separate.
> --

Michal, you may want to hack up an option that can automatically create 
that format if it is of use. I sometimes find the sort order an issue in 
some of my mail clients.
--
Philip

