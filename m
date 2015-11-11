From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Allow git alias to override existing Git commands
Date: Wed, 11 Nov 2015 20:44:43 +0100
Message-ID: <56439AAB.4040104@web.de>
References: <56421BD9.5060501@game-point.net>
 <CAGZ79kZxQWVMe3N1ti8npyp9_4DUPAVy9Uk5a75Jwh3Eud2eZQ@mail.gmail.com>
 <5642685F.9070405@web.de>
 <CAGZ79ka_RACVEDJBU8_5UsEyUBvQgKTh7FbvSoHxpMjDYDgPOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeremy Morton <admin@game-point.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 20:45:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwbKW-0006ob-MN
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 20:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbbKKTpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 14:45:08 -0500
Received: from mout.web.de ([212.227.17.12]:51248 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066AbbKKTpG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 14:45:06 -0500
Received: from [192.168.178.41] ([79.211.127.69]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LopeB-1abPNx2w39-00goNZ; Wed, 11 Nov 2015 20:44:50
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79ka_RACVEDJBU8_5UsEyUBvQgKTh7FbvSoHxpMjDYDgPOw@mail.gmail.com>
X-Provags-ID: V03:K0:HR6RHc4tL4Fk8B314OB+K5qO09kvYNshjMt9QfLRF0LWN55MqPK
 d8chIZC/P0phMeIH5qN5I0Y5AvLc3SzXBKxZOzmc0Oio2IY5b+SOLvAwY3twBO6Z+18oEMe
 ElqL2MejpfbIWOlICgLaS18QMjc5z1dXdYXaGbKSaiZTmyNw2XjUnO3UPG0wAbFBeWOXpM0
 lG+BlCPDu1vv8vd5RAGYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ME3CfnQV0qg=:GO12DK+etM1u9UwnTDkUEI
 ayvAg5FNJvINFY9Jc6cXENsODrxfiaEWraHpSF/OjnNcpo6WDqIo8Iw7ZcWFJO5JUB6XyHud5
 gHt3jQ7NgF7eIsZ+otkIz27FORTY2TdrzGQ+CnfdPYpuusuyPXI0yQNWcbtMhMoX5x0aj6vnf
 tLl59MKm3kNyQnY0hiMyvfXKhiguVeR7546UL44Lm/5PRhMFXyfN6TOv4ns2c3SU6YPMVW8OP
 B5kjNpcQQDq0EdTxEqp/MU8BJDiLfGk1cUh7Sz7SfTJBqSQ7hbiocf5agKA+ffFACbZzYACL9
 bKEMsw5nDbinFYFpLz6tnp6MZlq530eq48tG+EyLK6jXCWKPRnF7d0fgrOfZ2jyZd0KUFHOo5
 EOKPwGT1TP3oniqjmcHZRgkLr+ELceE+MeoRMRaf+ttPvf+T3BrQ+/d8UlBZwJvOQrvdlYckQ
 4Q1EmEmQZPbpulh9WL3nYhCi8yC9iUY1DWHuhOnUVoOsLJXYNgEBfgZIEPIE+aTcnVLjn0Css
 QA/K8eWkHhC4d+iIZh0/lQTh8Gj0MM/97XMDX2z69UAsINGoVSvWXDnT7lTleHMyzwMNgF28H
 +7+RD1y29+iIuFsNzPbd6qQCJ/X0ldxpQ4kudE5tUw+cAxb4xU8fUk/0nIjrLWtNYjV4Fa2n1
 HJOHLhbb+WtAjjsKNXJvH8BQ2lPQaLTkSbXc3KdDfXcb1MjdoDQZb2p+az6yf+Q44uFXkbNrR
 IGka9cpeUp7m6fqaThbInxMBwc+NX/L7sj2jtryQvshu4fnx3fWdXkkv3CFgm8x0cESQ/L3g 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281190>

Am 10.11.2015 um 23:49 schrieb Stefan Beller:
> On Tue, Nov 10, 2015 at 1:57 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 10.11.2015 um 19:12 schrieb Stefan Beller:
>>> On Tue, Nov 10, 2015 at 8:31 AM, Jeremy Morton <admin@game-point.net>
>>>> For example, I wanted to setup "git clone" to automatically act as "git
>>>> clone --recursive".  Sure I could do it in the shell, but it's more of a
>>>> pain - any tutorial I set up about doing it would have to worry about
>>>> what
>>>> shell the user was using - and if you're going to make that argument, why
>>>> have "git alias" at all?  It can all be done from the shell.
>>>
>>>
>>> I think the git way for your example would be to configure git to include
>>> that
>>> option by default, something like
>>>
>>>       git config --global submodules.recursiveClone yes
>>>
>>> though I was skimming through the man page of git config and did not find
>>> that option there. I guess it's missing.
>>
>>
>> We thought about adding such a config option, but I believe that would
>> fall a bit short. If I want to have recursive clone I also want to init
>> all those submodules appearing in later fetches too (otherwise the end
>> result would depend on whether you cloned before or after a submodule
>> was added upstream, which is confusing). Extra points for populating
>> the submodule in my work tree when switching to a commit containing
>> the new submodule.
>>
>> So what about a "submodule.autoupdate" config option? If set to true,
>> all submodules not marked "update=none" would automatically be fetched
>> and inited by fetch (and thus clone too) and then checked out (with my
>> recursive update changes) in every work tree manipulating command
>> (again including clone).
>>
>> Users who only want the submodules to be present in the work tree but
>> not automagically updated could set "submodule.autoupdate=clone" to
>> avoid the extra cost of updating the work tree every time they switch
>> between commits. Now that Heiko's config-from-commit changes are in
>> master, someone could easily add that to fetch and clone as the first
>> step. We could also teach clone to make "submodule.autoupdate=true"
>> imply --recursive and execute the "git submodule" command to update
>> the work tree as a first step until the recursive checkout patches
>> are ready.
>>
>> Does that make sense?
>
> I guess.
>
> So the repo tool has the concepts of groups. I plan to add that to git
> eventually, too.
> i.e. with comma separated list that looks like:
>
>      git clone --submodule-groups=default,x86builds,new-phone-codename
>
> Having a new option there there I would also set the
>
>      submodule.autoupdate=all
>
> implicitly which then enables --recurse-submodules on all supported commands.

And then only submodules contained in these groups would be cloned,
automatically initialized (including those being added to a group by
upstream in the future) and their work trees updated every time the
superproject commit changes? And all submodules that aren't part in
any of these groups would be skipped and neither downloaded nor
updated? Sounds good.

But I'd rather use

     submodule.autoupdate=groups

for that use case. I expect "all" to really mean all submodules,
not only those contained in the selected groups.

> By introducing such a new submodule groups option we don't need to tell
> the users about all the new submodule options, but they can still take
> advantage of them,
> I'd assume.
>
> Does that make sense, too?

Yup.
