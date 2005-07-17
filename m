From: David Lang <david.lang@digitalinsight.com>
Subject: Re: Last mile to 1.0?
Date: Sat, 16 Jul 2005 18:18:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0507161815100.15383@qynat.qvtvafvgr.pbz>
References: <7vwtnqhcfb.fsf@assigned-by-dhcp.cox.net><m18y06pphg.fsf@ebiederm.dsl.xmission.com>
 <7vy8869ryi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: ebiederm@xmission.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 17 03:19:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dtxnz-0007eD-UE
	for gcvg-git@gmane.org; Sun, 17 Jul 2005 03:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVGQBSu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 21:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVGQBSu
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 21:18:50 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:16322 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S261911AbVGQBSo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2005 21:18:44 -0400
Received: from wlvims01.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Sat, 16 Jul 2005 18:18:44 -0700
Received: by wlvexc02.diginsite.com with Internet Mail Service (5.5.2657.72)
	id <34M2VSQM>; Sat, 16 Jul 2005 18:18:26 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id 34ML5HYG; Sat, 16 Jul 2005 18:18:24 -0700
To: Junio C Hamano <junkio@cox.net>
X-X-Sender: dlang@dlang.diginsite.com
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <7vy8869ryi.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 16 Jul 2005, Junio C Hamano wrote:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> Junio C Hamano <junkio@cox.net> writes:
>>>
>>>    - Anonymous pull from packed archives on remote sites via
>>>      non-rsync, non-ssh transport.  ...
>>>      ... but we may also end up wanting something HTTP
>>>      reachable.
>>
>> For this we need a cgi script that will generate an appropriate
>> pack.
>
> I agree that nothing would beat a pack customized for each
> puller from the bandwidth point of view.  I like the general
> idea of git-daemon Linus did and the cgi script you suggest, but
> I wonder what the CPU/disk load implications for the server.
>

I think you need to nail down the various scenerios that people will be 
useing here.

a very common one will be prople who want to setup a cron job to update 
their local tree nightly, in this case having a pre-generated pack file 
with each day's updates will save a significant amount of processing 
power.

would it make sense to have it do something along the lines of sending the 
day;s pack file plus a small number of individual object (even if the pack 
file will partially duplicate object the puller already has)

David Lang


-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
