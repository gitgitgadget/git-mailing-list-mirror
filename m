From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Mon, 2 May 2011 21:43:05 +0200
Message-ID: <BANLkTinJvt=Nnt8YG-D1wpWKbBei+m+4XA@mail.gmail.com>
References: <ih1449$ul6$1@dough.gmane.org> <7v62tjs66r.fsf@alter.siamese.dyndns.org>
 <20110120203840.GA11468@sigill.intra.peff.net> <7vbp3bqmiy.fsf@alter.siamese.dyndns.org>
 <20110120215456.GB11468@sigill.intra.peff.net> <AANLkTikBbSt5_WdbuE8a96w1pWBCYLNjMCUCBThjdLdG@mail.gmail.com>
 <7vk4hyp38i.fsf@alter.siamese.dyndns.org> <AANLkTikmbWkpjioARZrmySpLM8t7kqCX0v1+NKibk_ar@mail.gmail.com>
 <AANLkTinRcmevXz3zV0wtxd7+Q3F4zcH2AZOQk1XVxYXa@mail.gmail.com>
 <BANLkTim1gW_L-9DKo9p_VFQFUBUGWAPxoA@mail.gmail.com> <BANLkTinKDHM-RU2wqZECFcjQEoRWADnTGQ@mail.gmail.com>
 <BANLkTimFas5YLt37RLuCppkQ4ZGhmj56Cg@mail.gmail.com> <BANLkTinkR+jEKkno30fiHBZ-PMVvvv7FxQ@mail.gmail.com>
 <BANLkTi=DgXrWZ0ObBYi2mgk-+8w8iXM7VQ@mail.gmail.com> <BANLkTimLnggco_+mQZ2_T_myAHsDD-=g1w@mail.gmail.com>
 <BANLkTikxS-_9h4rBdbbJ2e-RkjMWyiC1Mg@mail.gmail.com> <BANLkTinqxy6jCJLNVPKmMW3CErbfN7Hm=g@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 02 21:43:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGz1n-0006lX-6B
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 21:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616Ab1EBTn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 15:43:26 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61967 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241Ab1EBTnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 15:43:25 -0400
Received: by pvg12 with SMTP id 12so3315785pvg.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 12:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=49NojdwJ0wXY0zjy+0KCGLKnvpBPKQtihISDd9vrr0k=;
        b=gbDjLmhPvpYvrOUKdSic15nerYJRfTlIYgSAuR35JAl0nwLVp78KfxTuTd+INFpzUg
         q1z285JLJaf62M8k5PjSXyI+5MB1cHDJ+gXbJZJqNigOZqnTZMwKC5W4FORRAub5blTE
         iWlTtMwddExy1f4LELOpw72jsBOgifqo4kBPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=eF1mXCZarDsya6FfbgNfLax97qSgFywS9C5sYN3iG1Ghp2MufvVs73lNtJOXe71PtD
         DnfU6rHPMzTwWJ50cVjY0DzetBIF6i1twQkDdART6yvdJ898ur92KDRTjO868vF/PWXA
         J6kNbtdw9dtx8Hn8cHowPPQmErCrSXZQjRfOE=
Received: by 10.68.65.110 with SMTP id w14mr1462548pbs.382.1304365405031; Mon,
 02 May 2011 12:43:25 -0700 (PDT)
Received: by 10.68.66.98 with HTTP; Mon, 2 May 2011 12:43:05 -0700 (PDT)
In-Reply-To: <BANLkTinqxy6jCJLNVPKmMW3CErbfN7Hm=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172627>

On Mon, May 2, 2011 at 9:26 PM, Stephen Kelly <steveire@gmail.com> wrote:
> On Wed, Apr 27, 2011 at 2:49 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> On Wed, Apr 27, 2011 at 2:21 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>>> On Wed, Apr 27, 2011 at 1:29 PM, Stephen Kelly <steveire@gmail.com> wrote:
>>>> On Wed, Apr 27, 2011 at 11:48 AM, Felipe Contreras
>>>> <felipe.contreras@gmail.com> wrote:
>>>>> No problems here:
>>>>
>>>> I had another go.
>>>>
>>>> mkdir remote
>>>> cd remote/
>>>> git init --bare
>>>> cd ../
>>>> git clone remote/ alice
>>>> cd alice/
>>>> echo test >> file
>>>> git add file
>>>> git commit -am w
>>>> git push origin master
>>>> echo test >> file
>>>> git commit -am w
>>>> git branch HEAD
>>>
>>> I'll stop you here. You reproduce the issue a lot simpler:
>>>
>>> git init foo &&
>>> cd foo &&
>>> echo "foo" > bar &&
>>> git add bar &&
>>> git commit -m. &&
>>> git branch HEAD &&
>>> gitk
>>>
>>> No need to involve remote branches. While remote branches makes the
>>> issue worse, because you can get in a situation where gitk doesn't
>>> when someone else made a nasty branch, and you fetched it.
>>>
>>> The real problem is that "git rev-parse HEAD" outputs "warning:
>>> refname 'HEAD' is ambiguous." to stderr (even if stderr is a non-tty),
>>> and gitk does not like that.
>>>
>>> This can be fixed by either doing "git -c core.warnambiguousrefs=0
>>> rev-parse HEAD", which strikes me as ugly, or by making sure that we
>>> don't issue this warning when not attached to a tty:
>>
>> Of course, a third (and probably even better) option is to make gitk
>> warn about the ambiguous refname (like other commands will), but not
>> treat it as a fatal problem. But I'm not motivated enough to give that
>> solution a stab myself.
>>
>> Not outputting that warning might be a regression for other users of
>> rev-parse (and/or the underlying mechanics).
>>
>
> Ok, if you can't see in the code why a branch called HEAD might
> corrupt the remote and I can't demonstrate it with a testcase, maybe
> it's not an issue anymore, I don't know.
>

No, it's still an issue, and I believe I pin-pointed it in my first
mail. You can try out the patch I sent, and see if that helps in your
case. If it does, I think it'd make sense to do something (preferably
a bit more robust) with it.
