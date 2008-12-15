From: david@lang.hm
Subject: Re: is gitosis secure?
Date: Sun, 14 Dec 2008 16:54:59 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0812141650100.17688@asgard.lang.hm>
References: <200812090956.48613.thomas@koch.ro> <bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com> <87hc58hwmi.fsf@hades.wkstn.nix> <gi1qsl$22p$1@ger.gmane.org> <alpine.DEB.1.10.0812132126470.17688@asgard.lang.hm> <4944D4F7.7050501@siamect.com>
 <alpine.DEB.1.10.0812140304320.17688@asgard.lang.hm> <m3vdtndo9b.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: martin <martin@siamect.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 00:55:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC0no-0006HS-Up
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 00:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbYLNXxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 18:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbYLNXxz
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 18:53:55 -0500
Received: from mail.lang.hm ([64.81.33.126]:52152 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724AbYLNXxy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 18:53:54 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id mBENrk9u002999;
	Sun, 14 Dec 2008 15:53:46 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <m3vdtndo9b.fsf@localhost.localdomain>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103109>

On Sun, 14 Dec 2008, Jakub Narebski wrote:

> david@lang.hm writes:
>> On Sun, 14 Dec 2008, martin wrote:
>>
>>> Dear David.
>>> Why do you trust VPN more than the SSH?
>>> I ask because I have just removed the "first VPN then SSH" solution
>>> in favor for a SSH only solution using Gitosis just to get rid of
>>> the VPN which I believe is less secure than SSH (well until I read
>>> you comments below).
>>> I thought I was doing something right for once but maybe I'm not?
>>> Thanks and best regards
>>> Martin
>>
>> in part it's that a VPN is a single point of control for all remote
>> access.
>>
>> If you use ssh you end up exposing all the individual machines
>>
>> 1. data leakage of just what machines exist to possibly hostile users.
>
> Errr... what? One of established practices is expose only _one_
> machine to outside; you have to SSH to gateway.

that works for sysadmin access to a box, it doesn't work for git push 
(unless that box also happens to be your git repository). multiply by a 
few dozen different applications that all take the attitude 'just us SSH 
and you are secure' and you end up with a bunch of machines that _have_ to 
be exposed via SSH.

>> 2. the many machines are configured seperatly, frequently by different
>> people. this makes it far more likely that sometime some machine will
>> get misconfigured.
>
> See above.
>
>> 3. people who are focused on providing features have a strong
>> temptation to cut corners and just test that the feature works and not
>> test that everything that isn't supposed to work actually doesn't
>> work. as a result, in many companies there is a deliberate seperation
>> (and tension) between a group focused on controlling and auditing
>> access and one that is focused on creating fucntionality and features.
>
> And that differs from VPN in what way?

the VPN is typically (but not always) run by the group who is focused on 
controlling and auditing access.

>> also from a polical/social point of view everyone recognises that if
>> you grant someone VPN access you are trusting them, but people don't
>> seem to think the same way with ssh.
>
> Errr... what?  I think everybody knows that unrestricted SSH access
> (without limiting done by shell used) means that you trust user.

you would be surprised.

I'm not saying that SSH is bad for all uses by any means. I'm responding 
to the people who seemd to be thinking that anyone who didn't like the 
'use SSH' option are luddites and just don't know what they are doing. 
different networks can have different stances and all be right (for their 
environment)

David Lang
