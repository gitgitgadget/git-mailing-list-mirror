Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16D0C1FC96
	for <e@80x24.org>; Sun,  4 Dec 2016 08:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbcLDIJr (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Dec 2016 03:09:47 -0500
Received: from mout.web.de ([212.227.15.3]:51548 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751888AbcLDIJq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2016 03:09:46 -0500
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M7ssy-1cZG6X1pXE-00vPG3; Sun, 04
 Dec 2016 09:09:17 +0100
Date:   Sun, 4 Dec 2016 08:09:14 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeff King <peff@peff.net>
Cc:     thomas.attwood@stfc.ac.uk, git@vger.kernel.org
Subject: Re: git 2.11.0 error when pushing to remote located on a windows
 share
Message-ID: <20161204080914.GB2415@tb-raspi>
References: <AABB04BF1441D24CB4E9FCF46394F17D666F34E1@exchmbx01>
 <20161202223749.2n7wa37e5w6446uv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161202223749.2n7wa37e5w6446uv@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:2oPWc7IF3gJwvHxWmFZm/oW8qukbZ5KrpQRgG3ovihY32AHhgXH
 22ce9siD7STo2xSfTRNdB/KyaS+96IG5YgAizdj5py65dhqZP7gsWpRRiphtCvZhnt396q8
 I2iINlNFKo63RiA7ob1b5HlqEKu7XyhirT5NhsOO/DOil5KAHhNEgk6b95nukBpMduSBnN8
 P9F1E2tdq6wtifLhTg+5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:t99/VDXTLts=:/guGgXf7OWBV0DaUEOStVm
 +rE/uZp/wpguA1fiAEHQD35q0VVI8GGr6gFD1eiOLX5kCb63T0nF+V0mSKX3PkqIaNhOTRNjw
 T7Imv0NM/96KFA5cInNwx5kwmZD3zSufGv7WHZ1rDSyZzJS4vKCtY3j0B6OPRP0WJP9Ipqlyd
 oYl6gRxef7s2d4XiXIQaPljUPzpH6x+/OVrOAAdWQw4dQtMclW5IJ3u+o8OCCEDRcAvbjni/8
 4rvKdilYoyr4yHvR0JrS/pxNwZxKH87i4wMGOPb1p1/oiBcuXUj12q0J2uSa1+DS9JS2+oWwY
 dEx3JrkSgbhDd4tvSBUlQe8CZWU1CqkcaY2+ASIXCsaYuyOPOxyuw3PFs8/0Rp8VM7qFWpuuL
 z/EoeSIInemXzt/26Rb44VyiSbq4lOHioyY1n6gZ7LTz+K6hTmbJNgpB5CpQMtN6sV+i2/ZWa
 hYxNnWAt/q1hARGdklD7b2n8BWfMCdLlNUc4ESKF6nedCsq9klz2Lmids3l9jCkfcUfzNRK0h
 D4TI8HlDSapeuF8CPCWwEZ9rYhgixOziFg7dJTVJMf9hjDT0DOoKbG+KBRgBOA29uMMdtKgus
 me49S5FpkFWSB3w1Zek1rPzb9ICuEA62ODLaoheoL+8GzfyqRbxywrlHWnI8QYvqT1LOK3pU7
 MsM/ctn1XpyIVOQOJmHHnbHKtb4E7l+CyGj9MFp4LEfPUAHIOpBjJnnVbicqZHBeY+NcyR+8E
 U8DKhxdevLVXp6UwDRJ4yxRq6OQRnAMRLwnTfq03pxLGUK6RJaT2Q8IsWO0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 02, 2016 at 05:37:50PM -0500, Jeff King wrote:
> On Fri, Dec 02, 2016 at 06:02:16PM +0000, thomas.attwood@stfc.ac.uk wrote:
> 
> > After updating git from 2.10.0 to 2.11.0 when trying to push any
> > changes to a repo located in a windows share, the following error
> > occurs:
> > 
> > $ git push origin test
> > Counting objects: 2, done.
> > Delta compression using up to 8 threads.
> > Compressing objects: 100% (2/2), done.
> > Writing objects: 100% (2/2), 284 bytes | 0 bytes/s, done.
> > Total 2 (delta 1), reused 1 (delta 0)
> > remote: error: object directory /path/to/dir/objects does not exist; check .git/objects/info/alternates.
> > remote: fatal: unresolved deltas left after unpacking
> > error: unpack failed: unpack-objects abnormal exit
> > To //path/to/dir
> >  ! [remote rejected] test -> test (unpacker error)
> > error: failed to push some refs to '//path/to/dir'
> 
> Hmm. This is probably related to the quarantine-push change in v2.11;
> the receiving end will write the objects into a temporary directory but
> point to the original via GIT_ALTERNATE_OBJECT_DIRECTORIES. That pointer
> isn't working for some reason, so the receiver can't resolve the deltas
> it needs.
> 
> As you noted, the extra "/" is missing in the error message, and that
> sounds like a plausible cause for what you're seeing. I'm not sure where
> the slash is getting dropped, though. The value in the environment comes
> from calling absolute_path(get_object_directory()), so I suspect the
> real problem is not in the quarantine code, but it's just triggering a
> latent bug elsewhere (either in absolute_path(), or in the code which
> generates the objdir path).
> 
> > No error occurs if pushing to the same repo (a direct copy into a local directory) using 2.11.0.
> > 
> > $ git push local_test test
> > Counting objects: 2, done.
> > Delta compression using up to 8 threads.
> > Compressing objects: 100% (2/2), done.
> > Writing objects: 100% (2/2), 284 bytes | 0 bytes/s, done.
> > Total 2 (delta 1), reused 1 (delta 0)
> > To C:/path/to/dir
> >  * [new branch]      test -> test
> 
> The fact that it works using the non-UNC path reinforces my feeling that
> something is normalizing the absolute path incorrectly.
> 
> > Using `git fsck --full` in both 2.11.0 and 2.10.0, it doesn't reveal any additional problems.
> 
> Yeah, I don't think there is anything wrong with your repo. It's just a
> path-building issue internal to the receiving process.
> 

There seems to be another issue, which may or may not being related:
https://github.com/git-for-windows/git/issues/979

This is pure speculation:
Could it be that a '/' is lost because of a change in the underlying
Msys2 between 2.10 and 2.11 ?

Dscho, (or anybody else) any ideas? 

