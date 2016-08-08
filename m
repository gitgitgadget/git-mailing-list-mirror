Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 814D22018E
	for <e@80x24.org>; Mon,  8 Aug 2016 18:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbcHHSYb (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 14:24:31 -0400
Received: from mout.web.de ([212.227.15.4]:62044 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143AbcHHSYa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 14:24:30 -0400
Received: from macce.local ([79.223.103.9]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0Lwq0e-1b8Soc1S2K-016LRH; Mon, 08 Aug 2016 20:24:26
 +0200
Subject: Re: t0027 racy?
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <alpine.DEB.2.20.1608081556280.5786@virtualbox>
Cc:	git@vger.kernel.org
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <05fafffb-1065-d240-51dc-a0872fd83c48@web.de>
Date:	Mon, 8 Aug 2016 20:24:21 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1608081556280.5786@virtualbox>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:G4JbD3r60I9PNHM9PdryTsPDxJEzkyJkHYaZTOOOl8/9h5Feq0e
 lT6qLKAt6YF/uBvxTXATueEcyf+D/3dBjBugcXIuHrYAwqmroQlaaG/gRJovG1Zf67GS0GB
 AXAyX8awfOQ4tP3IINah0kneYIQym6SFXCR2I3GUpPRo9YU7h/jCWBNQZI35QAfJIpHFg5f
 yqEUPy8qK4aQ1Thw2ozPQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:BTpEd9CRCh4=:b4qvnqCAodAbHwUPNCUfMd
 alpqKOYqjwWO40CCIm+4kpcU/nSSxvzeJv/no5jllagmnnCIHP/1bsOenre6+3OOvaHKUpDFb
 xASVM+da+QmnETFlpGYbYNtb8EUPrQvOAPxo/J8nb739vyaNJ/pnvfXuyn9CgiQP0p+Uykos9
 QVC+kAu9n05MGF2IRHN/KUb1807bOWXGq0kH7hE8Nj2Xgm0g7/gBoFK9IBigU1D15W/TgOB/g
 PQG/QXLm4owJBxBrR9+NtVkpYnx1A47z+8dt6NAm2eTkrHA4oiJhQiZqed04hq2g8a+bPw6VB
 lZv3+UgVJ8LaXQvgilI/hW8FlV8530lmiDmDdASQ52EQz9zHS4/ivtKGaJfKEa+RGKSQGEanJ
 tvHhNkieGbYg7uem7j9zWZXKlLUeMfmgfResKTG4D3uOIEkpeAwDRn/r9b0gIvmI4k5ljJ6vz
 bsEis2VNGFAds7vog8Nd1XiOT+utDn7V8GxdM3imx2uB1nQ58DBOMW4tzOuOHtEFRvm3zJlvJ
 fawxb55sBrc0SfgRDKzxV51QC7aGcWJW8u8i8VHpMmMeGUmCaGAWjHaVey23AzEP21CXsWHaV
 HRhlRdowxrQEWRmZfi1KYCdkaFRUO2vxG+nJHGwmQbW9+7EiKXLqr1ElKeTTf2xls+1BzYQg/
 BjjJhh8dNPPo8ms1VeoeS7zs6u9vF61BavlZM3bE+82xCEHRmwE0NfLQF8PlTWLPnW3deFXAq
 Yg9adxwx1qX6A/vzNp7EXOM4dGD/EUiXeXcjYUDG3oKcNtIKWu/PCX5Ud9RN61IMqObPNsptX
 +HXjBpw
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016-08-08 17.05, Johannes Schindelin wrote:
> Hi Torsten,
> 
> I remember that you did a ton of work on t0027. Now I see problems, and
> not only that the entire script now takes a whopping 4 minutes 20 seconds
> to run on my high-end Windows machine.
> 
> It appears that t0027 fails randomly for me, in seemingly random places.
> Sometimes all 1388 cases pass. Sometimes "29 - commit NNO files crlf=true
> attr=auto LF" fails. Sometimes it is "24 - commit NNO files crlf=false
> attr=auto LF". Sometimes it is "114 - commit NNO files crlf=false
> attr=auto LF", and sometimes "111 - commit NNO files attr=auto aeol=lf
> crlf=false CRLF_mix_LF".
> 
> When I run it with -i -v -x --tee, it passes every single time (taking
> over 5 minutes, just to make things worse)...
> 
> Any idea about any possible races?
Just to double-check: I assume that you have this
commit ded2444ad8ab8128cae2b91b8efa57ea2dd8c7a5
Author: Torsten Bögershausen <tboegi@web.de>
Date:   Mon Apr 25 18:56:27 2016 +0200

    t0027: make commit_chk_wrnNNO() reliable
in your tree ?


Is there a special pattern ?
Did you
a) Update the machine ?
b) Update Git code base ?
or both ?
(Yes, I know that this may be stupid questions)

Is it only the NNO tests that fail ?
Did they ever pass ?
(I think I run them some time ago on a Virtual machine running Windows 7)

I see only "commit NNO files...." in you report, they belong to
check_warning(), which is called around line 126 in t0027.


check_warning() does a grep on a file which has been re-directed from stderr.

How reproducible is the problem ?
If you add
exit 0
After the last "commit_chk_wrnNNO" line (line 418),
does
ls -l crlf*.err
give you any hint ?




