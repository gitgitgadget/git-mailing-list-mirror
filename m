Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F95820441
	for <e@80x24.org>; Wed, 28 Dec 2016 19:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbcL1TMD (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 14:12:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751676AbcL1TMC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 14:12:02 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83DACC0092AF;
        Wed, 28 Dec 2016 19:12:02 +0000 (UTC)
Received: from localhost (ovpn-116-29.gru2.redhat.com [10.97.116.29])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uBSJC1c2006435;
        Wed, 28 Dec 2016 14:12:02 -0500
Date:   Wed, 28 Dec 2016 17:12:00 -0200
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] am: add am.signoff add config variable
Message-ID: <20161228191200.GG3441@thinpad.lan.raisama.net>
References: <20161228183501.15068-1-ehabkost@redhat.com>
 <871swrg9dh.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871swrg9dh.fsf@linux-m68k.org>
X-Fnord: you can see the fnord
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 28 Dec 2016 19:12:02 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 28, 2016 at 08:07:54PM +0100, Andreas Schwab wrote:
> On Dez 28 2016, Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> > index 12879e402..f22f10d40 100644
> > --- a/Documentation/git-am.txt
> > +++ b/Documentation/git-am.txt
> > @@ -9,7 +9,7 @@ git-am - Apply a series of patches from a mailbox
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git am' [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8]
> > +'git am' [--[no-]signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8]
> >  	 [--[no-]3way] [--interactive] [--committer-date-is-author-date]
> >  	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
> >  	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
> > @@ -32,10 +32,12 @@ OPTIONS
> >  	If you supply directories, they will be treated as Maildirs.
> >  
> >  -s::
> > ---signoff::
> > +--[no]-signoff::
> 
> That should be --[no-]signoff, as in the synopsis.

Thanks for catching it. I will fix it in v3.

-- 
Eduardo
