Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E3C71F744
	for <e@80x24.org>; Tue, 19 Jul 2016 07:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbcGSHf6 (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 03:35:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:59714 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752548AbcGSHbw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 03:31:52 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MVJze-1brPPm0a3q-00YlKF; Tue, 19 Jul 2016 09:31:32
 +0200
Date:	Tue, 19 Jul 2016 09:31:31 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Duy Nguyen <pclouds@gmail.com>
cc:	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Herczeg Zsolt <zsolt94@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git and SHA-1 security (again)
In-Reply-To: <CACsJy8AH9Q6rOgvcWGsLGPaP96koGA=k0PYgXP6F3RZ=XAwaSw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607190926420.3472@virtualbox>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com> <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox> <20160717142157.GA6644@vauxhall.crustytoothpaste.net>
 <CACsJy8AH9Q6rOgvcWGsLGPaP96koGA=k0PYgXP6F3RZ=XAwaSw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sL8pMqYkW4yAFunMziveUzS5VEPblIZLkLkzhLp2A1ZhfuF8q4b
 oq1WlL7MBWO5Q1QSirMV0+F0q3qcvdD4k0uvMEZ3lXI9Dw9vbR866CFp7s1d0zFsvy083zF
 cA1j0kF7crnyJ/ItsfQDt65N0nBJLSQqyAvj4jL0hZ9LJBKZbwK3NqY+EGMzXaS5aYJ/8LE
 9zTAgEdsEcVFcmNtgH+bw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:LFgyGauCd8Y=:G/HTN6ww++5ymN28DnQE8P
 54drNSiJoot1aH0sN2lqUOTA16KWgzsAUTPWurZ+CabefZwoikd1lSKhcZ1xBsOnUIVqA2Cp4
 O4u6LFSf2B3YPb0cliO0SzJsgLrBj/1EPlhcV7IX5osdMynJavLode9xa7aBX8JFBxan431QB
 rKci9Uiegn13vhbWMnodZVbUYTIWYpyUoqvtkgYqeIePr4z6biC5MLzDaVaQP/laSZnFORspA
 hFkqowk5TE0UIoLJ17UhLVZLdePwDYXjNPjRHpCW8jzCD15kBFwBVKlLBONPM609sodZbAFMq
 nch2GiQhFpMxOWcFvkWYkxm+jof0hGp8G7vOc/ckmuoYc8zddyVzWvvhxOXfR7LbD2Kjo217b
 6PJGkkVZLbs1QMaNAMVWwrDJk5/VOP+uNJSLHA4csm5+7Us1NQAjw3/HF6nBV4CzRIAFYaK20
 JSkQstMNppoWg7+1G5OLcJdo/intM4ArfVIpG65A9ZEL53ytV/yBzr22QK9Wo2LBjCqtxVotU
 xE+F0d47Br06N52aMipCbelsMzw0XtIxivYsd5NM/j65QGAFl66sfoxao2MrPtInBK6+44Es0
 PeCvmJZOPjOXHcXtdT9vJJ6TN4pYj5tX/OYhJWth2B1/v06mhb+RapLLqi08GgWl4NWy9hckv
 rAt/ai0n0jw/qMw+Pdan7sT6KqvmpXFgRTelgNXjRaz4q049iCt6m9AgSydceLHRYKdvI0H7j
 AnuhjH0WA5VnWBvEUVAt01anZNQUFNac7HdKuH5bPYteuEcd7wjfOBoz0Gv2BHqd6AaDDwtC+
 wmjX6im
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Duy,

On Mon, 18 Jul 2016, Duy Nguyen wrote:

> On Sun, Jul 17, 2016 at 4:21 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > I'm going to end up having to do something similar because of the issue
> > of submodules.  Submodules may still be SHA-1, while the main repo may
> > be a newer hash.
> 
> Or even the other way around, main repo is one with sha1 while
> submodule is on sha256. I wonder if we should address this separately
> (and even in parallel with sha256 support), making submodules work
> with an any external VCS system (that supports some basic operations
> we define).

It is safe to assume that any project using a submodule with a more secure
hash would require Git tooling capable of said hash. It would hence make
no sense to use SHA-1 for the super project.

So I do not believe that we have to support the use case of a SHA-1-based
project using SHA-256-based submodules.

Ciao,
Dscho
