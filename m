From: Patrick Donnelly <batrick@batbytes.com>
Subject: Re: [PATCH/RFC 0/7] Support for Ruby
Date: Mon, 23 Sep 2013 15:20:31 -0400
Message-ID: <CACh33Fqm4C9BJhzatm9j1JBY8iY+gEafpnnhgnL2JJ2ff_xzKQ@mail.gmail.com>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
	<20130921212904.GA235845@vauxhall.crustytoothpaste.net>
	<CAMP44s3Shdg40go-WyGV8QKwEGoXg8hvEe8tetMyxvx5Sb7evw@mail.gmail.com>
	<20130921235647.GC235845@vauxhall.crustytoothpaste.net>
	<523e81f338f1e_547c41e7c166be@nysa.mail>
	<20130922073120.GC13262@paksenarrion.iveqy.com>
	<CAMP44s0Lww+se6iA2NWSwkeuLdR9mc0ppnVBSjWu4d73YeP6oA@mail.gmail.com>
	<20130922081250.GD13262@paksenarrion.iveqy.com>
	<CAMP44s3OYjv2LsU+6FY_qESdCvJcD4zb46aJmKpruof3hYEGzQ@mail.gmail.com>
	<CACh33FpP_Afb-9eke8m282saUZEDA_ZVbUQvKc6R3EF3P1ZvTA@mail.gmail.com>
	<CAMP44s2DfdqCLnp=CGf2O4tWi8LkoV=J2GTJiRORUGQjyrBnhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 23 21:20:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOBgU-0007Zt-II
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 21:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850Ab3IWTUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 15:20:34 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:46683 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555Ab3IWTUd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 15:20:33 -0400
Received: by mail-lb0-f176.google.com with SMTP id y6so2946217lbh.21
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 12:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=IDmW+7Xoca6FATIDlF6V8Il/uBGFN+WouJv0C5tQ1G8=;
        b=EgNQIqNIFie3fqtmm58EbS8G4+/kT7TJsG5tOLvJzryC5h6wGjCJKh8KcpLl4bBX6k
         E0t56iA14p+lmFPE9o6i/a/Thfpy9o0t4ZeYF/0RJd2N8Kitz+1whL6bPVDegyeua80a
         R1iiOHOLTLeSJQIPu5Y13n6x9A+w9+PJ5dWuLnYb7PbLNsR0IUEIrzGN6h1QG6w70we5
         4pPnWO1Io/AI36zaAa9q+VOH72GATAzLVDkuVmx4kJceTs6MHkMfhPWnqDQLv+3nhnVK
         GmWZXjqHbTXEVklWHOwz4hfXXWLLoipnmFny7yxhMCG6Bb6rx/dxRbHcosRzKss3x5i6
         Yb9g==
X-Gm-Message-State: ALoCoQlB22XG3aa6jKXJJ4ooGKAyBT2aCWwlm9SGg0EJ87r3hjUOPqZAA5T7t/SXzBS3DDgQuc9a
X-Received: by 10.112.168.3 with SMTP id zs3mr21261252lbb.2.1379964031964;
 Mon, 23 Sep 2013 12:20:31 -0700 (PDT)
Received: by 10.112.155.137 with HTTP; Mon, 23 Sep 2013 12:20:31 -0700 (PDT)
In-Reply-To: <CAMP44s2DfdqCLnp=CGf2O4tWi8LkoV=J2GTJiRORUGQjyrBnhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235235>

On Mon, Sep 23, 2013 at 2:53 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Yes, but that's not what the words said, the words said 'lua
> integration' and 'ruby integration' would take that much. Either way
> it doesn't matter, shared libraries exist for a reason. We don't need
> to statically compile openssl do we? No? Good.

Uh, you're willfully ignoring the conversation about avoiding
dependencies. One way to do that is to include and statically link Lua
along with Git. The cost of doing that is 200kb. I know this because I
actually do it for Nmap.

>>> IMO the problem with lua is that it's too simple, it's syntax doesn't
>>> resemble c, perl, python, shell, or ruby, it's just weird. Also, it's
>>> much less popular, it's not as powerful, and there isn't a big
>>> community involved with Git like with Ruby.
>>
>> *sigh*. At this point you've really cemented your purpose here as a
>> language evangelist. It's unfortunate I have to reply to dismiss this
>> FUD (which you complained about earlier, ironically) otherwise
>> community accepts it as fact ("oh, I remember some guys saying Lua was
>> a language for idiots...").
>
> I dismissed the claim as FUD, when the conclusion was exaggerated, and
> there was no evidence in sight.
>
> When I say Ruby is a superior alternative, I provide evidence.

You have provided *no* evidence.

>> Lua is by no means *simple*. Try "small" or "lightweight". Its syntax
>> is engineered to be readable and amateur friendly. You've placed Ruby
>> on a pedestal alongside those other major languages but its syntax
>> doesn't resemble any of those.
>>
>>>Also, it's much less popular
>>
>> https://sites.google.com/site/marbux/home/where-lua-is-used
>>
>> The hallmark of a good embedded language is your users don't even know
>> it is there.
>
> Users don't even know in what language those projects are programmed,
> that's irrelevant.

*Absolutely relevant*: as normal git user *never* wants to know, care,
or be exposed to the details of how `git` operates.

> If MediaWiki does indeed use Lua, it must be a tiny
> fraction of it.

They just started using it. Well done cherry-picking 1 example from a
host for your dismissal.

>>>  it's not as powerful,
>>
>> This is really funny to me. Despite Lua's small size, it has lead the
>> way for modern dynamic language features, such as coroutines, block
>> level scoping and real closure, incremental GC, a simple and usable C
>> API (*yes* this is a feature), and a register based VM [1]. It is
>> consistently placed as the *fastest* dynamic language in existence
>> [e.g. 2]? The LuaJIT compiler often achieves competitive or better
>> performance than C [3]. What about this isn't powerful?
>
> Talk is cheap, show me the code.
>
> Do what I did. Add lua bindings for several C functions, replace a
> script with a Lua script (like git request-pull), replace a major
> builtin (like git reset), and show how this succinct example I
> provided in Ruby would look like:
>
> cb_data = 'foo'
> for_each_ref() do |name, sha1, flags|
>   puts '%s: %s: %s' % [cb_data, name, sha1_to_hex(sha1)]
> end
>
> Let's see how it looks.

I address your performance claims, you dismiss them and then ask for
code to compare? Code which is primarily bindings to C which does all
the work? No thanks, that circle jerk doesn't interest me.

> Until you do that, I'd say you are the one that is language
> evangelizing, I'm providing an actual real solution to a very
> important problem.

As mentioned elsewhere, the solution Git is using is to move porcelain
commands to C. You're manufacturing problems and spreading FUD.

I'm letting this thread die as I only wanted to confront your baseless
dismissal of Lua. If you want to continue this, I'll do it offlist.

-- 
Patrick Donnelly
