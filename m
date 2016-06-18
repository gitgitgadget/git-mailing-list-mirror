Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91A3220179
	for <e@80x24.org>; Sat, 18 Jun 2016 03:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbcFRDaW (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 23:30:22 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54974 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134AbcFRDaV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 23:30:21 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A44D01FEAA;
	Sat, 18 Jun 2016 03:30:19 +0000 (UTC)
Date:	Sat, 18 Jun 2016 03:30:19 +0000
From:	Eric Wong <e@80x24.org>
To:	Leo Gaspard <leo@gaspard.io>
Cc:	git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Migrating away from SHA-1?
Message-ID: <20160618033019.GB11307@dcvr.yhbt.net>
References: <02b42587-3643-1c2e-c249-313ec96bcdca@gaspard.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02b42587-3643-1c2e-c249-313ec96bcdca@gaspard.io>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Leo Gaspard <leo@gaspard.io> wrote:
> First, sorry for not having this message threaded: I'm not subscribed to
> the list and haven't found a way to get a Message-Id from gmane.

Appending "/raw" to the gmane URL will get you the raw message
with full headers:

  article.gmane.org/gmane.comp.version-control.git/$NUMBER/raw

you can also use that article $NUMBER via NNTP on news.gmane.org

> So, my questions to the git team:

It is customary to Cc: all relevant parties involved with that
thread since they may not all be subscribed, either.

>  * Is there a consensus, that git should migrate away from SHA-1 before
> it gets a collision attack, because it would mean chosen-prefix
> collision isn't far away and people wouldn't have the time to upgrade?
>  * Is there a consensus, that Peter Anvin's amended transition plan is
> the way to go?
>  * If the two conditions above are fulfilled, has work started on it
> yet? (I guess as Brian Carlson had started his work 9 weeks ago and he
> was speaking about working on it on the week-end he should have finished
> it now, so excluding this)

AFAIK, brian is still working on it.  Last series on the matter
begins here:
http://mid.gmane.org/20160607005716.69222-2-sandals@crustytoothpaste.net
I'm just on the sidelines observing :)

>  * If the two first conditions are fulfilled, is there anything I could
> do to help this transition? (including helping Brian if his work hasn't
> actually ended yet)
