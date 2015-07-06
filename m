From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: end-of-line diff checkout direction dependence problem
Date: Mon, 6 Jul 2015 08:53:20 +0200
Message-ID: <559A25E0.1090908@web.de>
References: <5592A3D9.3080706@ivision.de> <5593F73E.60305@ivision.de>
 <559543E9.5040706@ivision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: tvie@ivision.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 08:53:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC0HW-0003Hs-9f
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 08:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbbGFGx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 02:53:29 -0400
Received: from mout.web.de ([212.227.15.14]:65056 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbbGFGx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 02:53:27 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0M6xc5-1Yrb5E10SL-00wmxm; Mon, 06 Jul 2015 08:53:25
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.0.1
In-Reply-To: <559543E9.5040706@ivision.de>
X-Provags-ID: V03:K0:Wc0Dh2Kofb+x3RmQxVwZp6JNG5FzKUqU1wFDysHcA8fMUczEUMH
 W2SJuvQpyFl8MNEY8j7+L0dKHFZT89x0pQmNBtBzsLwJt/hNYEpUjoGpRE88YU7qixvW5bW
 1ADBQuGWiLMpwYJStYkNYOok6Mv2FJ+XLNyiHg1PxOXglcaLxDzTIE75iG4hdqppEcqo4nE
 veie0ndgENw8Bb+ERg7qA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mfkbNBHf5Yc=:DFdxwV7J7tZYeeCaVZM5yN
 9WnC5vufdd+DSPtskcYNRPDilkR/7KA6/AbqEztH+lZ7PbTBb4es1bm0Hu+c5WsErkZYHpddu
 iy3yUuYMusu+GPb+zaTU3/BDdFTtkRrhUbsWjD2K9e29Khlksc+1bEx2GM4xvT/HMy5vAAmJv
 Byj7FA2js7UqU4JnlpsESAdx08gELfINdmzmVFO1IH4R00D5WqwTt2CuPSfVzq7KN6pQoqteH
 4RaOagncbpeqnKsDttFAzHG7IkOykZddwaNfgB/QT8s9mnzwtnsZbNovLcHrhzvHXgxGwyyfO
 vzB258iD2aMudUie37uIEdrlDY1FkVaoU4xMP1S/Z4JMeUjB2Xiky4R/ZDue12+nQUlTMvJDo
 fojHVmNLXYF5Fho4//cjoEwagdHYPQUj4lv+AIvUZOEoh/c3VsUSVlw15g4TdGCn3b3uXFzVa
 NrZpF1zyEb2XUl3/Ee1b18ua3a32Y83PMMwurttu6sebCp3c4M/uQS59Oee8NUtqnSfGnG1LZ
 uVzvtrMMym18vB4J/Iec65tX2Wx3lOM65kC3/LEFYCeuieBt/V5y8AOOLRDpPADVuqGR1I62o
 S3zhMwEs2pw/VKgcReCv6YZpqIsjBPnfeSjk85w1KBGuFAoVO9+0qBuYy0yJDFkO7Vy9gdCKs
 HkLnXqYzimbFESGbac313OR7E3LsjfDK/hXipcDBHYFxhDW49y9ySlBJe3KRt0vsQ/qo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273377>

On 2015-07-02 16.00, Thomas Vieten wrote:
[]
> see the file attachend to the end of this message
Thanks for the info
>
>> It may be, that you need to "nornalize" your repo:
>>
> in principle we know all this.
> What is remarkable that we are able to checkout a version of master which is
> not consistent with the repo, and more, dependent from the checkout direction
> (if the direction is the positive or negative history in time). And on the
> other hand we can checkout a version of master which is in sync with the master.
>
> Normally such conflicts with not normalised repos appear immediately also in
> positive history direction. And then it is possible to detect them.
> The other way around - negative history and diffs - it causes a big questionmark.
>
> On the other hand this would lead to the mandatory work flow advice: "Always
> normalize the repository after changes within the gitattributes file"
Yes, I think this sounds reasonable, and I think the documentations says this.
But it is a manual step, which is typically done only once.
It there anything which can be improved here ?
> And then: Should this then not be automatically be done somehow in the
> background by git ?
This could make sense, but the word "background" should mean visible to the user ?
Recently we got the "untracked cache" into Git, which keeps track about the
.gitignore files
A similar logic can be used to keep track of the .gitattributes file(s) (There
can be more than one)
Patches are welcome.
>
> Reasoning: if the "git machine" is causing this behaviour systematically,
> shouldn't the machine itself have compensation, correction?
>
Question 1: The documentation should be clear enough:
 Whenever someone "introduces .gitattributes," the repo should be normalized.

> Depending on your point of view this could be seen as a bug.
I have run into this myself, but never in a reproducable way.
The day I can reproduce it, I may send a patch.
Or, somebody else sends a patch before that day.
>
> There is also a big question open: will normalisation really help ? Because
> there must be one commit with the new gitattributes and then you normalize.
To my experience it does.
 Normalizing means one single commit (not 2), including the .gitattributes and
the normalized files.
Question 2:
Is there something in the documentation that could be improved.
> But the "wrong diff" is in the repo and will cause the problem when going back
> to master in the negative direction.
> This is how understand it up to now.
>
> But at this point git is complex and we are not really the experts.
>
> best regards
>
> Thomas V.
>
Thanks for the report(s)
