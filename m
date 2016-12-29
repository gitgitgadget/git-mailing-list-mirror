Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEF191FCA5
	for <e@80x24.org>; Thu, 29 Dec 2016 22:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751001AbcL2WQI (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 17:16:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750874AbcL2WQI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 17:16:08 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 176EC7F0A3;
        Thu, 29 Dec 2016 22:16:08 +0000 (UTC)
Received: from localhost (ovpn-116-4.gru2.redhat.com [10.97.116.4])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uBTMG6d7011548;
        Thu, 29 Dec 2016 17:16:07 -0500
Date:   Thu, 29 Dec 2016 20:16:05 -0200
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH] am: add am.signoff add config variable
Message-ID: <20161229221605.GJ3441@thinpad.lan.raisama.net>
References: <1482946838-28779-1-git-send-email-ehabkost@redhat.com>
 <20161229084701.GA3643@starla>
 <xmqqtw9m5s5m.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtw9m5s5m.fsf@gitster.mtv.corp.google.com>
X-Fnord: you can see the fnord
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 29 Dec 2016 22:16:08 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 29, 2016 at 01:42:13PM -0800, Junio C Hamano wrote:
> Eric Wong <e@80x24.org> writes:
> 
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >> git-am has options to enable --message-id and --3way by default,
> >> but no option to enable --signoff by default. Add a "am.signoff"
> >> config option.
> >
> > I'm not sure this is a good idea.  IANAL, but a sign-off
> > has some sort of legal meaning for this project (DCO)
> > and that would be better decided on a patch-by-patch basis
> > rather than a blanket statement.
> 
> IANAL either, but we have been striving to keep output of
> 
>    $ git grep '\.signoff' Documentation
> 
> empty to keep Sign-off meaningful. 
> 
> Adding more publicized ways to add SoB without thinking will make it
> harder to argue against one who tells the court "that log message
> ends with a SoB by person X but it is very plausible that it was
> done by inertia without person X really intending to certify what
> DCO says, and the SoB is meaningless".

This sounds completely reasonable to me. I now see that the
config option was already proposed in 2011 and the same arguments
were discussed. Sorry for the noise.

> 
> > I don't add my SoB to patches (either my own or received) until
> > I'm comfortable with it; and I'd rather err on the side of
> > forgetting and being prodded to resubmit rather than putting
> > an SoB on the wrong patch.
> 

-- 
Eduardo
