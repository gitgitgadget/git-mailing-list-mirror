Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 492AC1F424
	for <e@80x24.org>; Wed, 20 Dec 2017 12:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755232AbdLTMAM (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 07:00:12 -0500
Received: from quechua.inka.de ([193.197.184.2]:49868 "EHLO mail.inka.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755179AbdLTMAK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 07:00:10 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
        by mail.inka.de with uucp (rmailwrap 0.5) 
        id 1eRd2f-0001nx-3O; Wed, 20 Dec 2017 13:00:09 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
        id 63B78120195; Wed, 20 Dec 2017 12:52:13 +0100 (CET)
Date:   Wed, 20 Dec 2017 12:52:13 +0100
From:   Josef Wolf <jw@raven.inka.de>
To:     git@vger.kernel.org
Subject: Re: Need help migrating workflow from svn to git.
Message-ID: <20171220115213.GF18542@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <20171214130933.GA18542@raven.inka.de>
 <xmqqvah8q7cg.fsf@gitster.mtv.corp.google.com>
 <19d67f01-5e7d-3792-52f4-52da86bca5e5@gmail.com>
 <xmqq1sjvreoy.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1sjvreoy.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 15, 2017 at 11:09:17AM -0800, Junio C Hamano wrote:
> Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:
> 
> > Junio, what about consecutive runs, while merge conflicts are still 
> > unresolved?
> 
> The impression I got was that the original running with svn does not
> deal with conflicting situation anyway, so I did not think about it
> at all, and I personally do not care ;-)

Yeah. Conflicts are not a big deal for this project.

I guess, this would no longer hold true if there are lots of developers with
lots of commits. Thus, I'd still like to learn how to do it correctly.

Never doing local modifications in the "live" directories would require to
install test systems and simulate their environment just for doing some minor
adjustments.

-- 
Josef Wolf
jw@raven.inka.de
