From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: obnoxious CLI complaints
Date: Sat, 12 Sep 2009 18:35:59 -0400
Message-ID: <4AAC224F.9080606@gmail.com>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>	 <m3fxavvl5k.fsf@localhost.localdomain>	 <ef38762f0909091709t7336d86dkd2f175e5b3a6a3f@mail.gmail.com>	 <20090912103156.GA30385@dpotapov.dyndns.org>	 <43d8ce650909121132n76cda485ycd53a0497e397960@mail.gmail.com>	 <20090912214428.GB30385@dpotapov.dyndns.org> <43d8ce650909121521m3dbac12co7f5f2dcaf15190e7@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Brendan Miller <catphive@catphive.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 00:36:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmbCU-0003h5-Qe
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 00:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbZILWf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 18:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbZILWf6
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 18:35:58 -0400
Received: from mail-yw0-f174.google.com ([209.85.211.174]:44460 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbZILWf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 18:35:58 -0400
Received: by ywh4 with SMTP id 4so2856140ywh.5
        for <git@vger.kernel.org>; Sat, 12 Sep 2009 15:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=zta+mMMg6SbQHGIjNGUf8U7mwVwpEtaHvtZDXqRo+hA=;
        b=I0E1Rl4wF0ZEptXETnOzZ9AzsplmJ1VSzeNLvxKki8XmmwsnRbMtOV6w6ugiiw880M
         g42EcC6DGHeeGhJL13MqM9rEi923ZxifBHGIpZ9ZpPjdFPsxHCcmOcUTtKVUx49/u2gP
         /iVOIAdCDafxx+JE3l2lfSHbU7w9CquyGWaj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=ZvZMPKH6g5NKRnUpx6vSkp4rFs+IWf2PXNEZ9ARLFfhku9rChtggLDk1OsN1caJuP4
         vRWkjVynPNO0JOC2F5njznA+C9Wz6hc5jV6uX5QPKh2V4Eg/bu154XAWJ/6nxcz8paTg
         rsBgqYDkB+OMVap7QvG+QDTFOxNmxi5SGhaQA=
Received: by 10.90.211.6 with SMTP id j6mr2686651agg.86.1252794961273;
        Sat, 12 Sep 2009 15:36:01 -0700 (PDT)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 32sm3182948aga.30.2009.09.12.15.36.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Sep 2009 15:36:00 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <43d8ce650909121521m3dbac12co7f5f2dcaf15190e7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128308>

John Tapsell wrote:
> 2009/9/13 Dmitry Potapov <dpotapov@gmail.com>:
>> On Sat, Sep 12, 2009 at 09:32:09PM +0300, John Tapsell wrote:
>>> 2009/9/12 Dmitry Potapov <dpotapov@gmail.com>:
>>>> On Wed, Sep 09, 2009 at 05:09:31PM -0700, Brendan Miller wrote:
>>>>> On Wed, Sep 9, 2009 at 2:54 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>>>>> Brendan Miller <catphive@catphive.net> writes:
>>>>> Is the goal of interface design to make
>>>>> it difficult so I need to learn a lot of things, or easy so I can
>>>>> remain blissfully ignorant but still do what I want?
>>>> Neither. You cannot get what unless you have specified what you want,
>>>> and for that you have to learn how to say that. Having good defaults is
>>>> very important, but the problem with choosing them is that people have
>>>> different preferences about them. For instance, you wanted the default
>>>> prefix for git-archive to be $myproject. For me, a good default would be
>>>> either $tag_name, or $myproject-$tag_name, or empty (as it is now!). So,
>>>> what you propose is *never* a good default for me. Moreover, changing
>>>> any default will cause a lot of pain for other people who use Git now.
>>>> Besides, writing something like --prefix='' is very ugly. So, the
>>>> current default makes perfect sense.
>>> Ah, great logic.  You can't find a default that will suit everyone,
>>> therefore don't bother.
>> I did not say "don't bother". On contrary, I said that defaults are very
>> important, but, in this case, the current default makes far more sense
>> that what was proposed by Brendan.
>>
>>>>> Yeah, I've been reading them. I'm saying that the docs are a crutch.
>>>>> RTFM is the problem not the solution. It makes the user do more work
>>>>> to avoid fixing usability issues.
>>>> A usability issue exists when a person knows how to do that, but it is
>>>> inconvenient or error-prone; or when a learning curve is too steep.
>>>> But when someone cannot use, let's say, a compiler, because he or she
>>>> refuses to read to learn the language, it is not a usability issue.
>>> It's a usability issue when it doesn't just do the right thing in the
>>> majority of cases and lets you specify what you want it to do in the
>>> rest of the cases.
>> It does the right thing for me, and not just in most cases, it does so
>> in _all_ cases, because it does exactly it is told to do. And it is a
>> very important characteristics for any VCS, otherwise you can mess up
>> things easily. What is also good about Git is that it does not require
>> much keystrokes to do even rather complex stuff. And many defaults and
>> commands are configurable, so you can adjust it to your workflow. So,
>> I am not sure what your problem is.
> 
> Because I wouldn't call this just a few keystrokes to do the common case:
> 
>     git archive --format=tar --prefix=HEAD/ HEAD | gzip > head.tar.gz
> 
> I honestly don't understand the backlash against Brenden's point that
> this could be made a bit simpler.

Be made simpler for whom? The first rule of defaults is that they are 
never correct.

And, to every one, if you don;t think like the way <SOME_PROGRAM> has 
it's defaults set and the developer(s) don't agree to change the default 
for _everyone_ to what _you_ like, you can still use your shell's alias 
facility to fix the situation for your own use case.

To channel Junio, why are we still having this discussion?
