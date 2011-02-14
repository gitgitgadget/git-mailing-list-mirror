From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 14 Feb 2011 17:04:31 +0100
Message-ID: <4D59528F.6030202@drmicha.warpmail.net>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>	<20110213193738.GA26868@elie>	<7v8vxjwnhj.fsf@alter.siamese.dyndns.org>	<87k4h34bhj.fsf@catnip.gol.com>	<7vr5bbupj4.fsf@alter.siamese.dyndns.org>	<AANLkTi=PDhVgpTeFjTxFuVJGbAKTHzHhsNVcquqSD3Qq@mail.gmail.com>	<4D58D2DF.1050205@viscovery.net>	<AANLkTikTfyHBOvQmjhT8yTziL4R67+AAk0O-Nk1tBSaL@mail.gmail.com>	<4D5906FD.7030502@drmicha.warpmail.net>	<AANLkTi=RcJfEGv966VCrOMPE640xyyw1wEFFkdA9fFWq@mail.gmail.com>	<4D59316E.5090203@drmicha.warpmail.net>	<AANLkTikWsNgL6dSHueGCXw0jH4hnvai81X=EQERuw3Qi@mail.gmail.com>	<4D594911.40409@drmicha.warpmail.net> <AANLkTi=cvObd83_5qiUxLKmVxiTMP2kgMfXaRb3uo4YY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 17:07:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp0xl-0006JJ-8m
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 17:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755748Ab1BNQHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 11:07:38 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39630 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751201Ab1BNQHi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 11:07:38 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 37B6A205FD;
	Mon, 14 Feb 2011 11:07:37 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 14 Feb 2011 11:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=mxj0WLQCUCT0Qnwhq+Vnuwm4Uik=; b=e7dSL7oavze+pdUFtN1Ss7d4kx5IHia3GvzuEjKEdTqUToE3Y0cwWVeIqTcV77ow2ewGOkQMTVsSyJa2htyObAl3ZokUE9W9vnuzAhS1fLAwwTttuqaOZV2Waa1FSVFKzP1J/Zb7VKObAMJa/tzPcPQ92X9mZHvwCmTRdOG3Iwc=
X-Sasl-enc: XfBiowDs/aUmlZGoxk4Yysf4nTCf4X/YCQqoVEx5j9z1 1297699656
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5F718443BC3;
	Mon, 14 Feb 2011 11:07:35 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTi=cvObd83_5qiUxLKmVxiTMP2kgMfXaRb3uo4YY@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166731>

Felipe Contreras venit, vidit, dixit 14.02.2011 17:00:
> On Mon, Feb 14, 2011 at 5:24 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Felipe Contreras venit, vidit, dixit 14.02.2011 15:17:
>>> On Mon, Feb 14, 2011 at 3:43 PM, Michael J Gruber
>>> <git@drmicha.warpmail.net> wrote:
>>>> Nguyen Thai Ngoc Duy venit, vidit, dixit 14.02.2011 14:14:
>>>>> On Mon, Feb 14, 2011 at 5:42 PM, Michael J Gruber
>>>>> <git@drmicha.warpmail.net> wrote:
>>>>>> Full disclaimer: I have an alias "staged" for "diff --cached" myself...
>>>>>
>>>>> Be careful with your fingers. There's a command named "git stage".
>>>>
>>>> I know. Can we remove it as part of 1.8.0? It's our only builtin alias.
>>>
>>> I have proposed before to extend 'git stage', so you can do 'git stage
>>> diff', or if you alias 'git stage' to 'git s', just 'git s diff'. This
>>> would not conflict with the old behavior of 'git stage $file'.
> 
> [...]
> 
>> In principle I like this a lot: a set of commands operating on/with the
>> stage/index/cache consistently. It think it's similar in (good) spirit
>> to our earlier attempts at INDEX and WORKTREE pseudo-revs, trying to
>> give that somewhat nebulous (for noobs) index a more concrete
>> "appearance", not hidden away in options (--index, --cached) and
>> defaults (diff against index by default).
>>
>> In our case, however, I think the design principle deviates from our
>> common form:
>>
>> git foo bar
>>
>> usually means "do foo" to "bar", as most of our common commands are
>> verbs (being applied to the object "bar"). When it comes to subcommands
>> we do have inconsistencies already (double-dashed vs. undashed, e.g.),
>> but I'd prefer fewer ;)
> 
> Except 'git branch', 'git tag', 'git remote', 'git stash', and 'git
> submodule'. In fact, every logical object in git seems to have their
> own command, except the stage.
> 

Yes, remote, stash and submodule are the ones with the different
subcommand handling I mentioned: the subcommand is the verb, and
specified undashed.

We have other commands with double-dashed (i.e. option) subcommands,
such as "brach --set-upstream", and others single-dashed, such as "tag -v".

Note that branch, tag and stash are verbs as well as nouns.

I just think that "git verb object" is the more prevalent order, so that
we should move in that direction if we want make things better. Other
than that I would have no objection against "git object verb".

Michael
