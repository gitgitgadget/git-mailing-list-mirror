Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39DDE1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 20:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389821AbfJWUNT (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 16:13:19 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:47557 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfJWUNS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 16:13:18 -0400
X-Originating-IP: 1.186.12.46
Received: from localhost (unknown [1.186.12.46])
        (Authenticated sender: me@yadavpratyush.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 9F8D6240005;
        Wed, 23 Oct 2019 20:13:13 +0000 (UTC)
Date:   Thu, 24 Oct 2019 01:43:10 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Sixt <j6t@kdbg.org>
Subject: RFC: Moving git-gui development to GitHub
Message-ID: <20191023201310.thzpxyoeb3ta55dc@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I recently had some discussions with Dscho about whether it is a better 
idea to use GitHub for development instead of email [0]. His argument 
was that GitHub makes it easier for newcomers to contribute, since more 
people are familiar with GitHub compared to mailing lists. Also, it is 
somewhat difficult to set up an email-based workflow.

A pretty good argument. Using GitHub would certainly make one-off 
contributions easier, and make it easier for newcomers to get involved.

But I feel like it is equally important to know what is good for the 
long-term contributors. Since I've been involved with git-gui for a 
relatively short time, I don't know many long term active contributors. 
Those I know of are in Cc. These are people who have frequently or 
semi-frequently expressed interest in git-gui development. Of course, 
people not in Cc are also welcome to express their opinions, and if I 
forgot to put someone in there that I should have, my apologies.

I want to know people's opinion on whether it is a good idea to move 
development to GitHub.

Just to lay out my views on the subject, here's a list of advantages and 
disadvantages that I can come up with.

Arguments in favor of moving to GitHub:

- Easier for new and one-off contributors.

- Potentially easier for existing contributors. A lot of people are 
  already very comfortable with GitHub's workflow.

- The "Issues" section can serve as an issue tracker. Right now, my 
  "issue tracker" is my memory and a small text file I have on my disk.

- Rich text capabilities. I'm generally not a big fan of rich text, but 
  Markdown IMO has found a pretty good balance. Also, it would allow 
  people to post images, which is nice since it is a GUI (IIRC, the 
  mailing list strips attachments).

- We reduce the noise on the Git list. Most people subscribed to the 
  list probably don't care about git-gui. So all git-gui related emails 
  are essentially noise for them. And while the volume has been 
  relatively low, it is not negligible.

Arguments against moving to GitHub:

- We lose the audience that we have on the mailing list. Every now and 
  then, people who are interested in Git, and not really in git-gui 
  chime in with help and suggestions. Those people are likely to not 
  want to follow the repo on GitHub, so we lose that insight. One 
  example that comes to my mind would be Denton Liu chiming in to help 
  with some commits that were missing from my tree.

- We depend on a non-open proprietary platform. While I personally don't 
  really care that much, some people might. But the truth remains that 
  it is a closed platform that I or any other contributor has no control 
  over. If GitHub decides to ban me or any other contributor tomorrow, 
  we can do nothing about it. This might sound far-fetched, but it has 
  happened recently [1]. This specific case did not touch public repos, 
  but this can change in the future. Something like this is less likely 
  to happen to the Git mailing list and email.

- People are restricted to the workflow prescribed by GitHub. With 
  email, there is a certain degree of flexibility/customizability with 
  how you sort your mail, how you configure your mail client, etc.

- Sub-threads are not supported. Each reply is only to the "main" 
  thread, and you can't reply to a reply (like you can do in email). It 
  is a minor thing, but worth a mention IMHO.

This list is not meant to be exhaustive in any way. The intention is to 
start listing out the benefits and losses so we can make an informed 
decision. Please feel free to add to this list (or remove from it).

[0] https://public-inbox.org/git/nycvar.QRO.7.76.6.1910061054470.46@tvgsbejvaqbjf.bet/
[1] https://www.theverge.com/2019/7/29/8934694/github-us-trade-sanctions-developers-restricted-crimea-cuba-iran-north-korea-syria

-- 
Regards,
Pratyush Yadav
