From: Stefan Beller <sbeller@google.com>
Subject: Re: Re: [RFD/PATCH] submodule doc: describe where we can configure them
Date: Mon, 9 May 2016 10:32:50 -0700
Message-ID: <CAGZ79kZ+WzVwhj77zkHKbX-PmgfPvCO9qcX07vyC-BG+nDhWxA@mail.gmail.com>
References: <1462317985-640-1-git-send-email-sbeller@google.com>
	<20160503235652.GA395@google.com>
	<CAGZ79kb4GNZi93JpsPKUb7ScmePqDC1Xp+WZTGD7hfPUn9tWaQ@mail.gmail.com>
	<20160504150143.GA8575@sandbox>
	<CAGZ79kZs5zLAUdi53D=pTyFZF__73ZbW4o28C2hOuTV7_NfaDQ@mail.gmail.com>
	<20160508215401.GA59077@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon May 09 19:37:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azp3R-0001Ua-Cb
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 19:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbcEIRdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 13:33:08 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:34975 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbcEIRcw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 13:32:52 -0400
Received: by mail-io0-f176.google.com with SMTP id d62so179508124iof.2
        for <git@vger.kernel.org>; Mon, 09 May 2016 10:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Oh/jyiTBn9a8vEdTzJrdu/ZX+rPi6Ay2GyrO0Maw+e0=;
        b=GGBkA5y3cWzdpd/XVtbI/QGoxz4tSKZJeKPpN0qkJt2p9HyXFS88QqjO9kjtg5MJek
         LcRVtLOm7ESNz/r0YM8zqD9mfsY+re5cEv5e1LT4faP4GA2IoLznwmvfkConesEMvbrm
         FhtiOdyQkIOZiEPct2RqSL7RhKk6iO18NhKAKprSteCScYvDdk71q+oYpgb8vBVUMzSI
         Y+S6psZGAsNBwvAPKCxO0rePW6fcubmL/FrQ10d+OaNaek0B+CJNmvEBMs+1fUjIHCkY
         e7ZGATxIRUQeZYYsMW0FZ44K/nxKgeWZ4Z0XW3XSK8Ex1AWsDhgDRGHxvmAa3oDaQxrV
         Q0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Oh/jyiTBn9a8vEdTzJrdu/ZX+rPi6Ay2GyrO0Maw+e0=;
        b=Yl/z5SwdL/8hWoOgH3/kUSOwKWibgFbvmdI1mP/G5LqU2ily3vuseouVDHbNKUi5rM
         iVSQwaaDXwxorkfDItq5fBgk/ZCAvG8m2mvu7MCxceI6mZARzPA8Orkx/nFv9uPYSObo
         KJlT4nfaq1ElZwJ0wHXich3Ne4Gs4dpqQZbxyD3Wcr7uk7T7Qd/mxfBTLKX1CtLzar80
         3m8WweeWRwZDLMSJIWF5UuVEXamgUmKonSYbxsVjzjJqj+PwsK2IM2/86WmrMcu2JjBW
         800QeA6AWr/sYmwgJ9bYFMrViTal3kDZCfyllp8UcPK1qKMMZKpHRtfbI3lARSNdGqlQ
         qzAA==
X-Gm-Message-State: AOPr4FUmEdP9ZNnCxg8yFpp/o4sxtamZ6yoYiPg5JtLePeWuowtnDlOwZL2VHXjXIf1XI5AQPOpNT40UTCzJ0YdY
X-Received: by 10.107.161.68 with SMTP id k65mr43497617ioe.110.1462815170490;
 Mon, 09 May 2016 10:32:50 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 9 May 2016 10:32:50 -0700 (PDT)
In-Reply-To: <20160508215401.GA59077@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294024>

