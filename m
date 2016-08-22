Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0FC41F859
	for <e@80x24.org>; Mon, 22 Aug 2016 22:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756599AbcHVWBE (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 18:01:04 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:48943 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755029AbcHVWBC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 18:01:02 -0400
Received: from PhilipOakley ([92.22.27.170])
        by smtp.talktalk.net with SMTP
        id bxH4brVmEY8RwbxH4byNbD; Mon, 22 Aug 2016 23:00:55 +0100
X-Originating-IP: [92.22.27.170]
X-Spam: 0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=/APvtVBpJdUUAfvyVOMH7A==:117
 a=/APvtVBpJdUUAfvyVOMH7A==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=16rge6uK0PtIW2b3ITgA:9 a=aexYe5z1j2DaQ3mV:21 a=pV_rU6VXXJcYFmFW:21
 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <C651AA234E5A461BBA55E2D8D6E4DC85@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Duy Nguyen" <pclouds@gmail.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:     "David Lang" <david@lang.hm>, "Herczeg Zsolt" <zsolt94@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Git Mailing List" <git@vger.kernel.org>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>   <20160717154234.GC6644@vauxhall.crustytoothpaste.net> <20160717162349.GB11276@thunk.org> <20160717220417.GE6644@vauxhall.crustytoothpaste.net> <1468804249.2037.0@smtp.gmail.com> <alpine.DEB.2.20.1607180905320.28832@virtualbox> <CAPp-Vran2GZFTyJHb2qxgh3uRpM0ar7K2+VbbLcBK74_7aaxVw@mail.gmail.com> <alpine.DEB.2.20.1607181750470.3472@virtualbox> <CACsJy8Ba=c+-WV2TsY768_fTDO2KesS1b6BK7kdykNY6gkh=UQ@mail.gmail.com> <alpine.DEB.2.20.1607190910370.3472@virtualbox> <CACsJy8CSUu=AemQ-7uxth_2M=ko_KDGsdObwYdiE=L4OMKcVZw@mail.gmail.com> <alpine.DEB.2.02.1607191032270.25425@nftneq.ynat.uz> <CACsJy8Bvqt9r2dRtRfx1C-3Fp16z3SJ=hp0i7-itwFwfEfZwTw@mail.gmail.com> <alpine.DEB.2.02.1607191057170.25425@nftneq.ynat.uz> <CACsJy8D1RtwVF4ZtRHV2Z=huTqRBp8Du5GMZq9qxwXDZezBF2g@mail.gmail.com> <alpine.DEB.2.20.1607201428030.14111@virtualbox> <CACsJy8A3ZTfRRNuYXYD-nzXm6KXHu8cHU6fzfysJxfW0EggKNA@mail.gmail.com>
Subject: Re: Git and SHA-1 security (again)
Date:   Mon, 22 Aug 2016 23:01:00 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfHmS/EXl8Zn1R+7uf0uiUx4hh0OdxbyrNoLquhPYLc5EOt325rEQQyqBJZcJqR1Q13LqAMb81N+Vcu9cX9hp6TjDuUfV9UVc/46IBeke9ls4F66Ury58
 zuaj0ooUFFLQVn6JlSsGj4SHzvTxlVW+QxyFbt6us6R/qD10FbPUmtvLSLnNep7aYa8ofBKZWPZ+Hgrlyn7i3pqn3E/Pixn7bV+GRC2rP5eUxfXJ6M9Fa1an
 /jh0R2UNZxDgm2XbxNC3jacKhdCma6DEROnG8WqPzG1jvawJbcSXKBxJcavEecs+DhwzZLTP9R2QpxLR4QeaQMStyjWt6hHA8Vp+opd7j/Xun35rUYittepj
 PEMKHG27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry if I'm dropping in at the wrong point (this is one I'd bookmarked)..



From: "Duy Nguyen" <pclouds@gmail.com>
Sent: Wednesday, July 20, 2016 3:44 PM
> On Wed, Jul 20, 2016 at 2:28 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> But that strategy *still* ignores the distributed nature of Git. Just
>> because *you* make that merge at a certain point does not necessarily 
>> mean
>> that I make it at that point, too.
>>
>> Any approach that tries to have one single point of conversion will most
>> likely fall short of a solution.
>
> OK I see the difference in our views now. To me an sha256 repo would
> see an sha1 repo as a _foreign_ DVCS, pretty much like git sees
> mercurial now. So a transition from sha1 to sha256 is not that
> different from cvs -> svn -> a dvcs bubble -> git.
>

I think that within Git, that it is possible to have inter-workability (for 
those parts that negotiate) between instances with different views about the 
availability of two hash types. Fetch/push negotiation is a normal part of 
working with a remote.

>> To be honest, I am less concerned about the GPG-signed commits (after 
>> all,
>> after switching to a more secure hash algorithm, a maintainer could
>> cross-sign all signed commits, or only the branch tips or tags, as new
>> tags, to reinstitute trust).
>>
>> I am much more concerned about references to commits, both inside and
>> outside the repository. That is, if I read anywhere on the internet about
>> Git having added support for `git add --chmod=+x <file>` in 4e55ed3 (add:
>> add --chmod=+x / --chmod=-x options, 2016-05-31), I want to find that
>> commit by that reference.
>>
>> And I am of course concerned what should happen if a user wants to fetch
>> from, or push to, a SHA-1-hashed remote repository into, or from, a
>> SHA-256-hashed local one.
>
> to follow the above, in my view, interaction with sha1 repos go
> through some conversion bridges like what we have with hg and svn. I
> don't know if we are going this route. It's certainly simpler and
> people already have experiences (from previous migration) to prepare
> for it.
> -- 

The main thought was that rather than worrying about which advanced hash to 
pick (with all the arguments that entails), rather it is worth reducing the 
problem space to create a 'toy problem', to look at the interaction issues.

For the toy problem view we'd keep the current oid length (so that the 
transmission formats don't change size), however we swap the old-new to make 
sha1 the new hash and use an older shorter hash (e.g. md5) to investigate 
the transition from a short to long hash.

Keeping it as a 'toy problem' avoids folks having too much invested in the 
new hash choice, rather the interworking can be more easily sorted, and some 
issue can be punted on (e.g. the choice of salt to extend the md5 to the 
sha1, and collisions therein).

--
Philip

