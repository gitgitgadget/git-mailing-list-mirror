Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD81D1FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 12:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752579AbdJ3MUp convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 30 Oct 2017 08:20:45 -0400
Received: from marcos.anarc.at ([206.248.172.91]:42808 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752252AbdJ3MUp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 08:20:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id 7D2921A00AA
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] WIP: git-remote-media wiki namespace support
In-Reply-To: <q7h98tfszzp5.fsf@orange.lip.ens-lyon.fr>
Organization: Debian
References: <20171029160857.29460-1-anarcat@debian.org> <q7h98tfszzp5.fsf@orange.lip.ens-lyon.fr>
Date:   Mon, 30 Oct 2017 08:20:44 -0400
Message-ID: <87po947roj.fsf@curie.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-10-30 11:40:06, Matthieu Moy wrote:
> Antoine Beaupré <anarcat@debian.org> writes:
>
>> Obviously, doing unit tests against a full MediaWiki instance isn't
>> exactly trivial.
>
> Not trivial, but doable: there is all the infrastructure to do so in t/:
> install-wiki.sh to automatically install Mediawiki, and then a testsuite
> that interacts with it.
>
> This has been written under the assumption that the developer had a
> lighttpd instance running on localhost, but this can probably be adapted
> to run on Travis-CI (install lighttpd & Mediawiki in the install: part,
> and run the tests afterwards), so that anyone can run the tests by just
> submitting a pull-request to Git-Mediawiki.
>
> If you are to work more on Git-Mediawiki, don't underestimate the
> usefullness of the testsuite (for example, Git-Mediawiki was developped
> against a prehistoric version of Mediawiki, the testsuite can help
> ensuring it still works on the lastest version), nor the fun of playing
> with install scripts and CI systems ;-).

Hello!

Glad to hear from you. :)

So I actually tried install-wiki.sh, and it "failed to start lighttpd"
and told me to see logs. I couldn't find them and stopped there...

It would be great to hook this up into CI somewhere, but I suspect it
isn't considering how it doesn't actually work out of the box.

I'm hoping we can still do things and fix some things without going
through that trouble, but I recognize it would be better to have unit
tests operational.

Honestly, I would prefer just having this thing work and not have to
work on it. :) I have lots of things on my plate and I'm just scratching
an itch on this one - some backup script broke and I am trying to fix
it. Once it works, my work is done, so unfortunately I cannot lead that
project (but I'd be happy to help when I can of course).

A.

-- 
The greatest tragedy in mankind's entire history may be the hijacking of
morality by religion.
                        - Arthur C. Clarke
