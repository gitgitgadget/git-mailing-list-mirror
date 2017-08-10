Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07C0D208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 13:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbdHJN1m (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 09:27:42 -0400
Received: from mout.web.de ([212.227.17.12]:64213 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751456AbdHJN1l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 09:27:41 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MCqkB-1dpS9A2QFf-009gz9; Thu, 10
 Aug 2017 15:27:31 +0200
Subject: Re: fatal: Out of memory, getdelim failed under NFS mounts
To:     Yaroslav Halchenko <yoh@onerussian.com>
References: <20170809173928.h2ylvg5tp2p5inem@hopa.kiewit.dartmouth.edu>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <8e307474-d180-6d98-2c6b-062f2181bd14@web.de>
Date:   Thu, 10 Aug 2017 15:27:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170809173928.h2ylvg5tp2p5inem@hopa.kiewit.dartmouth.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:i1OBOiTSLBmsj+DLHlVKZRIUdmu6sAT/gVVnNMRvYGozglqltcf
 /0fW3nDl+QyBHQUykmd0cI2xILrK/+6pu7d5+/cUYL91saljmXNKYEWrFAMpopRoq/+NfMC
 f6JKiN6bQyeRcZDlgUGdtm/1pHsq+26l7OqXL+7B7t+gF8ipWedspH+zIUMYVx7un+gF9d/
 T+ys8rlHfumZZlP8pvfAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ORGhikvQDhs=:EYhuE9JGhRT2ay2xK/Rlmw
 YpsPZ8HcISVtyHdaHbxu7mckakygojbJ9kW21SJH+L/FUGz6FzA6ZxG/X1r4BjWMfwoEUn8aQ
 zqaVaBdLHxpVf/hnai2wxEDDN4PSCc+/mp6CGTANdIR6h5OY1CoB8E83HEND+fCpij9itK90F
 PiU82GLPPw3PvCvEAcC7XCcl92g3hSMmYeIDnrgSc2XhBCHj7nQjaJApx8I2o2YS14y/BADnY
 dSvvEhkQLhx1lHfTK3SdmLmWl3aUOfa8Qp5xNeOJySMw3HnYR/ApIGpum/QsIDL1PQ20E3dMB
 2/IDxCKfseRoWxu20IAdcq3mSYM3YMrmfYP5i96cEK2Xko3ZlSJ3uWra7B+zXFi6AYmUSIqQI
 2NdGYpVwpliFyKIPBsXKUVGoVRAP/iG+yZMFCJvxax9d7ejSlw5EkPo74GoVjxjPsreFRnpbR
 rp6tk/rlGrYI2czckP7dCD7tQACd94VZBQUAdO4YM4bI2LvlkoIqS3gzM/lBL82VLBwO5d8Bq
 CkdhrzqWRbzx+F0ocggvzqCKKcOsLBKkloDaS6DlUaU9e5mUJU6jwJ4lJlpgzeHPBppo8ij8i
 0fK9a7knnmCz7cSkOSlPI37XdTGa0DCGGlEPDT2ktu3YHlyu+s6Mv6YJyYou6w+fX2RdeMekk
 Yzr5HV42cu0EMd15WXCs8GXf0BBWu9xOdG03//ClEcV5E74IG98xSn/q8E1Fz9QrvRKvy7esz
 O1GwSSzvLfHQXLgkqm05Z4QgwGVA/6TD1zs30fyk6Pv570btGQDz/nv85byKBepNypz0aYUBd
 bQPA9utKRBYTA1DAJlFupj/7RNE5DZcuvB914XkLNJiWlshiHE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.08.2017 um 19:39 schrieb Yaroslav Halchenko:
> More context (may be different issue(s)) could be found at
> http://git-annex.branchable.com/forum/git-annex_add_out_of_memory_error/
> but currently I am consistently reproducing it while running
> git (1:2.11.0-3 debian stretch build) within debian stretch singularity
> environment [1].
> 
> External system is Centos 6.9, and git 1.7.1 (and installed in modules
> 2.0.4) do not show similar buggy behavior.
> 
> NFS mounted partitions are bind mounted inside the sinularity space and
> when I try to do some git operations, I get that error inconsistently , e.g.
> 
> 	yhalchen@discovery:/mnt/scratch/yoh/datalad$ git pull --ff-only origin master
> 	fatal: Out of memory, getdelim failed
> 	error: git://github.com/datalad/datalad did not send all necessary objects
> 
> 	yhalchen@discovery:/mnt/scratch/yoh/datalad$ git pull --ff-only origin master
> 	fatal: Out of memory, getdelim failed
> 	error: git://github.com/datalad/datalad did not send all necessary objects
> 
> 	yhalchen@discovery:/mnt/scratch/yoh/datalad$ git pull --ff-only origin master
> 	From git://github.com/datalad/datalad
> 	 * branch              master     -> FETCH_HEAD
> 	fatal: Out of memory, getdelim failed
> 
> and some times it succeeds.  So it smells that some race condition
> somewhere...?

I doubt the type of file system matters.  The questions are: How much
main memory do you have, what is git trying to cram into it, is there
a way to reduce the memory footprint or do you need to add more RAM?

> any recommendations on how to pin point the "offender"? ;)
Running "GIT_TRACE=1 git pull --ff-only origin master" would be a
good start, I think, to find out which of the different activities
that pull is doing causes the out-of-memory error.

"free" and "ulimit -a" can help you find out how much memory you can
use.

Also: What does "wc -L .git/FETCH_HEAD .git/packed-refs" report?
getdelim() is used mostly to read lines from files like these and in
the admittedly unlikely case that they are *really* long such an
error would be expected.

René
