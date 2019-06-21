Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F093B1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 09:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfFUJLV (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 05:11:21 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:14486 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfFUJLV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 05:11:21 -0400
Received: from [192.168.1.22] ([89.243.184.39])
        by smtp.talktalk.net with SMTP
        id eFZnh6SeWgI7ieFZnhVNBz; Fri, 21 Jun 2019 10:11:19 +0100
X-Originating-IP: [89.243.184.39]
X-Spam: 0
X-OAuthority: v=2.3 cv=KYisTjQD c=1 sm=1 tr=0 a=3GZFt4OQGy0NQQxJwP7nlQ==:117
 a=3GZFt4OQGy0NQQxJwP7nlQ==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=anyJmfQTAAAA:8 a=yM8aDNMPAmBW292HFoMA:9 a=QEXdDO2ut3YA:10
 a=YJ_ntbLOlx1v6PCnmBeL:22
Subject: Re: Re-enabled a folder set as untracked
To:     Samuel Rabini <samuel.rabini@gmail.com>, git@vger.kernel.org
References: <4AB7124D-0704-4C6E-B3B1-C0C1BF5C89B0@gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <5b183aa2-fa8d-6278-5f87-23f00d16c0d8@iee.org>
Date:   Fri, 21 Jun 2019 10:11:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4AB7124D-0704-4C6E-B3B1-C0C1BF5C89B0@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfEkpDgjUGernhrwys/JQFUjNhbFjYKaq61BXfelauX02RtflcVnwVySSmbeDQu0nX6K16uSj77yM5TrVLxFpkZWPWDzBQ+K4NT5claMDQIyoCgxexDza
 tMwLwTauzLHDwoifZK4J8a4fURxrMpYrPIu2oKVVkYAeicsS771xRlhyNn3lJAqvsbABdLN1r1OMbflgtXaEfoLAeLWBe5NH3Ro=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/06/2019 21:11, Samuel Rabini wrote:
> Using SourceTree I issue the Stop Tracking command (I think it executed the add untracked https://git-scm.com/docs/git-add#Documentation/git-add.txt-adduntracked). Is there anyway to revert this command and re-enable the folder? I was able to re-add to the index all files into the folder by the git add -f pathtofolder command, but new files are not asked to be committed and pushed.
>

I don't use SourceTree. I doubt that your suggested 
git-add.txt-adduntrackedis the command used, as that is within a command 
line sub-menu.

I would guess that the command was a variant of 
https://git-scm.com/docs/git-rm with an option to retain the working 
tree file.

You ask about re-enabling the tracking of a _folder_ - this is a 
misunderstanding as git only tracks the named files, rather than 
complete folders.

To re-track a file, simply use `git add <pathspec>` (see the 
documentation notes about how the pathspec can add the contents of a 
complete folder..).

--
Philip
