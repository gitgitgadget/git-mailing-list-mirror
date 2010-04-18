Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=2.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INVALID_MSGID,MSGID_NOFQDN1,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 7926 invoked by uid 107); 18 Apr 2010 21:52:26 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 18 Apr 2010 17:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640Ab0DRVwQ (ORCPT <rfc822;peff@peff.net>);
	Sun, 18 Apr 2010 17:52:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:55946 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753511Ab0DRVwP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 17:52:15 -0400
Received: (qmail invoked by alias); 18 Apr 2010 21:52:13 -0000
Received: from dinoc9.indmath.uni-linz.ac.at (EHLO localhost) [140.78.117.79]
  by mail.gmx.net (mp036) with SMTP; 18 Apr 2010 23:52:13 +0200
X-Authenticated: #25381063
X-Provags-ID: V01U2FsdGVkX1+L7JN2EIiLOHPel0rHqF9vxafGHxIPSCCkWJjybp
	cKWyburL6IO7B7
Date:	Sun, 18 Apr 2010 23:52:10 +0200
From:	Konrad Karl <kk_konrad@gmx.at>
To:	git@vger.kernel.org
Subject: Re: git gui blame: git-blame loops at 100% cpu
Message-ID: <20100418215210.GA19776localhost>
References: <20100417231327.162560@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100417231327.162560@gmx.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64000000000000001
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Replying to myself

> Everything seems to be working fine but git gui blame some_file seems to
> procedure correct output in the file viewer but the progress bar stops 
> at 1271 of 2783 lines for one specific file and then the git-blame process
> consumes 100% cpu. 

Grr, this was a false alarm. It finishes after about 4 Minutes and I
did not wait that long. git gui was using git-blame -C -C40.

gui.fastcopyblame=true seems to help to get sane runtimes.
(this can be achieved by checkin "Blame Copy Only On Changed Files"
 in git gui options dialog -kudos to charon in #git for this suggestion)

Perhaps this should be made the default?

Konrad
