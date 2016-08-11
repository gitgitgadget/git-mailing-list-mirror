Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 543DF1F859
	for <e@80x24.org>; Thu, 11 Aug 2016 08:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932971AbcHKIw1 (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 04:52:27 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:43271 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932715AbcHKIwY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2016 04:52:24 -0400
X-AuditID: 12074411-a07ff70000000932-cb-57ac3cc52a02
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 49.D4.02354.5CC3CA75; Thu, 11 Aug 2016 04:52:22 -0400 (EDT)
Received: from [192.168.69.130] (p5B1044D7.dip0.t-ipconnect.de [91.16.68.215])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u7B8qIFt018235
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 11 Aug 2016 04:52:19 -0400
Subject: Re: [PATCH] xdiffi.c: mark some file-local symbols as static
To:	Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <29c40cdd-363a-df09-f9e2-fe9070bb8a9c@ramsayjones.plus.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <3f39b220-d33e-97af-f43e-00a265c32fa6@alum.mit.edu>
Date:	Thu, 11 Aug 2016 10:52:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <29c40cdd-363a-df09-f9e2-fe9070bb8a9c@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsUixO6iqHvMZk24QXOPmkXXlW4mi4beK8wW
	M69aOzB7XLyk7LF/6TY2j8+b5AKYo7hsUlJzMstSi/TtErgyfu1cz16wgqni+UvJBsYPjF2M
	nBwSAiYSmxfdALK5OIQEtjJKvG/ewQrhnGOSuPjsKQtIlbCAq8Sr4wfZQGwRAT2JCdPfgdlC
	Au4Sk1+eApvELOAncXnnSiYQm01AV2JRTzOYzStgL3Fg9Rowm0VAVeLWn8dgtqhAiMS2mw1s
	EDWCEidnPgHbxSngIdH05A4LxEx1iT/zLjFD2PIS29/OYZ7AyD8LScssJGWzkJQtYGRexSiX
	mFOaq5ubmJlTnJqsW5ycmJeXWqRrqpebWaKXmlK6iRESnoI7GGeclDvEKMDBqMTD65G5OlyI
	NbGsuDL3EKMkB5OSKK9wDFCILyk/pTIjsTgjvqg0J7X4EKMEB7OSCG+J1ZpwId6UxMqq1KJ8
	mJQ0B4uSOC/fEnU/IYH0xJLU7NTUgtQimKwMB4eSBG+dNVCjYFFqempFWmZOCUKaiYMTZDgP
	0PCTIDW8xQWJucWZ6RD5U4y6HAt+3F7LJMSSl5+XKiXOewfkAgGQoozSPLg5sLTyilEc6C1h
	3v8go3iAKQlu0iugJUxAS06YgS0pSURISTUwJly1PG4bMHXubuf3SSZ2AVW1gexvHWIE2vk+
	BDT3Xp4VfYXBYXFqQGXcuxW3wn5NFSlqd1H/3lcsckA56bjVGyXDjHSOaVpuytKOOo5Gpfr3
	nzQsCRSd63s58+CPdVNEbMpWmadfCz618xvn4p7vS3XeaxWJTzhopP3JY4/iT+/v278fSHJQ
	YinOSDTUYi4qTgQAODWMMQYDAAA=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/05/2016 10:57 PM, Ramsay Jones wrote:
> If you need to re-roll your 'mh/diff-indent-heuristic' branch, could
> you please squash this into the relevant patch (e199b6e2, "diff: improve
> positioning of add/delete blocks in diffs", 04-08-2016).

Will do. Thanks, Ramsay!

Michael


