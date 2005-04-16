From: David Lang <david.lang@digitalinsight.com>
Subject: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 16:08:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0504161606590.22652@qynat.qvtvafvgr.pbz>
References: <20050416131528.GB19908@elte.hu><Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
 <1113679421.28612.16.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 01:06:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMwMo-0002Y6-DR
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 01:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVDPXKB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 19:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVDPXKB
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 19:10:01 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:64421 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261187AbVDPXJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 19:09:59 -0400
Received: from atlims01.diginsite.com by warden2.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Sat, 16 Apr 2005 16:04:51 -0700
Received: by ATHEXC01 with Internet Mail Service (5.5.2657.72)
	id <24Z81HCB>; Sat, 16 Apr 2005 19:08:58 -0400
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id 29YX150Y; Sat, 16 Apr 2005 16:08:58 -0700
To: Thomas Gleixner <tglx@linutronix.de>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <1113679421.28612.16.camel@tglx.tec.linutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 16 Apr 2005, Thomas Gleixner wrote:

> On Sat, 2005-04-16 at 10:04 -0700, Linus Torvalds wrote:
>
>> So I'd _almost_ suggest just starting from a clean slate after all.
>> Keeping the old history around, of course, but not necessarily putting it
>> into git now. It would just force everybody who is getting used to git in
>> the first place to work with a 3GB archive from day one, rather than
>> getting into it a bit more gradually.
>
> Sure. We can export the 2.6.12-rc2 version of the git'ed history tree
> and start from there. Then the first changeset has a parent, which just
> lives in a different place.
> Thats the only difference to your repository, but it would change the
> sha1 sums of all your changesets.

at least start with a full release. say 2.6.11

the history won't be blank, but it's far more likly that people will care 
about the details between 2.6.11 and 2.6.12 and will want to go back 
before -rc2

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
