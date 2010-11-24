From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Inexplicably deteriorating performance of Git repositories on
 Windows
Date: Wed, 24 Nov 2010 16:18:31 -0500
Message-ID: <4CED8127.8060505@gmail.com>
References: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>	<AANLkTikXkWvHrc7=FjePfX5WyyNF1U=KH2DBCU+CcVu6@mail.gmail.com>	<AANLkTimky3Ojc5w3PcCoJOs=NMfMpgUWUDcx+ry6h1dF@mail.gmail.com>	<AANLkTim-1uKTVacr1N=9bhZ+=ngggrJS=GD-YNjkSuBR@mail.gmail.com>	<4CED488A.2070507@workspacewhiz.com> <AANLkTi=X724OJgUvG0Ggu3OwxyaJprr9CLL+t+x=MbTO@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Wilbert van Dolleweerd <wilbert@arentheym.com>,
	Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 22:18:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLMjr-0006BA-Rt
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 22:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528Ab0KXVSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 16:18:47 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35706 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558Ab0KXVSq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 16:18:46 -0500
Received: by vws2 with SMTP id 2so181890vws.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 13:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=gGqv1Bb5ioLMSRecK/FrAOuNrb7G1SD957YM17XYi7U=;
        b=GeNgOUhdMytKbjZNnFk7LRvVjloAs6brOa95n6dtf0mvHETTSckz8aDwPfAucGhVwg
         6syesRPew53Cs5G5PbAc8BgtfZOUqXgFYxXFLSs88Bk6G41NFmo2eVsWIcwVj2DlcDJp
         sgP6CKstDBUg9ozhQVIMDkgNWsgujhSXpYJBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=N3JgPCAMlynFfTGkEWwvDuqrXrX2+s8h7Jq3186fm6t2VPjGJCn5dvBBOgNG9xCi1b
         11HwNBAV1jWxx3z6tQgkIkl+xIxr/+8i46e8A6mj1Cx1fYrHVLNo2wntFoXgUsaIwPpX
         0NgScaeZtFk4T77fqR5XHn3WZi6Msy3rbCucY=
Received: by 10.220.181.1 with SMTP id bw1mr2633431vcb.38.1290633524518;
        Wed, 24 Nov 2010 13:18:44 -0800 (PST)
Received: from [10.0.1.131] (cpe-67-248-185-165.nycap.res.rr.com [67.248.185.165])
        by mx.google.com with ESMTPS id u6sm2824056vby.7.2010.11.24.13.18.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Nov 2010 13:18:39 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101030 Icedove/3.0.10
In-Reply-To: <AANLkTi=X724OJgUvG0Ggu3OwxyaJprr9CLL+t+x=MbTO@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162086>

On 11/24/2010 04:00 PM, Dun Peal wrote:
> On Wed, Nov 24, 2010 at 5:16 PM, Joshua Jensen
> <jjensen@workspacewhiz.com>  wrote:
>> Whenever I want to know exactly what is going on with disk access, I
>> download Process Monitor from http://sysinternals.com/.
>>
>> In order to just show disk access, I filter entries that begin with TCP,
>> UDP, and Reg out.
>>
>> Josh
>
> Thanks, we tried that and we don't see a whole lot of disk activity on
> the "fast" machines.
>
> One emerging theory is that the "slow" Windows machines differ from
> the "fast" ones by how their disk cache works.
>
> So `git status` on a large tree heavily depends on caching. Without
> it, it would be slow; with it, it's much faster.
>
> We verified that part since when we reboot a fast Windows machine, the
> first run of `git status` is slow (~30s) but the next one is much
> faster (~5s).
>
> We see a similar phenomenon on Linux: the first run is always
> significantly slower than the others.
>
> On slow Windows machines, this difference is much less pronounced.
>
> On a typical "slow" machine, if you clone the repo, the first run of
> `git status` on it would already be fast (5s). But then your reboot,
> and the first run is slow, but then it only gets up to 14s. And you
> can't get back the 5s latency unless you re-clone the repo and status
> the fresh clone.
>
> So my theory is that there's a cache that on the "fast" machines
> aggressively caches the entire tree on a regular `git status` run. On
> such a machine, it's enough to run `git status` once, and after that
> initial cold run, the rest will be warm... until you reboot the
> machine, rinse, repeat.
>
> On a slow machine, however, cache isn't so aggressive. It might be
> write-oriented. So when you write out a whole new working tree, that
> tree gets cached as it is written. And for the remainder of the
> lifetime of that cache, you get the fully-cached performance you see
> on the "fast" machines. But then you reboot the machine, and lose the
> cache. And since the caching process isn't aggressive, any number of
> `git status` runs won't get you back to the fully cached state. You
> will only get that on a newly written working copy.
>
> What do you think?

How much memory do the fast and slow machines have? How much memory will 
windows use for disk caching? Is it possible that your normal work flow 
between status' are forcing the caches to pruned due to memory pressure?
