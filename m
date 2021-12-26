Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FB4C433EF
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 15:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhLZPt1 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 26 Dec 2021 10:49:27 -0500
Received: from elephants.elehost.com ([216.66.27.132]:58771 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhLZPt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 10:49:27 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1BQFnKPV027167
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 26 Dec 2021 10:49:20 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Lemuria'" <nekadek457@gmail.com>,
        "'Erik Cervin Edin'" <erik@cervined.in>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <71b51bc8-172f-48de-7c3f-cf55dc45b39a@gmail.com> <xmqqlf0cjuwx.fsf@gitster.g> <d51b7981-5034-b34c-42d6-ad8b80a378c1@gmail.com> <CA+JQ7M_GhE=vcpoCSPEnSPoLA1xZM3uVMuGw4goPe4AmQip2hg@mail.gmail.com> <f282b2eb-efd2-e194-d326-fe4daa07b598@gmail.com>
In-Reply-To: <f282b2eb-efd2-e194-d326-fe4daa07b598@gmail.com>
Subject: RE: Rebasing commits that have been pushed to remote
Date:   Sun, 26 Dec 2021 10:49:14 -0500
Organization: Nexbridge Inc.
Message-ID: <001801d7fa70$25775e20$70661a60$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGdv7KuYODUlkQnFclnQpM2ileC8AL0iejkAYmlOsgBR6REnQDLhFvErITUltA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 26, 2021 4:58 AM, Lemuria wrote:
> On 26/12/2021 4:44 pm, Erik Cervin Edin wrote:
> >> Alright. I'll take this into account. Unfortunately, before you got
> >> to me, I reworded the commits on my local and pushed them to the
> >> remote, which resulted in a messy history with duplicate comments.
> >
> > This easily happens
> > Usually when you merge old history back onto rewritten history It's
> > easy to confuse what is what when rewriting history
> >
> > If you find yourself rewriting and force pushing a lot you might find
> > the following script helpful
> > https://gist.github.com/CervEdin/2e72388c3f7d9b30d961ec3b64d08761
> > It shows:
> > - The graphs of differences between local and upstream of a branch
> > - The difference between local and upstream
> > - Prompts to force push with lease
> 
> I don't force push a lot, but regardless I'll make a note of that.

The process is used by some teams, like OpenSSL, for WIP pull requests. It follows a git rebase --autosquash -i. The principle is to clean up the PR down to a single final commit for approval. It is more work for the contributor, but the committers seem to prefer having everything in one commit. This requires a git push -f.

> >
> >> But at least my GitHub page has more green on it!
> >
> > If you want green you can fork
> > https://github.com/cervEdin/vanity
> >
> 
> I'm surprised how GitHub hasn't taken that down yet. Well, spamming
> commits means more green and isn't that good for the environment, right?

I don’t follow this. Sorry.

-Randall

