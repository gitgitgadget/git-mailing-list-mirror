Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BBE0203E1
	for <e@80x24.org>; Sun, 24 Jul 2016 19:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbcGXTIH (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 15:08:07 -0400
Received: from alerce.vps.bitfolk.com ([85.119.82.134]:33531 "EHLO
	alerce.vps.bitfolk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbcGXTIF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 15:08:05 -0400
X-Greylist: delayed 984 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Jul 2016 15:08:05 EDT
Received: from 87-198-58-88.ptr.magnet.ie ([87.198.58.88] helo=sdfg.com.ar)
	by alerce.vps.bitfolk.com with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.82)
	(envelope-from <rodrigo@sdfg.com.ar>)
	id 1bROV0-0004cg-T0; Sun, 24 Jul 2016 15:51:38 -0300
Date:	Sun, 24 Jul 2016 19:51:32 +0100
From:	Rodrigo Campos <rodrigo@sdfg.com.ar>
To:	Jon Forrest <nobozo@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [RFC] A Change to Commit IDs Too Ridiculous to Consider?
Message-ID: <20160724185132.GN25141@sdfg.com.ar>
References: <nn30dv$5sn$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nn30dv$5sn$1@ger.gmane.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 24, 2016 at 11:12:12AM -0700, Jon Forrest wrote:
> 
> Those of us who write instructional material about Git all face the same problem.
> This is that we can't write step by step instructions that show the results of
> making a commit because users will always see different commit IDs.
> This is fundamental to the design of Git.
> 
> Even if the instructional material tells users to use standard author and committer
> information, (e.g. john.doe@example.com) and shows the text of the file being committed
> and the commit message to add, the resulting commit ID will differ from reader to reader
> since the commit will presumably take place at different times.

And what is the problem with that, if you are doing it with instructional
purposes? Let's assume that this helps and not confuses later when the commits
*do* change. What is the problem you face?

I mean, for some examples you can use HEAD, HEAD^, HEAD~4, etc. and that always
works, no matter the commit id. In which cases do you want/need the commit ids
to be equal? Can you be more specific?




Thanks a lot,
Rodrigo
