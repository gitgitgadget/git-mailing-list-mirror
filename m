From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Avery Pennarun's git-subtree?
Date: Sun, 25 Jul 2010 21:57:55 +0200
Message-ID: <4C4C9743.9080902@web.de>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> 	<4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 	<m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> 	<4C49B0E9.1090300@web.de> <AANLkTimSoe9iqu4cJCH1d4rVsWHpFn3+8pbrCxsnVM1D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= =?ISO-8859-1?Q?_Bjarmason?= 
	<avarab@gmail.com>, Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 21:58:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od7Kq-00061c-6R
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 21:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231Ab0GYT6D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 15:58:03 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:39191 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab0GYT6B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 15:58:01 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate02.web.de (Postfix) with ESMTP id A2AAA16CC4B18;
	Sun, 25 Jul 2010 21:57:59 +0200 (CEST)
Received: from [80.128.107.104] (helo=[192.168.178.29])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #4)
	id 1Od7Kh-0005Jq-00; Sun, 25 Jul 2010 21:57:59 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.7) Gecko/20100713 Thunderbird/3.1.1
In-Reply-To: <AANLkTimSoe9iqu4cJCH1d4rVsWHpFn3+8pbrCxsnVM1D@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18WQ3XeYGfhnUZVdODvhK5N8VTufDKILJEIUfvg
	BjNS1o1sXhmdh+5O2BpYntCN6LHwyxxft5deklXfZ3uVmdQVDt
	soMR6nQyyvt2gpgpk3aQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151790>

Am 24.07.2010 00:32, schrieb Avery Pennarun:
> On Fri, Jul 23, 2010 at 11:10 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> You forgot what we do as best practice at work:
>>
>> [3] Fork the gem repos on github (or another server reachable by your
>>    co-workers) and use those, so you don't have to change the URL
>>    later:
>>
>>    git://github.com/apenwarrrubygems/gem[1..n]
>>
>> Your problems go away, setup has to be done only once on project
>> start and not for every developer, you can use your own branchnames
>> and you have a staging repo from where you can push patches upstream
>> if necessary.
> 
> Now all your fellow developers have to push their submodule code to a
> single upstream repo?  That's rather centralized and un-git-like.

But isn't that exactly the same thing you would have to do for your
superproject too to be able to push your changes for your fellows?


>> It is the /commits/ that have to be
>> done twice, once in the submodule and
>> then in the superproject. (But that is
>> not necessarily bad, imagine having git
>> gui as a submodule: you would be
>> automagically reminded that stuff for
>> git gui should be sent somewhere else
>> than to Junio).
> 
> Yup, I agree that requiring a separate commit to the submodule repo is
> not a bad idea.  I always do this anyway even when using git-subtree,
> because I'm thinking ahead to the day when I'll push my submodule
> changes upstream and I want my commit message to make sense.  But
> that's because I think ahead like that.  Having the tool force me to
> do it would be harmless and help people avoid mistakes.

And submodules force you to do that.


> The syntax for it ought to be nice though.  I should be able to do:
> 
>     git commit -- path/to/submodule
> 
> And have it commit everything in the submodule tree as a new commit in
> the submodule.  I don't want to have to think about cd'ing to
> path/to/submodule just so I can commit the files I changed in there.

Yes, that would be a nice feature (assuming you have a branch in the
submodule to commit these changes to ;-).
