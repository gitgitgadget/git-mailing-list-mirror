From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 0/5] Submodule Groups
Date: Tue, 1 Dec 2015 23:06:48 +0100
Message-ID: <565E19F8.6060101@web.de>
References: <1448415139-23675-1-git-send-email-sbeller@google.com>
 <5655F166.9090601@web.de>
 <CAGZ79kbd2g9QSuGmyf6Ybp6dCqMfSBqj8WZgfTejXU8OdszaBw@mail.gmail.com>
 <5656096A.7010408@web.de>
 <CAGZ79kZGydm=yYkc-Na2QqpGhLB-KEdh7XyxHPYZqZDzpi3F7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 23:07:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3t4u-0007Ez-4C
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 23:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757132AbbLAWHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 17:07:10 -0500
Received: from mout.web.de ([212.227.17.12]:53610 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757126AbbLAWHH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 17:07:07 -0500
Received: from [192.168.178.41] ([79.211.114.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LbJCQ-1ajIcT2Qgc-00kuqR; Tue, 01 Dec 2015 23:06:51
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <CAGZ79kZGydm=yYkc-Na2QqpGhLB-KEdh7XyxHPYZqZDzpi3F7w@mail.gmail.com>
X-Provags-ID: V03:K0:h49FtSoVm590mluO+4WdBtVTdBD8xgC9anvHNEbAoLGZaF/BGDi
 O3G89WKVkJzYNKGcbWNAtXhg/BNu43ECuvuDATYQhzXTHt4tLA/YfhiFnWoxa2r0ufLG0H/
 YhN/K/RiCQYQkg6Qt+ck3BJ5/yfcgpViICsK+jEt7qHT1kL/OpYJ/3DapVhuatvTh4Xx1gf
 PkZFklbO/e7JDVTTl/JEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Vi6Hq5O3eRI=:97P2cJJpSfPCmobNRkegBd
 j8co25fdz5hFdkgqeAs8fDP3UDgYMp7qgjnBZmjEnoZku6XBEu7tn3Gaq8yaN84+6p1Ti0g+M
 At2HHf/nn5zC0IAYMrxcmrCXiW5dW0CaJUPFuNNLRKkWDyZ/Cl5G+jyqesc1eF2+Ml7XPS4HH
 p4TW466PtN3lq/gvQ+eP2y8W2Qw1OJj+ameViajwpdg2Sn/99wYAq1J+j54cMVO5NxzWvi4BY
 tEQz66oRdWTCIRLqpWr+Sdw39jcIYVjWIIWKn9jB3fDkdfk9FtA+oE39VeRMaR95poO763yeX
 vUqGMnPnc+h3HMUYdOAsLW33rKvSkmIgf/dPFMh26Py/NHHTOEL8Y+EGM7z244IKrhU5qPhZK
 0Hg6HXBbb0V19jWS/oN/LR6zBvplphOFxGCwy8PwQwjsgwVYNKzJ43kcHViZdR9ASwZeqT/6Q
 KAX7JvcFm4i5rjtsXkzpiso1xQNlpP2/GZoIm4qAJzMcOJqfZlcngnyAXMe7wic8l0tFhux2d
 9MPgxSAIO1gm9RsZw63S9ddEHTjQFeOYqefpxY7TAXlftgda8g+3jp84nooQP/208J4an1lGy
 u4H7jpJOKjtTMcnz7x7fgT9hb44iyZDhHWxnioHdRAgctATo08hddiLTnIDHl0jPErW9F6NWK
 PbruSTBoEcXjW7hbE95FQ5Vcf8rqGZxXhFQgm+lk1UzBXaJ2yYOBn0rLp7AF9HvE571veDzQ+
 lPDwDe9M0MpHrAgs1AIu9DFEJSKSp59avA9VcFIDbQPelbWItw9oCYVVUmHPmUTzv90OJflz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281857>

Am 01.12.2015 um 00:54 schrieb Stefan Beller:
> On Wed, Nov 25, 2015 at 11:18 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>>>
>>>> Hmm, I doubt it makes much sense to add the --group option to "git
>>>> submodule init". I'd rather init all submodules and do the group
>>>> handling only in the "git submodule update" command. That way
>>>> upstream can change grouping later without having the user to
>>>> fiddle with her configuration to make that work.
>>>
>
> Mind to elaborate a bit more here?
> The way I understand you now is to pass not --groups to init,
> but init initializes all submodules. But that is worse IMHO

Hmm, I did not mean to imply that "git init" should initialize
all submodules. Me thinks that "git clone --groups" should do
that but then only fetch and checkout those submodules the
chosen groups select. I expect "git submodule init" to be
obsolete when submodule groups (or recursive update) are used,
and that's why IMO it doesn't need a --groups option. (If the
user wants to change the groups later we might need to teach
"git submodule sync" the --groups option though)

> (In the naive way of dealing with groups in the first patch series)
> as then we open up two possibilities:
>   * a submodule which happened to be part of the repository
>     when cloning is added to a new group, which a user has
>     configured, on pulling, this is no problem, we just checkout
>     the desired version of the submodule.

That'll only work automatically when we follow my proposal to
init all those submodules present on clone, because otherwise
it won't be initialized.

>   * a submodule which was not part of the repository at the time
>     of cloning, is added to the superproject with a group the user
>     is subscribed to. This would not be checked out as it is uninitialized
>     on disk.

That's why I propose a mechanism to "auto-init" new submodules
on fetching their gitlink in the superproject. Then both your
groups proposal and my recursive update could make them appear
in the work tree on the next update/checkout. And as fetch is
part of clone, I'd expect clone to "auto-init" all submodules
referenced in gitlinks too.

> So when a change of the set of submodules as defined by groups
> occurs, that is the point in time, when we want to init/fetch/checkout
> these submodules, no?
>
>>>
>>> Well if upstream changes grouping later, you could just run
>>>
>>>       git submodule update --init --groups
>>>
>>> and get what you want?
>>
>>
>> And make life harder than necessary for our users without having
>> a reason for that?
>
> So if upstream changes groups, ideally we want to follow without much
> hassle for the user. So a plain git pull should /just work/. (I am repeating
> myself here I'd guess), we would need to react to that. if we drop the
> --groups call to init, we'd still tell the user to run
>
>       git submodule update

Sure, that's still needed until we have recursive update.

> We do not need --groups any more in a later patch as instead of
> passing in --groups we can detect for `git config submodule.groups`
> to be available or not.

Yes.

> --init should not be needed as when the groups are there we automatically
> init new submodules in the group set?

Right.

>> Except for the URL copying submodule settings
>> on init is wrong, as it sets in stone what happened to be in the
>> .gitmodules file when you ran init and doesn't allow upstream to
>> easily change defaults later. We still do that with the update
>> setting for historical reasons, but I avoided making the same
>> mistake with all the options I added later. You can override
>> these settings if you want or need to, but that shouldn't be
>> necessary by default to make life easier for our users.
>>
>
