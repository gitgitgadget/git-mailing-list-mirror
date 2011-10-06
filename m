From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: git-cherry-pick and author field in version 1.7.6.4
Date: Thu, 06 Oct 2011 15:34:15 +0200
Organization: 6WIND
Message-ID: <4E8DAE57.60705@6wind.com>
References: <4E8C6F0E.7000508@6wind.com> <20111005174138.GA22962@sigill.intra.peff.net> <4E8D5DEA.9010500@6wind.com> <20111006112742.GA4445@sigill.intra.peff.net> <4E8DA0EE.50208@6wind.com> <20111006132646.GB1792@sigill.intra.peff.net>
Reply-To: nicolas.dichtel@6wind.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 06 15:34:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBo5h-0004rc-JU
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 15:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919Ab1JFNeU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 09:34:20 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36915 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964899Ab1JFNeU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 09:34:20 -0400
Received: by wyg34 with SMTP id 34so2809409wyg.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 06:34:18 -0700 (PDT)
Received: by 10.227.19.210 with SMTP id c18mr1007297wbb.65.1317908058298;
        Thu, 06 Oct 2011 06:34:18 -0700 (PDT)
Received: from [192.168.1.4] (schneckos.n1c0.com. [88.182.61.195])
        by mx.google.com with ESMTPS id i29sm10213962wbp.22.2011.10.06.06.34.16
        (version=SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 06:34:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Thunderbird/3.1.15
In-Reply-To: <20111006132646.GB1792@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182949>

Le 06/10/2011 15:26, Jeff King a =C3=A9crit :
> On Thu, Oct 06, 2011 at 02:37:02PM +0200, Nicolas Dichtel wrote:
>
>>>> Maybe it is related to the problem I've reported in another thread=
:
>>>> http://comments.gmane.org/gmane.comp.version-control.git/182853
>>>
>>> Possibly. That issue is about the commit that comes _after_ the
>>> cherry-pick, and in this instance, things are already wrong for you=
 by
>>> the time the cherry-pick has completed.
>>>
>>> However, the problem has to do with leaving a stale state file in .=
git,
>>> so perhaps a previous partially-completed cherry-pick has left cruf=
t in
>>> .git that is confusing this cherry-pick (i.e., I can't reproduce be=
cause
>>> it is being affected by something that happened before the commands
>>> above). So let's see what Jay comes up with for solving the other
>>> problem, and I suspect it may just fix this issue, too.
>> I think so too. Will wait.
>
> Since you can reproduce this so readily, and since you said it seems =
to
> work with older versions of git, you might try bisecting. There's a
> reasonable chance it will just end up at Jay's CHERRY_PICK_HEAD commi=
t,
> but it might be worth doing.
I've try with another user on the same host and it works, so I end up t=
o my=20
environment config ... and it's my fault: I've some variables set (GITP=
ERLLIB=20
and GIT_EXEC_PATH) that point to an older git version.
Now it works, sorry for the noise!

The second pb, about the author is fixed too.

Regards,
Nicolas
