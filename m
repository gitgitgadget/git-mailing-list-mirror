Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2B211F71B
	for <e@80x24.org>; Fri, 29 Jul 2016 10:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbcG2KKd (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 06:10:33 -0400
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:53292 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbcG2KKb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 06:10:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 7E8004614C7;
	Fri, 29 Jul 2016 11:10:29 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id phDIZoLL8IjI; Fri, 29 Jul 2016 11:10:25 +0100 (BST)
Received: from salo (82-70-136-246.dsl.in-addr.zen.co.uk [82.70.136.246])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 4A6C3460A34;
	Fri, 29 Jul 2016 11:10:25 +0100 (BST)
Date:	Fri, 29 Jul 2016 11:10:11 +0100
From:	Richard Ipsum <richard.ipsum@codethink.co.uk>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	git@vger.kernel.org, linux-kernel@vger.kernel.org,
	dborowitz@google.com
Subject: Re: [ANNOUNCE] git-series: track changes to a patch series over time
Message-ID: <20160729101011.GA3469@salo>
References: <20160729064055.GB25331@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160729064055.GB25331@x>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 11:40:55PM -0700, Josh Triplett wrote:
[snip]
> 
> I'd welcome any feedback, whether on the interface and workflow, the
> internals and collaboration, ideas on presenting diffs of patch series,
> or anything else.
> 

This looks awesome!

I've been working on some similar stuff for a while also.[1][2]

I'm particularly interested in trying to establish a standard for
storing review data in git. I've got a prototype for doing that[3],
and an example tool that uses it[4]. The tool is still incomplete/buggy though.

There seem to be a number of us trying to solve this in our different ways,
it would be great to coordinate our efforts.

The prototype library I have is partly the result of some discussion and work
with the Gerrit folks, since they were thinking about this problem
before I even started writing git-candidate, and solved it with Notedb.[5]

Let me know if you'd like to work together on this,
I've been considering taking the perl-notedb prototype and writing
a C library for it with bindings for other languages (i.e. Rust).

[1]: http://www.mail-archive.com/git%40vger.kernel.org/msg79461.html
[2]: http://www.mail-archive.com/git%40vger.kernel.org/msg80972.html

[3]: https://bitbucket.org/richardipsum/perl-notedb
[4]: https://bitbucket.org/richardipsum/git-candidate

[5]: https://storage.googleapis.com/gerrit-talks/summit/2015/NoteDB.pdf