>> Here is what I imagine
>> When B mirrors from A, B sets up this special ref for its repository,
>> e.g. refs/meta/submodule-B and have a symbolic ref pointing at that.
>> (e.g. SUBMODULE_CONFIG pointing at refs/meta/submodule-B,
>> which has a worktree which contains a .gitmodules files which
>> sets up
>>   "submodule.baz.url = http://B/baz"
>>   "submodule.relativeBase = http://A"
>>
>> That way anyone cloning from B would get
>> the superproject and the submodule baz from B while the
>> rest of the submodules are found at A.
>
> This sounds sensible. But my imagination of a conflict was in a
> different way. E.g. project A has a submodule B. And now A has a remote
> 1 where you publish and maybe another remote 2 where someone else (a
> colleague?) publishes. Which configuration do you use? Here the two
> remotes are independent instead of subsequent forks. In this case my
> solution would be to use the configuration branch from 1 for B when
> interacting with 1. I do not have completely checked whether we always
> have a remote at hand for such a resolution.

I think it is the responsibility of the pusher to make sure the
configuration is sane.
So if I were to push to remote 2 and you push to remote 1, we'd both configure
the special branch of our superprojects for these remotes for that submodule.

If the superproject has relative urls for the submodule, all we had to do was
unset (or overwrite) the submodule.baseConfig.

>
>> When C mirrors from A, they add another branch  refs/meta/submodule-C,
>> which can either be a fork of refs/meta/submodule-B with some changes on
>> top of it or it can add a reference to refs/meta/submodule-B, i.e. the
>> configuration
>> would be:
>>
>>   "submodule.baseConfig = refs/meta/submodule-B"
>>   "submodule.foo.url = ssh://C/foo"
>>
>> and SUBMODULE_CONFIG would point at refs/meta/submodule-C.
>>
>> When cloning from C, the user would get
>>
>>  * the superproject from C
>>  * submodule foo from C
>>  * submodule baz from B
>>  * all other submodules from A
>>
>> By the inheriting property of the branch of B there are no conflicting values.
>> C could just overwrite submodule.baseConfig for example.
>
> So that means in the default case we create a chain of all previous
> forks embedded in repository database.

Not necessarily. I was just pointing out that this was possible. The
intermediate
party could decide that their upstream is too unreliable and not point
to their upstream.

This would incur the cost of having to clone all submodules and
overwriting the absolute
urls. For the relative URLs this would just work as of now.

All I wanted with that example is to offer the flexibility to not have
to clone all the
submodule, but I can fork a mega-project with 100s of submodules and maybe
just fiddle with one of them and then publish that.

> I am not saying that this is
> necessarily a bad thing but I feel that it is a new property which we
> should think about. It helps because users will get updated values from
> sources that are in the chain. On the other hand it adds a lot of
> dependencies which are point of failures in case a remote disappears. I
> am undecided on this. I would prefer if we could let people play with it
> a little (maybe on pu?) and then decide if there are practical pitfalls
> with this.
>
>> > My suggested scheme above does not solve the currently quite typical use
>> > case where you might 'git fetch' without submodules first and then do
>> > the submodule fetches during a 'git submodule update'. On the other hand
>> > in the 'ideal future world' where submodules behave like "normal files" the
>> > fetch will be done during the superproject fetch so in that case we
>> > could solve such conflicts.
>> >
>> > The main thing which we could keep in mind is that we only allow certain
>> > values in such special refs. E.g. only the ones needed to support the
>> > fork workflow. BTW, do we actually need to change other values than the
>> > URL? Addtionally we ignore other values that are more related to the
>> > overall project structure. E.g. like submodule.<name>.ignore.
>>
>> Maybe we want to have a dedicated protocol field, eventually.
>> A,B,C may have different standards on what they use by default.
>> e.g. Use ssh at kernel.org, but http in a corporate mirror, because http is
>> the only protocol not blocked by firewall. So I could imagine that a
>> complete mirror of submodules with relative URLs wants to only replace
>> ssh by http.
>
> By this you mean 'submodule.relativeBase' that you introduced above
> right? Or something similar. These values I would still consider them
> URL'ish. But my question was more geared towards this direction: Are
> there other values than the ones used to assemble the URL that make
> sense to share?
>
> E.g.: Someone might want to fork a repository and might want to change
> the default set of submodules that are populated with 'git submodule
> update --init'. Is this something we should allow via these special refs
> or is this actually changing the project structure and should also be
> reflected in project history? IMO the latter is the case.

That sounds reasonable.

>
> Only things like the technical organisation (like the place where a
> repository can be found) justify to be outside of the repository IMO.
>
> A repository without submodules does have one collection of remote
> repository urls. To me adding proper fork support seems be the switch
> from one collection for one repository to many collections for many
> repositories. Since this one collection is already outside of the
> superproject it makes sense to do the same for the submodules. So my
> question reformulated could be: Are there more values we currently keep
> inside the repository for submodules that actually belong outside? A
> good indication could be that they are already outside in the
> superproject.
>
> I did not find any flaw in these statements yet, but maybe I am
> oversimplifying?

They sound right to me.

>
> Cheers Heiko

Thanks for the discussion :)
Stefan
