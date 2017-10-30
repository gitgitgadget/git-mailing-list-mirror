Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDDF9202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 03:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751580AbdJ3DAq (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 23:00:46 -0400
Received: from marcos.anarc.at ([206.248.172.91]:60950 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750929AbdJ3DAq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 23:00:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id B132A1A00AA
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     git@vger.kernel.org
Subject: future of the mediawiki extension?
Date:   Sun, 29 Oct 2017 23:00:44 -0400
Message-ID: <87vaix731f.fsf@curie.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

First thanks for the excellent feedback regarding the mediawiki
extension, it's great that obscure extensions like this see such
excellent reviews.

I think, however, it would be good to have a discussion about the future
of that extension in Git. The extension has a bit of a hybrid presence -
it is partly in git core (as a contrib, but still) and partly on GitHub
here:

https://github.com/Git-Mediawiki/Git-Mediawiki/

This leads to some confusion as to where the changes should be
made. Some people make changes straight on GitHub by forking the above
repo, others fork the Git repo, and very few actually send the patches
here, on this mailing list.

There was a discussion last year about moving the module out of git core
and onto its own repository again:

https://github.com/Git-Mediawiki/Git-Mediawiki/issues/34

There is also a discussion on releasing the code to CPAN:

https://github.com/Git-Mediawiki/Git-Mediawiki/issues/18

It should also be mentioned that this contrib isn't very active: I'm not
part of the GitHub organization, yet I'm probably the one that's been
the most active with patches in the last year (and I wasn't very active
at all). There's an issue on GitHub about this as well:

https://github.com/Git-Mediawiki/Git-Mediawiki/issues/33

So, what should be done about this contrib? Should it stay in Git core?
Or should it be punted back to the community and managed on GitHub?

Please avoid "mailing list vs GitHub" flamewars and keep to the topic of
this specific contrib's future. :)

Thanks!

A.

PS: personally, I don't care much either way. It certainly seem that I
get way better feedback here than I previously got on GitHub, but that
could be because of the hybrid way things are setup in the first
place...
-- 
To punish me for my contempt for authority, fate made me an authority myself.
                       - Albert Einstein
