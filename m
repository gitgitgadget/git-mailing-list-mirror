Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F5CC433E0
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 21:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DDB920780
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 21:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=whinis.com header.i=@whinis.com header.b="cso1nWhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgGBV50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:57:26 -0400
Received: from whinis.com ([198.205.115.165]:35486 "EHLO whinis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgGBV50 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 17:57:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by whinis.com (Postfix) with ESMTP id BCC647C51E8;
        Thu,  2 Jul 2020 17:57:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whinis.com; s=mail;
        t=1593727044; bh=Tdp0kKPvSxq8OXvCs9k/xZlCKdo/14QK3QruXQR1sNc=;
        h=To:Cc:References:Subject:From:Date:In-Reply-To;
        b=cso1nWhyXwJ1iVPW5OwpiDgetWXXSqfSC//t50qiClfjDZHHDrsJEXW1M2GZya2J/
         ouk4A7o7wAGGQVCdydHs4jcYdRWQRg0zG/f2tT8qsKQkAqkscoSVHQJmJ4mQFRQKyJ
         C0kfjy8gz5hmK0y4V/bdUvXTNfTx/4PytJgNXKQk=
X-Virus-Scanned: Debian amavisd-new at whinis.com
Received: from whinis.com ([127.0.0.1])
        by localhost (asgard.whinis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MH-tZIUQ3iFZ; Thu,  2 Jul 2020 17:57:23 -0400 (EDT)
Received: from [10.129.128.188] (unknown [129.171.6.200])
        by whinis.com (Postfix) with ESMTPSA id 0EC7F7C51C3;
        Thu,  2 Jul 2020 17:57:21 -0400 (EDT)
To:     philipoakley@iee.email
Cc:     Whinis@whinis.com, bturner@atlassian.com, git@vger.kernel.org,
        james@jramsay.com.au, me@ttaylorr.com, msuchanek@suse.de,
        peff@peff.net
References: <4bbc8658-4dad-10ef-65a4-8f0f4f4fffd4@iee.email>
Subject: Re: Consensus on a new default branch name
From:   Whinis <Whinis@whinis.com>
Message-ID: <d02a4b0c-71a1-5c83-a2f5-5e5f2168e5c4@whinis.com>
Date:   Thu, 2 Jul 2020 17:59:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <4bbc8658-4dad-10ef-65a4-8f0f4f4fffd4@iee.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The earliest claim I can find is from 2003, verified at Snopes in 2007
> [1] and reported in 2003 at [1] (and elsewhere)
>
> I would not expect that the original complaint had been withdrawn. I
> don't know if the relevant US/local laws have changed.
Not exactly proof in this sense nor proof they had an actual grievance 
as someone in US law might tell you. Sadly it was rather recently a 
lawyer would go around claiming to be disabled or speak for an unnamed 
disabled citizen and sue every single restaurant they came across for 
ADA violations. Same was done recently with a Lebowits but for copyright 
law where its easy as a lawyer to sue continuously to get an easy 
settlement until you are disbarred. Even from that link the official 
that wrote the memo said

> “I do understand that this term has been an industry standard for 
> years and years and this is nothing more than a plea to vendors to see 
> what they can do,” he said. “It appears that some folks have taken 
> this a little too literally.”
>
> Sandoval said that he had already rejected a suggestion that the 
> county stop buying all equipment carrying the “master” and “slave” 
> labels and had no intention of enforcing a ban on such terms with 
> suppliers.
>
> A recent blog post on racial bias in AI [2] highlighted that "Algorithms
> are our opinions written in code",  just as many of our naming
> conventions are implicit stand-ins for unsurfaced opinions and biases.
>
There is a great deal of misunderstanding on the "bias" in AI and in AI 
in general. I think you may have linked the wrong comment as [2] goes to 
a BBC story on the same story as the snopes article. However if you are 
talking about the recent depixelator it was shown to have similar 
performance if you darkened the images. This is not a bias its a 
technological limitation as darker images have less contrast on facial 
features, its also a well known issue in photography where its difficult 
to get enough dynamic range to properly expose an image with both 
darkskin and light skin individuals. Outside of extremely expensive 
cameras that even professional photographers don't want to use the 
technology is not in the hands of people to take proper photos with the 
needed dynamic range. This is also why lighting in films and TV are so 
important.

I feel a great many people want to attribute bias due to lack of data 
whenever no bias exists.

> One area that is far more obvious in the UK, is the use of euphemisms
> and innuendo, which can be grossly misused. It is quite easy to create
> subtlety different phrases which actively discriminate that wouldn't be
> noticed except by the careful or 'in the know' listener.  This can
> easily be done with 'master' in Git.

Unless you are making some allegation that anyone using the word master 
is racists or that somehow every technical field is inherently racists I 
have no idea why you are claiming its the same as actively 
discriminating. Or maybe you are trying to say the UK using its 
euphemisms is trying to be covertly racists? It would do well to clear 
up this confusing reference as it currently could be seen as insulting 
or making implications which clearly do not exists.

>  From a comment in [3], the link [4] provides details of the association
> of 'master' with 'slave' in Engineering literature, beginning in 1904
> for a pendulum & clock arrangement. In electronic clock circuits it
> wasn't till 1966 the use extended to flip-flop circuits, while hydraulic
> master/slave cylinders started in 1959.
I am rather unsure why you are reference either. Maybe you mixed up 2 
and 3 because 3 has nothing on master or slave but as you have mentioned 
its orthogonal since git has no slave branch. 4 is a admittedly short 
paper as the author recognized that it could be its own doctoral thesis 
and only did a cursory search although many are using it as proof that 
no references exists prior to this time. It also adds its own heavy 
biases as mentioned in the paper while gill was the first to use the 
slave reference that they can find it was used for many years without 
much discussion and even when challenged it was determined it would be 
better than a much wordier alternative because it would be better 
understood. The paper also claim that Gill would be disapproving of the 
words use however has nothing to back this up considering they not only 
used the term but appearntly did so for many years afterwords at lectures.

> The other issue is that Git doesn't do unique masters anyway. If you
> have the correct commit hash you have a perfect, indistinguishable
> replica of the original object - It's not a master (in the old 'version
> control' sense) any more, so we don't need that name for local clone's
> branch, unless it happens to be copied as the remote tracking branch.
> Though that is orthogonal to this discussion.
How does each commit have a perfect indistinguishable replica of the 
original? My understanding is each commit is a record of changes 
compared to the last. As such only the first commit is truly 'perfect'

> As I understand the change process, this will not be the catastrophic
> change many are suggesting. Existing repositories will still continue
> working. New repositories will have options for choosing the defaults.
> The usual level of great care over backward compatibility is being taken.
Is it? Because it seems to be that its waved off as a necessary cost of 
changing "outdated" language.  Being that its been used now for at least 
110 years and being that its the understood vernacular and multiple 
projects and scripts assume, even if wrongly, the master branch is the 
one you should work from means changing this default is not usual great 
level of care. Certainly main seem to think its as simple as changing 
the letter and nothing will break. Sadly that rarely true

> Anyway, that's the back story, with references,  that I've been able to
> track down. Hope that helps.
Unfortuntely no as the references being asked for is who this change 
actually impacts. We could go to twitter but that has it owns biases and 
every issue on this topic outside of this mailing list is either locked 
or biases by assuming it must change and leaving out master or tainted 
due to brigading. Just based on what I have anecdotally seen however 
most of the people pushing for this change is not the affected minority 
group its claimed to help.

-Whinis

