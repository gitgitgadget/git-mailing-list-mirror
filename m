Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06F0F1FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 18:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbcLIS1L (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 13:27:11 -0500
Received: from resqmta-ch2-07v.sys.comcast.net ([69.252.207.39]:49840 "EHLO
        resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750747AbcLIS1K (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Dec 2016 13:27:10 -0500
Received: from resomta-ch2-01v.sys.comcast.net ([69.252.207.97])
        by resqmta-ch2-07v.sys.comcast.net with SMTP
        id FPsic4uy2j8tqFPszcqrPR; Fri, 09 Dec 2016 18:27:09 +0000
Received: from cherryberry.dsgml.com ([IPv6:2601:547:501:184b:22cf:30ff:fe05:22e8])
        by resomta-ch2-01v.sys.comcast.net with SMTP
        id FPsocepK92ENfFPszckI4S; Fri, 09 Dec 2016 18:27:09 +0000
Received: from as (helo=localhost)
        by cherryberry.dsgml.com with local-esmtp (Exim 4.84_2)
        (envelope-from <asgit@dsgml.com>)
        id 1cFPso-00066i-6L; Fri, 09 Dec 2016 13:26:58 -0500
Date:   Fri, 9 Dec 2016 13:26:58 -0500 (EST)
From:   Ariel <asgit@dsgml.com>
X-X-Sender: as@cherryberry.dsgml.com
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git add -p with new file
In-Reply-To: <CACsJy8A_YMyEUgX--1tEfJC4aaYfDbFFL8WEs6CHp4a4=mHRjw@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1612091322290.13185@cherryberry.dsgml.com>
References: <alpine.DEB.2.11.1612062012540.13185@cherryberry.dsgml.com> <CACsJy8A_YMyEUgX--1tEfJC4aaYfDbFFL8WEs6CHp4a4=mHRjw@mail.gmail.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-CMAE-Envelope: MS4wfErjUcg8GZvpFDpcFGQq5KMt0IyB3iombB+/T4TpXVI7sFVr873Bi/zwB8OLApfysbLdXD9W+W1IAuZ0+zRuhw7b2QqEdN409ICq4svj5p5/q31xnAYm
 mVvQ35hJEFmlNmvhHb0KDvwLakK5bqxVFJwpmOJGXayoaSTfX/LTFGfLf7l2WbHu9bwSyv4USexzBQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, 7 Dec 2016, Duy Nguyen wrote:

> On Wed, Dec 7, 2016 at 8:18 AM, Ariel <asgit@dsgml.com> wrote:

>> If you do git add -p new_file it says:

>> No changes.

>> Which is a rather confusing message. I would expect it to show me the
>> content of the file in patch form, in the normal way that -p works, let me
>> edit it, etc.

> We could improve it a bit, suggesting the user to do git add -N. But
> is there a point of using -p on a new file?

I got into the habit of always using -p as a way of checking my diffs 
before committing, so I ran it out of habit on a new file as well and got 
that confusing message.

It's even worse if you run it on multiple files, some changed, some added 
- the added ones are ignored completely, without any message at all.

> It will be one big chunk, you can't split anything.

That's fine, that's what I would expect.

> Perhaps maybe you want to use 'e' to edit what's added?

I might, but mainly it would show me what it was adding.

 	-Ariel
