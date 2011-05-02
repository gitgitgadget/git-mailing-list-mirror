From: Stephen Kelly <steveire@gmail.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Mon, 2 May 2011 21:26:35 +0200
Message-ID: <BANLkTinqxy6jCJLNVPKmMW3CErbfN7Hm=g@mail.gmail.com>
References: <ih1449$ul6$1@dough.gmane.org>
	<7v62tjs66r.fsf@alter.siamese.dyndns.org>
	<20110120203840.GA11468@sigill.intra.peff.net>
	<7vbp3bqmiy.fsf@alter.siamese.dyndns.org>
	<20110120215456.GB11468@sigill.intra.peff.net>
	<AANLkTikBbSt5_WdbuE8a96w1pWBCYLNjMCUCBThjdLdG@mail.gmail.com>
	<7vk4hyp38i.fsf@alter.siamese.dyndns.org>
	<AANLkTikmbWkpjioARZrmySpLM8t7kqCX0v1+NKibk_ar@mail.gmail.com>
	<AANLkTinRcmevXz3zV0wtxd7+Q3F4zcH2AZOQk1XVxYXa@mail.gmail.com>
	<BANLkTim1gW_L-9DKo9p_VFQFUBUGWAPxoA@mail.gmail.com>
	<BANLkTinKDHM-RU2wqZECFcjQEoRWADnTGQ@mail.gmail.com>
	<BANLkTimFas5YLt37RLuCppkQ4ZGhmj56Cg@mail.gmail.com>
	<BANLkTinkR+jEKkno30fiHBZ-PMVvvv7FxQ@mail.gmail.com>
	<BANLkTi=DgXrWZ0ObBYi2mgk-+8w8iXM7VQ@mail.gmail.com>
	<BANLkTimLnggco_+mQZ2_T_myAHsDD-=g1w@mail.gmail.com>
	<BANLkTikxS-_9h4rBdbbJ2e-RkjMWyiC1Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon May 02 21:33:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGyrh-0000Iz-1r
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 21:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456Ab1EBTc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 15:32:59 -0400
Received: from mail-bw0-f52.google.com ([209.85.214.52]:44952 "EHLO
	mail-bw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab1EBTc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 15:32:58 -0400
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 May 2011 15:32:58 EDT
Received: by bwj24 with SMTP id 24so8020976bwj.11
        for <git@vger.kernel.org>; Mon, 02 May 2011 12:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=LixKUoopwy4Z99VHm4Ywu6CNIude9AxbjakMGiZ4SO8=;
        b=W/qctXmE/X7LoD5Gbtq9SZVKaqPw+57H2hges6TRiPP4rQQYsCNMeEu+v5UQWJlFIZ
         5eTNpgYoK4M1BD/mEQ1p8zcJFAP8knpi1T/v4UUP0DgT/c5IftRmAllddIvpLW/faQLD
         gKTItsAnZZC+ankIqI58WcR2QQiLjI41MvX7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=YLEPNu9ELzmfO4i2HWedH54ZGNLzTs0XU+75Dv0Sj51a5bXfoML/YakEzVWSbgz8d8
         18Mb4q39iYewo2XDQm8vPjPPXP963ZiSBVb4E/TN5lzJ5ahx0Dna8s0COuSUjIX3Nmin
         OholnzLx3Xf0SkiGlHHzye9WHxZhjmIp3XR0M=
Received: by 10.204.1.134 with SMTP id 6mr442027bkf.39.1304364395227; Mon, 02
 May 2011 12:26:35 -0700 (PDT)
Received: by 10.204.120.195 with HTTP; Mon, 2 May 2011 12:26:35 -0700 (PDT)
In-Reply-To: <BANLkTikxS-_9h4rBdbbJ2e-RkjMWyiC1Mg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172623>

On Wed, Apr 27, 2011 at 2:49 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Wed, Apr 27, 2011 at 2:21 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> On Wed, Apr 27, 2011 at 1:29 PM, Stephen Kelly <steveire@gmail.com> wrote:
>>> On Wed, Apr 27, 2011 at 11:48 AM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>> No problems here:
>>>
>>> I had another go.
>>>
>>> mkdir remote
>>> cd remote/
>>> git init --bare
>>> cd ../
>>> git clone remote/ alice
>>> cd alice/
>>> echo test >> file
>>> git add file
>>> git commit -am w
>>> git push origin master
>>> echo test >> file
>>> git commit -am w
>>> git branch HEAD
>>
>> I'll stop you here. You reproduce the issue a lot simpler:
>>
>> git init foo &&
>> cd foo &&
>> echo "foo" > bar &&
>> git add bar &&
>> git commit -m. &&
>> git branch HEAD &&
>> gitk
>>
>> No need to involve remote branches. While remote branches makes the
>> issue worse, because you can get in a situation where gitk doesn't
>> when someone else made a nasty branch, and you fetched it.
>>
>> The real problem is that "git rev-parse HEAD" outputs "warning:
>> refname 'HEAD' is ambiguous." to stderr (even if stderr is a non-tty),
>> and gitk does not like that.
>>
>> This can be fixed by either doing "git -c core.warnambiguousrefs=0
>> rev-parse HEAD", which strikes me as ugly, or by making sure that we
>> don't issue this warning when not attached to a tty:
>
> Of course, a third (and probably even better) option is to make gitk
> warn about the ambiguous refname (like other commands will), but not
> treat it as a fatal problem. But I'm not motivated enough to give that
> solution a stab myself.
>
> Not outputting that warning might be a regression for other users of
> rev-parse (and/or the underlying mechanics).
>

Ok, if you can't see in the code why a branch called HEAD might
corrupt the remote and I can't demonstrate it with a testcase, maybe
it's not an issue anymore, I don't know.

Hopefully the relevant people saw the side issues brought up such as
this ambiguous ref issue. After all, there's no other way to track
those issues.

Thanks for the investigation and help,

Steve.
