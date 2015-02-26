From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Thu, 26 Feb 2015 12:08:37 -0800
Message-ID: <CAGZ79kay+EXKaZ0UibCB=t4s5cVb28zgvUXeVRbd9d+XywhAsw@mail.gmail.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
	<CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
	<CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
	<CAGZ79kbZHtZuPrb6rEP41vbdnZqJmsMwq+8pNer-_D4U5B1xZw@mail.gmail.com>
	<CACsJy8BN2imGCW0cueh-jGKfN_nRg3=J-GTX2P5h2z0Tu=id6A@mail.gmail.com>
	<xmqqsidtoojh.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
	<CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 21:08:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR4jl-0006H4-4a
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 21:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081AbbBZUIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 15:08:39 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:39967 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbbBZUIi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 15:08:38 -0500
Received: by iebtr6 with SMTP id tr6so20372860ieb.7
        for <git@vger.kernel.org>; Thu, 26 Feb 2015 12:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6PwEvAjge7wTE4SzO/BgzuU5AqV3oL28WbqAxqjcj3Y=;
        b=O3xuXE60ewEWPf1UWhNROaNhMoFsQDf8qMgFRbIvV7T/fkN9o7YgnqNEVExV4MeEXN
         t3mAv+UrPFp2jhCmQfjPy7amiZXJHtY6COQD2ejRikROorVynwXmQ0//xEDz+y4OrQ7i
         nl3W6fnRWzci35L1zL3JusA0SC7p4SFqwFu0DYO4rhzsnHVLphnQQ15kO1xM30SY2KP8
         5NzOIKax69rpXcF/wt1NW+Mi07x5o35sv8qKXnxK8vxICFvnOuzF4pcAJF0iOqthA/IB
         KxAQAMir9Q3O+o3cPyZata/to23N+9PVNQfSTK0RWuOjcLfXo+ruNmDhLr9WpQqoCNCW
         u/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6PwEvAjge7wTE4SzO/BgzuU5AqV3oL28WbqAxqjcj3Y=;
        b=K5jzG9FIDhiigMXD+xvUZg3SJZzCeVzR8hd6xYwD2dTTYRHIfLT7jyHb40Bmj/fhAF
         xTZluYahDu2m3fNE5R/YC3vzZAnK7kXj9s+gfRiHbMHigaXEN9TlGCyE5oAonNb1p+1P
         3/9tXJ22VxSqNlOWlZ/vlfTNU51m6ahyLFYVIlkVexCGAkVASaEkJHv23HxV8cL5R3Mx
         GTMdcQJWZbeL9WkRZvleDwUr4JMNCfF5N72ZDz6wK121TVxiJRStSx7icgZaN5ee1Gnc
         tw59I1bko9IcLjZd+YW/0hlE28rw7AdbFY/ybZ1qJni8Zkl1QQQb0DaUWIp627K4jXP3
         pB7g==
X-Gm-Message-State: ALoCoQnpgqhHRRm9ZKFSuLDtSKIfwiptuPOQF6kOh2k7l5ZUst73J7os47sPY6sA5Tk/kjG/o1va
X-Received: by 10.42.83.147 with SMTP id h19mr11533570icl.95.1424981317910;
 Thu, 26 Feb 2015 12:08:37 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Thu, 26 Feb 2015 12:08:37 -0800 (PST)
In-Reply-To: <CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264453>

On Thu, Feb 26, 2015 at 2:15 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Feb 26, 2015 at 2:31 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Wed, Feb 25, 2015 at 10:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Duy Nguyen <pclouds@gmail.com> writes:
>>>
>>>> On Wed, Feb 25, 2015 at 6:37 AM, Stefan Beller <sbeller@google.com> wrote:
>>>>> I can understand, that we maybe want to just provide one generic
>>>>> "version 2" of the protocol which is an allrounder not doing bad in
>>>>> all of these aspects, but I can see usecases of having the desire to
>>>>> replace the wire protocol by your own implementation. To do so
>>>>> we could try to offer an API which makes implementing a new
>>>>> protocol somewhat easy. The current state of affairs is not providing
>>>>> this flexibility.
>>>>
>>>> I think we are quite flexible after initial ref advertisement.
>>>
>>> Yes, that is exactly where my "I am not convinced" comes from.
>>>
>>
>> We are not. (not really at least). We can tune some parameters or
>> change the behavior slightly,
>> but we cannot fix core assumptions made when creating v2 protocol.
>> This you can see when when talking about v1 as well: we cannot fix any
>> wrongdoings of v1 now by adding another capability.
>
> Step 1 then should be identifying these wrongdoings and assumptions.

