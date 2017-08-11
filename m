Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E0A920899
	for <e@80x24.org>; Fri, 11 Aug 2017 17:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753584AbdHKRYd (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 13:24:33 -0400
Received: from smtprelay06.ispgateway.de ([80.67.18.29]:12885 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753577AbdHKRYc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 13:24:32 -0400
Received: from [46.91.38.38] (helo=book.hvoigt.net)
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1dgDHi-0001eP-Bv; Fri, 11 Aug 2017 18:59:42 +0200
Date:   Fri, 11 Aug 2017 18:59:40 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2 02/15] submodule: don't use submodule_from_name
Message-ID: <20170811165940.GB1472@book.hvoigt.net>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170803182000.179328-1-bmwill@google.com>
 <20170803182000.179328-3-bmwill@google.com>
 <CAGZ79kaZcpZ-6+=19CbW1v+h-njguXZH9z9GMYA3Ci=acfreKQ@mail.gmail.com>
 <20170804215311.GB126093@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170804215311.GB126093@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 04, 2017 at 02:53:11PM -0700, Brandon Williams wrote:
> On 08/03, Stefan Beller wrote:
> > On Thu, Aug 3, 2017 at 11:19 AM, Brandon Williams <bmwill@google.com> wrote:
> > > The function 'submodule_from_name()' is being used incorrectly here as a
> > > submodule path is being used instead of a submodule name.  Since the
> > > correct function to use with a path to a submodule is already being used
> > > ('submodule_from_path()') let's remove the call to
> > > 'submodule_from_name()'.
> > >
> > > Signed-off-by: Brandon Williams <bmwill@google.com>
> > 
> > In case a reroll is needed, you could incorperate Jens feedback
> > stating that 851e18c385 should have done it.
> 
> K I'll add that into the commit message.

Well, thats not 100% correct... IMO, it should have been a follow up patch
which I never got to implement. See my other reply to the v1 of this
patch I just sent out.

As stated there I will have a look into where it makes sense to pass a
commit id and behave more correctly.

Cheers Heiko
