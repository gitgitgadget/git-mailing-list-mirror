Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEF671F731
	for <e@80x24.org>; Fri,  2 Aug 2019 03:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfHBDI5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 23:08:57 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:54708 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbfHBDI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 23:08:57 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1htNuu-0005fn-3t; Fri, 02 Aug 2019 12:07:40 +0900
Date:   Fri, 2 Aug 2019 12:07:40 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Alexander Mills <alexander.d.mills@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: cannot clone --single-commit instead of --single-branch
Message-ID: <20190802030740.fr2kkpom5bvknksk@glandium.org>
References: <CA+KyZp6mYx4C22syAu=W2Okf7tDwtQ+7vVUBaQ-2D70PTS+GaA@mail.gmail.com>
 <CAGyf7-F2qs2=51hdA-1BB=12w7GiwaVZ974eYKFzu-=OKj8Q=g@mail.gmail.com>
 <20190802024322.GC54514@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802024322.GC54514@google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 01, 2019 at 07:43:22PM -0700, Jonathan Nieder wrote:
> Hi,
> 
> Bryan Turner wrote:
> 
> > Promisor remotes and other in-flight changes might help provide some
> > of what you're looking for, but I'm not aware of any already-available
> > solution.
> 
> You can do
> 
> 	git clone --no-checkout --filter=blob:none $url repo

TIL. Why doesn't --filter appear in the git-clone manual page?

Mike
