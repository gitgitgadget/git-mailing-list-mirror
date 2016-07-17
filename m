Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B97C20195
	for <e@80x24.org>; Sun, 17 Jul 2016 08:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbcGQICF (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 04:02:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:61239 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184AbcGQICC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 04:02:02 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M9Jss-1bVnkj2oMY-00ClPK; Sun, 17 Jul 2016 10:01:39
 +0200
Date:	Sun, 17 Jul 2016 10:01:38 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	"brian m. carlson" <sandals@crustytoothpaste.net>
cc:	Herczeg Zsolt <zsolt94@gmail.com>, git@vger.kernel.org
Subject: Re: Git and SHA-1 security (again)
In-Reply-To: <20160716201313.GA298717@vauxhall.crustytoothpaste.net>
Message-ID: <alpine.DEB.2.20.1607170949360.28832@virtualbox>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com> <20160716201313.GA298717@vauxhall.crustytoothpaste.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yJzsAzWu841uIXCsqAY+KLNjTqXBsigLsDmBZc6Yq4UJVZgSW6A
 5yBRWfROeOep8Ve9+gsqe6qe7E/TE7oRjK0O4ILHQg6gl1Y7Rq1mJ9bgQ4FQFhiy56bi0oi
 llSlwDl98sL3gaqzlTjDFVvxSy5gkY1opSkFMZ4JaVu0plog4oElaqoArKLZRI3rpcXuMvr
 5s1Vja4UZPm0BBEAeRAuA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:6QUZRX6c+4c=:eMmQmyPUblw4tmbi1DYkYx
 MTN3tnA3xCpy/dBGs8k9RNuyYrMo515ZrhnCMkA/d65s34177T80Vh0+RdjAoMNfHIi97fsXl
 IOR/SYueRAIdmcZjyHLDq+IBXpTonwS3W+zHin6CjogAL/t8Dukac9m3uSYV1a5eUqxP/wBl2
 DwQRhgRmm9l2FsT1pksBMcPk2LSRNlLAYKX9A1IgavG95yonjIazjujPfBF+p/bImveuGwJVA
 vDHB+6btf3xte+Xmjyw8+ge8GX1wf7bpD5nn/qfcOK1vWisaz3qhfSepYvBjovOEpeHbrEYPr
 qs/yeC6AcU5cqvIpfMFIxgBK2H25tixHT4jSKH3PmpEi/1jSbbt84tFoZ/kUadMtdVuabWlXo
 vZUB9oS9tkDGyc3duz0pjQbsXAMp5jBPuYxjY2FAXlIsNNFemll6i0wO/ypdpDRmphfbmSfJZ
 6Oqa8dYKmL29MtGFE5z2uwl8Y6KrYGN2W1NQgDFCLZCCTB5prEt6pzupqgddzGog0JXwBg9ru
 jMO2ROuUHpiuNOz46DGNsfTlu8WRbXoQ/1PbM5jlK56GDLbe+UzIutLb7Y1AKUeXb0tQ16Tu/
 3ouMh3EMlK4afPV/1of0YnvtSaJ2/OvXxc/OXi53/2IbVz8jkoMX7m02uSWp5QYq5vZKrvbRS
 g5zkyI3ORwClUfb+nKZhsTrQGzbKs13UMN2awusGdZHDISesEiAdyJApFNUilW20kKPi/Up5A
 b6Gt3u3AlsEps6ZgGaOQaTMrQB6HyNTpB1eu3HWe9ZII+gjzkdGh1HVkuxhl8/OSULEon3JmT
 8w6rW9o
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Brian,

On Sat, 16 Jul 2016, brian m. carlson wrote:

> My current plan is not to implement side-by-side data, for a couple
> reasons.

I am as guilty as the next person to have use the "deafbee(This is my
commit, 2007-08-21)" format to refer to older commits. So I do have
concerns about rewriting history when switching to a new hash.

I understand the technical challenges, of course.

Out of curiosity: have you considered something like padding the SHA-1s
with, say 0xa1, to the size of the new hash and using that padding to
distinguish between old vs new hash?

I guess that it would also possible to introduce an opt-in "legacy mapper"
which would generate a mapping locally of all objects' SHA-1 to whatever
new hash you choose. Generating it locally would side-step the security
issues of the SHA-1 algorithm. We would need to teach Git to pick that
mapping up if available and use it, of course.

However, that latter solution would do nothing to address the problem of
existing GPG-signed commits.

Ciao,
Dscho
