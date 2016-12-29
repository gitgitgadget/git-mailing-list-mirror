Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54FE41FCA5
	for <e@80x24.org>; Thu, 29 Dec 2016 15:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752917AbcL2Pti (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 10:49:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752881AbcL2Pth (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 10:49:37 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3025461BAA;
        Thu, 29 Dec 2016 15:49:37 +0000 (UTC)
Received: from localhost (ovpn-116-25.gru2.redhat.com [10.97.116.25])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uBTFnZfF029913;
        Thu, 29 Dec 2016 10:49:36 -0500
Date:   Thu, 29 Dec 2016 13:49:31 -0200
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>,
        Stefan Beller <sbeller@google.com>, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v3] am: add am.signoff add config variable
Message-ID: <20161229154931.GI3441@thinpad.lan.raisama.net>
References: <20161228225544.16388-1-ehabkost@redhat.com>
 <m2wpejb1zn.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2wpejb1zn.fsf@linux-m68k.org>
X-Fnord: you can see the fnord
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 29 Dec 2016 15:49:37 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 29, 2016 at 08:58:36AM +0100, Andreas Schwab wrote:
> On Dez 28 2016, Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > @@ -32,10 +32,12 @@ OPTIONS
> >  	If you supply directories, they will be treated as Maildirs.
> >  
> >  -s::
> > ---signoff::
> > +--[no-]-signoff::
> 
> That's one dash too much.

Oops. I can fix it in v4, but I will first wait to see what
others think about the legal implications of setting it by
default (see point raised by Eric Wong on v1).

-- 
Eduardo
