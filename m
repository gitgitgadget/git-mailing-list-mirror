Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95B9F209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 21:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751444AbdFFVDa (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 17:03:30 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:50936 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751390AbdFFVD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 17:03:29 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.89)
        (envelope-from <mh@glandium.org>)
        id 1dILdG-0005ZN-Hp; Wed, 07 Jun 2017 06:03:18 +0900
Date:   Wed, 7 Jun 2017 06:03:18 +0900
From:   Mike Hommey <mh@glandium.org>
To:     rajdeep mondal <justrajdeep@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Subject: Re: Feature request: Please add support to stash specific files
Message-ID: <20170606210318.e2ey4pwxhxsuvizi@glandium.org>
References: <CACkx65CDzw64wsQ_t3YJUm_UP27fBf50n4r7mcMe1wZPW0TSjg@mail.gmail.com>
 <002801d2dec9$2cd49dd0$867dd970$@nexbridge.com>
 <CACkx65CRfZ-Se6oPzy6fHtC7R19UWc-EDopudHQY3JiwV-hAAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACkx65CRfZ-Se6oPzy6fHtC7R19UWc-EDopudHQY3JiwV-hAAw@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 06, 2017 at 02:38:08PM -0400, rajdeep mondal wrote:
> Hi Randall,
> 
> I completely agree to what you are saying, but sometimes it just so
> happens that in the middle of a change, i feel like if some portion of
> the changes are fine I can commit them.  Stashing some of the files
> and being able to check the compile/tests at this point would be a
> really awesome change.
> 
> Stash supports a -p option to deal with this, it becomes cumbersome
> when the number of files are many.  Maybe it is something which would
> be a good to have feature. People need not use it if they dont want
> to.

Git 2.13.0 has that already.

git stash -- file1 file2

Mike
