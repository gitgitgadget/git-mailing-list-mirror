From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH/RFC 0/7] Support for Ruby
Date: Mon, 23 Sep 2013 14:47:13 -0500
Message-ID: <CAMP44s2YeeE8zHha2sOEtKfOJJcDPBuX2c2ceDnnhK_g=DmjRA@mail.gmail.com>
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
	<CACh33Fqm4C9BJhzatm9j1JBY8iY+gEafpnnhgnL2JJ2ff_xzKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Patrick Donnelly <batrick@batbytes.com>
X-From: git-owner@vger.kernel.org Mon Sep 23 21:47:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOC6J-0005Iw-Qp
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 21:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857Ab3IWTrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 15:47:15 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:64002 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589Ab3IWTrO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 15:47:14 -0400
Received: by mail-lb0-f175.google.com with SMTP id y6so2967302lbh.6
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 12:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IBwty1ZKI/wfobxLXDfP+nf58MnJ9OwR/uI9rHFQH1s=;
        b=EovdgxvBG1guG7p3VH7yk7xWMGZl13YN+0gJS4GMSlWHW04sSutwWYpTKlPggJ9U9B
         QR9GR3cNs1s0NLj1Zuyr4hGTPJMg+xjn2f9L+gSVu9oWtEa/nEIGhHtCQgjyYDBuauRK
         om7pQBK8+Gi6vaXDy6wGbK6X3WB/+yuBnmR+w8/OOpdCZoojB0ngKXrfJK4BmIohVv6u
         9OfLzuWCSfw40lgq/fmLPpOeMdt682hNEBsuEd8fAvzkdiQ71mAKqdnVlbr/zC0AwDSr
         sohDEaBS9OJO9ejbGe8HLuRcFekbZ2dGku9dy2eDTVgbIZQxgUR8UqRsNRcZgEk84Gce
         4VzA==
X-Received: by 10.112.57.49 with SMTP id f17mr3747544lbq.26.1379965633121;
 Mon, 23 Sep 2013 12:47:13 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Mon, 23 Sep 2013 12:47:13 -0700 (PDT)
In-Reply-To: <CACh33Fqm4C9BJhzatm9j1JBY8iY+gEafpnnhgnL2JJ2ff_xzKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235236>

On Mon, Sep 23, 2013 at 2:20 PM, Patrick Donnelly <batrick@batbytes.com> wrote:
> On Mon, Sep 23, 2013 at 2:53 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Yes, but that's not what the words said, the words said 'lua
>> integration' and 'ruby integration' would take that much. Either way
>> it doesn't matter, shared libraries exist for a reason. We don't need
>> to statically compile openssl do we? No? Good.
>
> Uh, you're willfully ignoring the conversation about avoiding
> dependencies. One way to do that is to include and statically link Lua
> along with Git. The cost of doing that is 200kb. I know this because I
> actually do it for Nmap.

Dependencies are avoided when it's possible and sensible to do so.
Yet, we still depend on a bunch of things.

My proposal to replace perl/shell with ruby would actually remove two
dependencies and add one, so in effect would remove one dependency. Of
course, people could still build with NO_RUBY=y, just like they can
build with NO_PERL=y, and deal with the consequences.

