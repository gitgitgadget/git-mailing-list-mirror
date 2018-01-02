Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E0BC1F404
	for <e@80x24.org>; Tue,  2 Jan 2018 01:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbeABB0X (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jan 2018 20:26:23 -0500
Received: from agora.rdrop.com ([199.26.172.34]:3737 "EHLO agora.rdrop.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751326AbeABB0X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jan 2018 20:26:23 -0500
X-Greylist: delayed 931 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jan 2018 20:26:20 EST
Received: from agora.rdrop.com (66@localhost [127.0.0.1])
        by agora.rdrop.com (8.13.1/8.12.7) with ESMTP id w021ATS0013951
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 1 Jan 2018 17:10:32 -0800 (PST)
        (envelope-from perryh@pluto.rain.com)
Received: (from uucp@localhost)
        by agora.rdrop.com (8.13.1/8.14.2/Submit) with UUCP id w021AS8X013950;
        Mon, 1 Jan 2018 17:10:28 -0800 (PST)
        (envelope-from perryh@pluto.rain.com)
Received: from fbsd81 by pluto.rain.com (4.1/SMI-4.1-pluto-M2060407)
        id AA00798; Mon, 1 Jan 18 16:32:23 PST
Date:   Mon, 01 Jan 2018 16:32:20 -0800
From:   perryh@pluto.rain.com (Perry Hutchison)
To:     l.s.r@web.de
Cc:     git@vger.kernel.org, mpsuzuki@hiroshima-u.ac.jp
Subject: Re: [PATCH] git-archive: accept --owner and --group like GNU tar
Message-Id: <5a4ad314.C6wihAr5rEC8jRkB%perryh@pluto.rain.com>
References: <20171229140535.10746-1-mpsuzuki@hiroshima-u.ac.jp>
 <81b882a5-0c35-f3c4-78e2-d3e36290fec1@web.de>
In-Reply-To: <81b882a5-0c35-f3c4-78e2-d3e36290fec1@web.de>
User-Agent: nail 11.25 7/29/05
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren?? Scharfe <l.s.r@web.de> wrote:
> Am 29.12.2017 um 15:05 schrieb suzuki toshiya:
> > The ownership of files created by git-archive is always
> > root:root. Add --owner and --group options which work
> > like the GNU tar equivalent to allow overriding these
> > defaults.
> ... the receiver would need to be root to set both IDs, or be a
> group member to set the group ID; I guess the latter is more common.

If the received files are owned by root:root as stated, I guess the
receiver must be running as root, no?
