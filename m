From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH 0/5] [WAS: Submodule Groups] Labels and
 submodule.autoInitialize
Date: Tue, 26 Jan 2016 21:59:24 +0100
Message-ID: <56A7DE2C.3020308@web.de>
References: <1453509103-16470-1-git-send-email-sbeller@google.com>
 <56A52818.8080808@web.de>
 <CAGZ79kY1Wa7kHh7GaCTAAmyaRgrT4_91XLaHZFrko9umEbNYkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 21:59:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOAiE-00021A-2V
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 21:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbcAZU7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 15:59:37 -0500
Received: from mout.web.de ([212.227.15.4]:56321 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373AbcAZU7d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 15:59:33 -0500
Received: from [192.168.178.41] ([79.211.124.113]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0M2Mq4-1a5GNV4Ayq-00s9ZA; Tue, 26 Jan 2016 21:59:26
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <CAGZ79kY1Wa7kHh7GaCTAAmyaRgrT4_91XLaHZFrko9umEbNYkw@mail.gmail.com>
X-Provags-ID: V03:K0:QKcHfLtteTXPfdRbMU6OvWoHSqG+6eE2EPPLNQWNMMfxTIR49b9
 iZCu8oRhO8Up3sgUenLRNRCo5dN0Ucyu1mPCo1FZTwKrYv5c2AJ2e+d9BYRd6Ua49NkhREI
 /eutmfcEETX7PKBohDfa3NlOEPGRRX053T32Lh0qAKOvvm9SxdSiRrcvHjQoH1ZUgNo2Vjf
 ywepDErRIevJDh6fR3Nyg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JkzKoHhzT+U=:PAszzI0JCWqKrKaSWN+U2h
 +sAGAzbFPwkuBCTufLJLf2Q52p4aEUM6fh9+MGc8imkOCMRAb44g7+dJsgRu4wMbA2OT31dxw
 Ugfo4VB+9VacI/NI46IUGC/+v7IMz9AleE+nrcHM8PSeIPirhi9KrRdBfv3rsbyraxA9kv13q
 O07NWGMPmdl9aAWJyEinVBsvFbExVsP2jhbIvmfnLnD8PTUxjqzTMHRfVVr5b6N+oyr1zjuZB
 9GhxTy4a9UR4Gnh+apKJ2dNWFq+xlJjOAsCXEXlWz5VjAX+zuLZE/aEJ3q0Cx7AY2L4HCH9z7
 5gQB5UpB46np/kv/06XsnuPaXyRJzDJaHfbEVnFuj7ebbEFD/v2SZQUDNygfEGZI9A76p6Zwx
 aVgVYdhsubfsQq87j8De9beZHH+30sQsmPzEAs6H9/uezeLmT57ktPr6GP3V1j30BI6c6bbrP
 xN8ROUhSEWwAXtOLoxsiQO9wzqVdHzqOPNjWp27uLheJI1T4bigNxXedfxwOv3/09uAajKJXX
 Zq3NvgFCFbyjLOqspf0lXhC3NmCbIPdQyV6TYGm4fy7hg2I7Uep/aONmfoL2R3E8gniQ78zD7
 v64Ze+r4s35uDEimmD/8cAP8dfPV5A5VA1HCgARRTg9N/+F0XjCIqR3VHyKBtjk+9Auh642l/
 v5BAZCLBdVSnT5YsyGoRERU/1zfTHkmr5N/X+kN+XtplEnyNXFYieQAeSNrJ7n4ZLV+fIcCXi
 ejibMGrusTzMhImluNGiJEmAdz/xwMyhdjUhrT62aGW34f9n4MAt9wirPl9jbil3AyDwmcc9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284854>

Am 25.01.2016 um 19:59 schrieb Stefan Beller:
> On Sun, Jan 24, 2016 at 11:38 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 23.01.2016 um 01:31 schrieb Stefan Beller:
>>>
>>> This series introduces labels which you can attach to submodules like so:
>>>
>>>       $ cat .gitmodules
>>>       [submodule "gcc"]
>>>           path = gcc
>>>           url = git://...
>>>           label = default
>>>           label = devel
>>>       [submodule "linux"]
>>>           path = linux
>>>           url = git://...
>>>           label = default
>>>
>>>       $ git submodule add --name emacs --label "editor" --label default
>>> git://...
>>>
>>>       # If upstream has submodules properly labeled, you can make use of
>>> them:
>>
>>
>> Cool. Without having looked at the code I assume you also can label
>> submodules yourself in .git/config (or your global config) to override
>> upstream's settings (or use your own labels if .gitmodules does not
>> contain any)?
>
> I am not sure. I'll add a test for that in a reroll and make sure it passes.

Thanks.

>>
>>>       $ git config --add submodule.autoInitialize "*default"
>>>       $ git config --add submodule.autoInitialize ":name"
>>>       $ git config --add submodule.autoInitialize "./by/path"
>>
>>
>> Ok. Though we might wanna call it submodule.autoUpdate, as initializing
>> it is only the prerequisite for automatically updating submodules. And
>> I believe automatically updating is the thing we're after here, right?
>
> I am not sure here, too. I would not mind an occasional "git submodule update"
> for whenever I want upstream to come down on my disk.
 >
> However that's what I
> do with "git pull" in the non-submodule case, so you'd expect git pull to
> also run the update strategies for all submodules which are configured to
> autoUpdate?
>
> That makes sense to me. Though I never use "git pull" to begin with.
> I always use fetch and see how to go from there (merge or rebase
> after inspecting the code I fetched). That would mean we want to
> add the autoUpdate strategy to merge/rebase and the fetching of
> submodules to the fetch command?

Hmm, maybe autoUpdate promises too much. After all this config is
just about which submodules are chosen to be updated on clone and
submodule update, not on all the other work tree manipulating
commands.

And it's similar to what sparse does. So what about calling that
"submodule.updateSparse"? Or maybe "submodule.sparseCheckout"?
Suggestions welcome.

>> I'll try to explain why I believe we should be generous in initializing
>> submodules: If a submodule in one branch has a label configured to be
>> automatically updated and hasn't got the same label in another branch,
>> we still need to initialize the submodule even when we are on the latter
>> branch in case the user switches to the first branch, right?
>
> No. "git checkout" ought to autoInitalize the submodule in question when
> switching branches. I don't want to see initialized, but unused submodules
> around (neither empty dirs nor in the .git/config ideally)?

Why not? Empty dirs is what unpopulated submodules look like from day
one (and they make the user aware she cannot add a file of the same
name). And you'll see initialized, but unused submodules around every
time you switch to a branch that doesn't contain this submodule at all.

And keeping them initialized even if they aren't currently checked out
is the only way they can keep their settings when the user is switching
between branches.

>> And the
>> fetch command needs to fetch submodule changes too when they happen in
>> a branch where this submodule is part of a label group configured to be
>> updated automatically, no matter what is currently found in the work
>> tree.
>
> Right, as said above fetch needs to fetch all the submodules as well. I wonder
> if it needs to fetch all submodule sha1s only or just try to get as
> much from the
> submodule as possible.

Right now we just do a simple fetch, but only fetching the SHA-1s could
be an optimization useful for busy submodules later on.

>> So I'd propose to:
>>
>> *) Initialize every submodule present on clone or newly fetched when
>>     the autoUpdate config is set.
>
> What if you clone branch A and then switch to B ? B has a submodule which
> was not initialized in A. I do not think initializing on clone/fetch
> is the right thing
> to do, but rather the branch switching command (checkout) shall make sure
> all its autoUpdate/autoInitialze submodules are setup properly, no?

