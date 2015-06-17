From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2] git-checkout.txt: Document "git checkout <pathspec>"
 better
Date: Wed, 17 Jun 2015 18:43:15 +0200
Message-ID: <5581A3A3.1070908@web.de>
References: <558127CB.70603@web.de>
 <CACsJy8CuRcV2Rxaz8Ut4ayW-Hyd8Aao5W4JMc20jcfggOG3d4g@mail.gmail.com>
 <vpq8ubiwqo9.fsf@anie.imag.fr> <mlrmnt$te5$1@ger.gmane.org>
 <vpqoaketusa.fsf@anie.imag.fr> <mlrn9r$9ho$1@ger.gmane.org>
 <vpqtwu6sf4r.fsf@anie.imag.fr> <xmqqoake4akt.fsf@gitster.dls.corp.google.com>
 <xmqqd20u48at.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "Andres G. Aragoneses" <knocte@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 17 18:43:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5GR6-0005bn-P9
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 18:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856AbbFQQnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 12:43:33 -0400
Received: from mout.web.de ([212.227.15.4]:57999 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755875AbbFQQnb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 12:43:31 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0Lz3CK-1Z0mIg03OK-014Bz2; Wed, 17 Jun 2015 18:43:18
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.0.1
In-Reply-To: <xmqqd20u48at.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:Ft4n6rjGaVJZMLwCP1PNJRV/RGRw9B7cl5H0ho2x5a7jyWsUahs
 +a7lVcJMtaYJPoXzWIQ7ewgs69A3Hau+fw8uvYm+TwXNQxOiUsYnp6aK+fMycskenYcgJzn
 1GdPpeXYIPChHi5WoME+b8Z82tJVroKMHG1WHHkb+cfVbJFY42BgAwS8/U3+6tyDbrcaBnQ
 sLHre+WuP3p9M6sFcD6Cw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Zi6FMPVzbto=:xZgKAED9m6+ew9Cu8vRl6l
 MmssfYYjn29Yzn72ia63tSAsqEjVeTI7EsdRxspuNqnAdXpEWD4xw7F4ahK4fhBaM53kWG8Ze
 TwuyesXhnnlU1hIj+gh8TJ++Qir73ONOUqPzQsl3PP40R0dJ0lZixtiLkh67YZoOW8+VIU7Ti
 U7q3XIn3oTRxxpvBSGqbU0BjFX7xqmOfAysZ1I4RMszZnT7bBcCAOgszIpTG1hBg33yVrXbqs
 E+MzSWIqLQdKV3DD1vRydmhMtTo/tMUqXrHbhqMvM7yxfaYw6SYudT6/KOjmFeJN6Q4SGdh6D
 OiK9M8U1NupvMx1LgwWtDKyggdahLdO00SWyiwqCpFtHZKmT6sTK1Qn5Nyt76rwGgrv7eVwBb
 BFGvD7Tcbba42UgiGps6CPMv7Du8JZB87Nb9wgYpS5D4amon9AGj8G91jIzdTNB9wnqxqLUXr
 Xq2fW7Ext9/INWUbgYp3ZOeyXX39RxFSZbhY43TekAovqzDWQZt+Dr0YMeTiQWD1uCFkEr+C0
 zhqyY4EfwiyyxBUOEP4bXdkwDUfhd3H006kdJnhmaOS2NsBx0dpVdhv58isqFt2g5pX6W9D4E
 zEbt7ELPJYTa1hEc91e5QuqFwwdDKbc3i88dhWQvJlP+PA0thlvRN44Du7Tw/uJKSDgU5l+eX
 UmbtJy9goYl+msfsGHQkK9GThLTjmnVe/wvIXZGPSkruyhMxkX+kJ0sO3zt3o+K7zyRs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271868>

On 2015-06-17 18.19, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> Yes, but "Switch branchs or discard local changes" still does not
>>> describe "git checkout HEAD^^^ -- file.txt" (restore to an old state,
>>> but does not switch branch) or "git checkout -- file.txt" (get from the
>>> index).
>>
>> You are right, especially when file.txt does not have any change
>> relative to HEAD, there is no "discarding" going on.  You are
>> actively introducing a change to an unchanged file by checking
>> contents out of a different revision.
>>
>>> To me, "discard local changes" imply that there will be no uncommited
>>> changes on the files implied in the command after the operation.
>>
>> Yup.
> 
> What was discussed in this thread sounded suspiciously familiar ;-).
> 
> Unfortunately "overwrite changes in the working tree" and "discard
> local changes" are equally bad.  As it does not say overwrite with
> what, we invite the original confusion that triggered these threads
> if the reader thought an equally useful but different "overwrites
> with result of merging your local changes to the pristine" (similar
> to what "checkout -m" does) would happen.
> 
> At least, "restore working tree files" without saying "restoring
> them to what state?" is much less likely to cause such a confusion.
> 
> So perhaps
> 
>     git-checkout - Switch branches or restore working tree files
> 
> in the headline, and then explain "restore to what state" in the
> description?
I'm not sure if the "restore" is always the right thing to describe:
'git checkout <commit> -- <path>'
will "copy" the version from another commit into the workspace.

My v3 will probably use the original line:
git-checkout - Checkout a branch or paths to the working tree

(and improve the description)

git-checkout - Checkout a branch or paths to the working tree
