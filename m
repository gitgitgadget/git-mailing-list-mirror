Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4687F1FF40
	for <e@80x24.org>; Sat,  3 Dec 2016 16:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbcLCQxk (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Dec 2016 11:53:40 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:35720 "EHLO mx1.2b3w.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751549AbcLCQxj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2016 11:53:39 -0500
X-Greylist: delayed 616 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Dec 2016 11:53:12 EST
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
        by mx1.2b3w.ch (Postfix) with ESMTP id D07B8C3471;
        Sat,  3 Dec 2016 17:42:50 +0100 (CET)
Received: from mcmini.bolli (215-243-153-5.dyn.cable.fcom.ch [5.153.243.215])
        by mx1.2b3w.ch (Postfix) with ESMTPSA id A3D46C3458;
        Sat,  3 Dec 2016 17:42:50 +0100 (CET)
Subject: Re: [PATCH v3 1/3] update-unicode.sh: automatically download newer
 definition files
To:     Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>
References: <1480762392-28731-3-git-send-email-dev+git@drbeat.li>
 <1480771173-731-1-git-send-email-dev+git@drbeat.li>
 <20161203164049.GA31244@tb-raspi>
Cc:     git@vger.kernel.org
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <835c0328-e812-1cb7-c49e-714ff0e9ffb3@drbeat.li>
Date:   Sat, 3 Dec 2016 17:41:42 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161203164049.GA31244@tb-raspi>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03.12.16 17:40, Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= wrote:
> On Sat, Dec 03, 2016 at 02:19:31PM +0100, Beat Bolli wrote:
>> Checking just for the unicode data files' existence is not sufficient;
>> we should also download them if a newer version exists on the Unicode
>> consortium's servers. Option -N of wget does this nicely for us.
>>
>> Cc: Torsten B??gershausen <tboegi@web.de>
> 
> The V3 series makes perfect sense, thanks for cleaning up my mess.
Yeah, it took me three tries, too :-)

> (And can we remove the Cc: line, or replace with it Reviewed-by ?)
If you prefer, sure.

Do you have any other comments?

Beat
