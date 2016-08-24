Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D89D1F859
	for <e@80x24.org>; Wed, 24 Aug 2016 10:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753418AbcHXK6C (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 06:58:02 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36847 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752916AbcHXK6A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 06:58:00 -0400
Received: by mail-wm0-f65.google.com with SMTP id i138so2075109wmf.3;
        Wed, 24 Aug 2016 03:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=gBNtuDxegoxZkzBGUhZ1mBw3s/oOwTsfQrgTHr/1e4g=;
        b=OLiAIUwJ3dMJr58nxvsMK1heDQGpmj/Z9+csWOnLhoYw15CdPdEF9QYM03t/nv3kjV
         puaXmRJl6Kqfxm4ZH3a2rG2n8DYypDbN/hMs8PP1r/SKnS90kaE2ay3SMzG4WrRXAUv0
         kdL17kZBXDRnGicpBdh9NH2g+3AfdRziuwQByGqx2XxFbijSUTJSVhj47d6ThziIYrqM
         g1zllti3mV6tpdBoiQL3raEJAYVCOp9FWf7uFIE4jZ6ppGgDx4e5KDSrNFJMCzsTyAtD
         C2j30T4gymm8T0j/TRxs/Cp7Kmwo1TFPW1WxBi7imoSvHgopJFocZ/Sooe6BZ5Q4zNOZ
         h9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=gBNtuDxegoxZkzBGUhZ1mBw3s/oOwTsfQrgTHr/1e4g=;
        b=l8UQkVggu+HcE6qpZEdc4rr3HYhJIzLx2Drr3D/Ngd03U6noVUzX68I2Fku8yYvntJ
         XMkeRJIUpogOm8XgW3Nxa/T+dGFOYC9rZ7VOajuT2/PUJQd9zyOojl3rKiPQq/aMiYGO
         iSJh4qZTbc4f5N4n6kVCAr1WLjd8hUmeE0ZpI/J8aCzPG0VRp9ufpsMOI99kkX/P3jaK
         ubZss+l6TICIA3Lout9twzrQEP5D0nvJKc0Plh75WaPH62a10V23CQopgTGq4OQOwn5H
         nr97FH758cbJa3anaHNLI20O1SkX6TYvDh/1obZBj+cQg90T5Ca4BHMemoEjgVtRXUxh
         Jptg==
X-Gm-Message-State: AE9vXwME5UsRgTkpdIAD2PuGRnGIJwTWV+bkR/O2tLgKmfVmvfeyz2PM97ByH4jwrjwjwQ==
X-Received: by 10.28.125.80 with SMTP id y77mr2570080wmc.25.1472036167630;
        Wed, 24 Aug 2016 03:56:07 -0700 (PDT)
Received: from [192.168.1.26] (epy16.neoplus.adsl.tpnet.pl. [83.20.66.16])
        by smtp.googlemail.com with ESMTPSA id q23sm9981376wme.17.2016.08.24.03.56.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2016 03:56:06 -0700 (PDT)
Subject: Re: [ANNOUNCE] git-series: track changes to a patch series over time
To:     Josh Triplett <josh@joshtriplett.org>,
        Richard Ipsum <richard.ipsum@codethink.co.uk>
References: <20160729064055.GB25331@x> <20160803191202.GA22881@salo>
 <20160804224058.po43kl7w26ockfie@x> <20160810093731.GA3404@salo>
 <13509A14-16CB-476C-B983-7001F3D0DA61@joshtriplett.org>
Cc:     git@vger.kernel.org, linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <01106859-2e0b-326a-eca2-e8f935a90beb@gmail.com>
Date:   Wed, 24 Aug 2016 12:56:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <13509A14-16CB-476C-B983-7001F3D0DA61@joshtriplett.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 11.08.2016 o 00:07, Josh Triplett pisze:
> On August 9, 2016 11:37:31 PM HST, Richard Ipsum
> <richard.ipsum@codethink.co.uk> wrote:
>> On Thu, Aug 04, 2016 at 12:40:58PM -1000, Josh Triplett wrote:
[...]

>>> If you use a format-patch diff that includes the headers and
>>> commit message, you could also support commenting on those in the
>>> same way. Does the notedb format support commenting on those?
>> 
>> Comments in notedb are just a git note keyed on the sha of the 
>> commit being commented on, I'm not certain what advantage a 
>> format-patch diff provides in this case?
> 
> I meant for opening in an editor to write email-reply-style comments.
> The review tool and review storage format should allow commenting on
> commit messages, not just diffs.

There is also cover letter and interdiff, and one would want to
be able to comment also on those.

So how notedb solve problem of in-diff comments, in-commit comments,
post-commit comments, whole series cover letter and cover-letter
comments, interdiff and interdiff message / comments?


Nb. GitHub Pull Requests include only some of those, compared to
the mailing list / Usenet news interface.
 
>> I've been closely following the 'patch submission process' thread, 
>> and given the discussion there I'm having doubts over the value of
>> comments in git-candidate vs the mailing list. It seems to me that 
>> git-candidate has many of the disadvantages of Github/Gitlab when
>> it comes to comments, for example, there is no threading.
> 
> That's not inherent, though. You could allow commenting on a comment
> easily enough. (Of course, at some point you've recreated email-style
> in-reply-to headers...)

I wonder if we could use 'parent' header of a commit message for this,
or equivalent...
 
>> Also the system would be less open than the mailing list, since, as
>> it stands currently you would require push access to the
>> repository to comment on anything.
> 
> You'd need a federation mechanism.

...which is as easy to set up and use as mailing list, for sending
patches, applying patches, and patch review.  And/or provide 
bi-directional interface to the mailing list (I think Debian 
infrastructure tries to be (inter)operable by email).

There are various federated technologies (like pump.io), the
problem might be their popularity.

>> It may be worth reflecting that one reason some organizations have
>> switched away from mailing list reviews to Github/Gitlab is that 
>> they provide patch tracking, where the mailing list provides none, 
>> so patches there can be 'lost'. So instead of trying to
>> reimplement an entire Gerrit/Github/Gitlab UI on the commandline, I
>> wonder whether it would be sufficient to add the minimum
>> functionality necessary to provide git with native patch tracking,
>> and leave comments for the mailing list. Of course this is exactly
>> what git-series seems to do, so in some sense I may be advocating
>> dropping my own work in favour of improving git-series.
> 
> I think the two serve different (though related) functions. I'd love
> to be able to use a text editor and command-line tool to produce and
> submit comments to systems like Gerrit or GitHub.

I think there are command-line tools that allow to submit comments
to GitHub.

-- 
Jakub Narębski