I disagree. If you init all submodules on clone/fetch you might need
to change the upstream URL right after that. You can't do that on a
subsequent branch switch which needs to initialize the submodule again,
as the former deinit did nuke that configuration.

>> *) Automatically fetch only those submodules that are changed in
>>     a commit where they have a label configured (in the commit's
>>     .gitmodules or locally) that is to be checked out.
>
> Not sure I follow here.

We could restrict fetch to not fetch everything but just those changes
needed for sparse submodule update. To be able to do that it would
have to examine the fetched superproject commits if a submodule changed
and if it is configured to be automatically updated in that commit.

>> *) Let "git submodule update" update only those submodules that
>>     have an autoupdate label configured.
>
> Why not update all initialized submodules? (In my imagination
> "all initialized submodules" are equal to "all submodules the user is
> interested in", i.e. when going from branch A to B, the checkout will
> (de-)init submodules as necessary.

And throw away any customization the user did (to the URL or other
configurations)?

Without this sparse/label/group functionality, init is the way the
user tells us he is interested in a submodule. But when configuring
a label/name/path to update, the old meaning of init is obsolete
and superseded by the new mechanism.

>> That will make switching between branches with different label
>> configurations work fine. Or am I missing something here?
>>
>> And we need to teach diff and status to complain about empty work
>> trees and missing initialization of submodules that are to be
>> automatically updated too.
>
> What about empty work trees?
>
> I'll add "git status" complaining about missing initialized submodules.

If they are to be updated on the next "git submodule update" ;-)

>>
>>>       # The prefix * denotes a label as found in .gitmodules
>>>       # : goes before names
>>>       # path are prefixed ./ currently
>>>       # both path and names need work
>>
>>
>> Question: how do I configure all submodules to be automatically
>> initialized without having to give them a label? "./*"? Or just
>> setting the option without a specific value?
>
> I'd guess ./* should do. Path wildcard patterns are not supported in this
> series, but I think it would be a viable way.

Ok.

>>>       # no --init necessary, partially initializes submodules (only those
>>> which
>>>       # were specified by label, name or path)
>>>       $ git submodule update
>>
>>
>> Yup. Just like they will be fetched if they haven't been yet they
>> should be initialized if they haven't been yet but are configured
>> to be automatically updated.
>>
>>>       # time passes, upstream may have added new submodules and we get them
>>> without
>>>       # extra commands!
>>>       $ git submodule update
>>>
>>>       # The above configuration can be given to git clone directly via:
>>>       $ git clone --init-submodule=*labelA ...
>>
>>
>> Ok. Expecially nice is the ability to also give names and paths to
>> "--init-submodule". (but maybe that option should be called
>> "--autoupdate-submodule" for the reasons stated above?)
>
> If I can understand the discussion above a bit further, I'd be happy
> to rename the option.
>
> I think we have some different opinions on when
> submodules are initialized (the invariant of what an initalized submodules
> means), and resulting from that we also have different opinions on when
> to do the (de-)init.

Yes. But I hope my arguments will convince you ;-)
