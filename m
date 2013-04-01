From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Composing git repositories
Date: Mon, 1 Apr 2013 10:49:01 -0400
Message-ID: <CABURp0qnTLiB6zrdYfZfLP9+WJXT3umNggsfjT9TfDVn9V48HA@mail.gmail.com>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
 <7vmwtqt8rs.fsf@alter.siamese.dyndns.org> <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org> <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <51537A7B.7050206@web.de> <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com>
 <5154AACC.7050006@web.de> <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com>
 <CABURp0q9mV+-tEtHGpE4mh9cdbhkA8fr4i7XpBtK0fpfSYg-+A@mail.gmail.com> <51597A37.1010301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 01 16:49:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMg3S-0006MW-N4
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 16:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758411Ab3DAOtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 10:49:22 -0400
Received: from mail-vc0-f177.google.com ([209.85.220.177]:60505 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756736Ab3DAOtW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 10:49:22 -0400
Received: by mail-vc0-f177.google.com with SMTP id ia10so2397455vcb.22
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=53QNJP7UiWX9b4wSAtJvU+82q4dYIm64knU6GuQriyc=;
        b=wVSHK8hDqt5HBYOVPum6uLN7aKvWg+3JkBvMuKmSXkdpNY6Eq0ilGsE4mfjAMpbke7
         anwyOcr9/8G+Srb1uVz6vF2pGs1VEkSbfhTY1llOdoEoZqv+R/7fQA7XSjG4MaCHdMk+
         6TAautkK5xgpsuIoz8vpRWRkQCH3zoMMg2WTRvNeiMKqniTopY6aOw1eymgYXl7hSBfH
         53duUWorEntWDHeD9EQzMBA8KAiEutBVda7OsWVndeMdGfGcpAT6MgRohYGxASUzDf93
         mncQjVo/YCKbtMrE/N6a24YCfEA28pTmtmpE366Ca1AyO+oGPKOf+OWoRoot81/eZCZq
         T2Cg==
X-Received: by 10.52.158.163 with SMTP id wv3mr8038357vdb.82.1364827761707;
 Mon, 01 Apr 2013 07:49:21 -0700 (PDT)
Received: by 10.58.23.135 with HTTP; Mon, 1 Apr 2013 07:49:01 -0700 (PDT)
In-Reply-To: <51597A37.1010301@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219688>

On Mon, Apr 1, 2013 at 8:14 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 01.04.2013 01:50, schrieb Phil Hord:
>> On Sun, Mar 31, 2013 at 4:34 PM, Ramkumar Ramachandra
>> <artagnon@gmail.com> wrote:
>>> Jens Lehmann wrote:
>>>> Guess what: submodules are the solution for a certain set of use
>>>> cases, and tools like subtree are a solution for another set of
>>>> use cases. There is no silver bullet.
>>>
>>> That's the core of your argument: submodules already solve what it
>>> was meant to, and we can't get it to solve a larger class of problems.
>>>  In other words, you're implying that it's impossible to build a tool
>>> that will be able to compose git repositories in a way that solves a
>>> very large class of problems.  I don't see conclusive proof for this,
>>> so I have to disagree.
>>
>> I think it is possible to solve larger classes of problems with
>> submodules, but it is a harder problem than you seem to think.  In any
>> case I do not think you need to re-engineer submodules to improve
>> them.
>>
>> Sumodules are good for preserving history.  When properly managed,
>> they answer the question git always answers, "Where was my code in the
>> past?"  I would like proper management to be easier, but I understand
>> why it is difficult; and I see it getting easier.
>
> Exactly.
>
>> Some users also want submodules to handle other tasks, like "Import
>> branch-tracked upstream changes (i.e. git pull origin master)."  This
>> too is useful, but it is a different problem than submodules'
>> primarily try to solve.  But they do already solve _part_ of that
>> problem ("Show me how these modules are related"), so it seems a
>> trivial thing to ask them also to handle the "floating branch" task.
>> The trick is to handle this task in a way that does not break the task
>> they are designed and used for already.
>
> But I think we recently learned to support that use case with
> submodules. I think there are two floating models:
>
> - Tracked:
>   Follow a branch in the submodule and let git help you to advance
>   the submodule to the tip of that branch at certain times, but
>   still record a certain SHA-1 in the superproject to maintain
>   reproducibility. We support this since 1.8.2 (see 06b1abb5 by
>   Trevor).

Thanks.  I followed that thread closely, but I thought the patch had
stalled again.  I'm glad to see it in master

> - Untracked:
>   Some people just want "the newest" tip of a branch checked out in
>   the submodule and update that from time to time (I suspect this
>   is because they are used to SVN externals, which I believe work
>   that way). You throw away reproducibility, which I think is not
>   good and not the way I expect Git to work. But that use case is
>   achieved with a simple script and some config settings telling
>   Git to don't even look for changes in the submodule anymore, and
>   submodule infrastructure will set up everything for you after
>   cloning the superproject. You run your custom script from time
>   to time and have a truly floating submodule.
>
> So to me it looks we support both floating models with current Git's
> submodule infrastructure.

Well, for that matter, the "tracked" floating tip was also a simple
script once a upon a time.  To say we support both is nothing new.
You could say we supported both in 1.8.1, and now we support "Tracked"
a little bit better in 1.8.2.

I think the difference is that everyone's expectation for "Untracked"
is a little bit different; or maybe it is just dangerous enough that
it should not be a core feature.

But I ain't complainin'.

Phil