>>>> IMO the problem with lua is that it's too simple, it's syntax doesn't
>>>> resemble c, perl, python, shell, or ruby, it's just weird. Also, it's
>>>> much less popular, it's not as powerful, and there isn't a big
>>>> community involved with Git like with Ruby.
>>>
>>> *sigh*. At this point you've really cemented your purpose here as a
>>> language evangelist. It's unfortunate I have to reply to dismiss this
>>> FUD (which you complained about earlier, ironically) otherwise
>>> community accepts it as fact ("oh, I remember some guys saying Lua was
>>> a language for idiots...").
>>
>> I dismissed the claim as FUD, when the conclusion was exaggerated, and
>> there was no evidence in sight.
>>
>> When I say Ruby is a superior alternative, I provide evidence.
>
> You have provided *no* evidence.

I have, you just chose to ignore it.

>>> Lua is by no means *simple*. Try "small" or "lightweight". Its syntax
>>> is engineered to be readable and amateur friendly. You've placed Ruby
>>> on a pedestal alongside those other major languages but its syntax
>>> doesn't resemble any of those.
>>>
>>>>Also, it's much less popular
>>>
>>> https://sites.google.com/site/marbux/home/where-lua-is-used
>>>
>>> The hallmark of a good embedded language is your users don't even know
>>> it is there.
>>
>> Users don't even know in what language those projects are programmed,
>> that's irrelevant.
>
> *Absolutely relevant*: as normal git user *never* wants to know, care,
> or be exposed to the details of how `git` operates.

So? Before and after this patch they still wouldn't be exposed.

This is a total red herring.

>> If MediaWiki does indeed use Lua, it must be a tiny
>> fraction of it.
>
> They just started using it. Well done cherry-picking 1 example from a
> host for your dismissal.

I didn't cherry pick anything, I used the project I'm more familiar
with, replace MediaWiki with any other of your examples, and the claim
still stands.

>>>>  it's not as powerful,
>>>
>>> This is really funny to me. Despite Lua's small size, it has lead the
>>> way for modern dynamic language features, such as coroutines, block
>>> level scoping and real closure, incremental GC, a simple and usable C
>>> API (*yes* this is a feature), and a register based VM [1]. It is
>>> consistently placed as the *fastest* dynamic language in existence
>>> [e.g. 2]? The LuaJIT compiler often achieves competitive or better
>>> performance than C [3]. What about this isn't powerful?
>>
>> Talk is cheap, show me the code.
>>
>> Do what I did. Add lua bindings for several C functions, replace a
>> script with a Lua script (like git request-pull), replace a major
>> builtin (like git reset), and show how this succinct example I
>> provided in Ruby would look like:
>>
>> cb_data = 'foo'
>> for_each_ref() do |name, sha1, flags|
>>   puts '%s: %s: %s' % [cb_data, name, sha1_to_hex(sha1)]
>> end
>>
>> Let's see how it looks.
>
> I address your performance claims, you dismiss them and then ask for
> code to compare? Code which is primarily bindings to C which does all
> the work? No thanks, that circle jerk doesn't interest me.

I didn't make any performance claims, you made claims about being a
powerful language, well, let's see how powerful it is.

Ruby is so powerful I was able to write these patches with moderate
effort, surely if Lua is so powerful you can do the same.

>> Until you do that, I'd say you are the one that is language
>> evangelizing, I'm providing an actual real solution to a very
>> important problem.
>
> As mentioned elsewhere, the solution Git is using is to move porcelain
> commands to C. You're manufacturing problems and spreading FUD.

This effort has no end in sight, and as I've explained, using Ruby as
an interim solution would actually speed up the move to pure C.

In fact, I would know much more about the impediments since I sent
twenty eight patches to start replacing 'git rebase' with C code:

http://thread.gmane.org/gmane.comp.version-control.git/233396

They got rejected without so much as a reply. Why if it's so important
to move the scripts to C did these patches get ignored? Because it's
not. None of the core developers are interested in this, because they
don't use Windows, so it's not a priority for them.

> I'm letting this thread die as I only wanted to confront your baseless
> dismissal of Lua. If you want to continue this, I'll do it offlist.

Until you, or anyone, shows me the code, I'll continue to dismiss Lua,
or any other proposed solution.

I know doing what I did in Ruby would be very difficult in Lua, or any
other language for that matter, which is why I ask you to actually do
it, because I know you won't do it, because it's hard, which proves my
point.

I've proved other people wrong on this list by writing the code, if
you are not willing to walk the talk, then there's no point in
discussing. Even if I were to agree that Lua is a better option (which
I'm not), what have we achieved? Nothing. Who is going to implement
that? Not you, not me... So?

-- 
Felipe Contreras