So I think one of the key assumption was to not have many refs to advertise,
and advertising the refs is fine under that assumption.
So from my point of view it is hard to change the general

>
> We can really go wild with these capabilities. The only thing that
> can't be changed is perhaps sending the first ref. I don't know
> whether we can accept a dummy first ref... After that point, you can
> turn the protocol upside down because both client and server know what
> it would be.

So the way I currently envision (the transition to and) version 2 of
the protocol:

First connection (using the protocol as of now):

Server: Here are all the refs and capabilities I can offer. The capabilities
    include "not-send-refs-first" (aka version2)
Client: Ok, I'll store not-send-refs-first for next time. Now we will
continue with
    these options: <...>. For now we continue using the current
protocol and I want
    to update the "master" branch.
Server: Ok here is a pack file, and then master advances $SHA1..$SHA1
Client: ok, thanks, bye

For the next connection I have different ideas:

Client thinks v2 is supported, so it talks first: Last time we talked
your capabilities
hashed to "$SHA1", is that still correct?
Server: yes it is
# In the above roundtrip we would have a new key assumption that the
capabilities
# don't change often. Having push-certs enabled, this is invalid of
today. Hover this
# could be implemented with very low bandwidth usage
# The alternative path would be:
# Server: No my new capabilities are: <....>
Client: Ok I want to update all of refs/heads/{master,next,pu}. My
last fetch was
    yesterday at noon.
Server: Let me check the ref logs for these refs. Here is a packfile of length
    1000 bytes: <binary gibberish>
    {master, next} did not update since yesterday noon, pu updates from A..B
Client: ok, thanks, bye


Another approach would be this:
Client thinks v2 is supported, so it talks first: Last time we talked
you sent me
    refs advertisement including capabilities which hash to $SHA1.
Server: I see, I have stored that. Now that time has advanced there are a few
    differences, here is a diff of the refs advertisement:
* b3a551adf53c224b04c40f05b72a8790807b3138 HEAD\0 <capabilities>
* b3a551adf53c224b04c40f05b72a8790807b3138 refs/heads/master
- 24ca137a384aa1ac5a776eddaf35bb820fc6f6e6 refs/heads/tmp-fix
+ 1da8335ad5d0e46062a929ba6481bbbe35c8eef0 refs/pull/123/head

    Note that I do not include changed lines as +one line and - one
line as you know
    what the line was by your given $SHA1, so changed lines are marked
with *, while
    lines starting with '-' indicate deleted refs and '+' indicate new refs.
Client: I see, I can reconstruct the refs advertisement. Now we can
continue talking
as we always talked using v1 protocol.

>
>> So from my point
>> of view we don't waste resources when having an advertisement of
>> possible protocols instead of a boolean flag indicating v2 is
>> supported. There is really not much overhead in coding nor bytes
>> exchanged on the wire, so why not accept stuff that comes for free
>> (nearly) ?
>
> You realize you're advertising v2 as a new capability, right? Instead
> of defining v2 feature set then advertise v2, people could simply add
> new features directly. I don't see v2 (at least with these patches)
> adds any value.

Yes, we can go wild after the refs advertisement, but that is not the
critical problem as it works ok-ish? The problem I see for now is the huge
refs advertisement even before the capabilities are exchanged. So maybe
I do not want to talk about v2 but about changing the current protocol to first
talk about the capabilities in the first round trip, not sure if we
ever want to attach
data into the first RT as it may explode as soon as that information grows in
the future. The disadvantage would be one added round trip time, though I'd
guess that's ok for most compared to the huge refs advertisement.

>
>> I mean how do we know all the core assumptions made for v2 hold in the
>> future? We don't. That's why I'd propose a plain and easy exchange at
>> first stating the version to talk.
>
> And we already does that, except that we don't state what version (as
> a number) exactly, but what feature that version supports. The focus
> should be the new protocol at daemon.c and maybe remote-curl.c where
> we do know the current protocol is not flexible enough.

Most features are pretty non-invasive and at a few points in the code, you
can add
     if (featureX)
        doFeatureXRelatedStuff();

For changing the initial talking we'd need to make a more drastic change
to the code, which is why I thought to call it v2.

Thanks for your input,
Stefan

> --
> Duy
