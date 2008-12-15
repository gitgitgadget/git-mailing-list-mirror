From: david@lang.hm
Subject: Re: is gitosis secure?
Date: Sun, 14 Dec 2008 17:29:52 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0812141720510.17688@asgard.lang.hm>
References: <200812090956.48613.thomas@koch.ro> <bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com> <87hc58hwmi.fsf@hades.wkstn.nix> <gi1qsl$22p$1@ger.gmane.org> <m3zlizdofy.fsf@localhost.localdomain> <87prju5m6s.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jakub Narebski <jnareb@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org,
	Thomas Koch <thomas@koch.ro>
To: Nix <nix@esperi.org.uk>
X-From: git-owner@vger.kernel.org Mon Dec 15 01:30:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC1Lk-0006g3-Cm
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 01:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbYLOA25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 19:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbYLOA25
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 19:28:57 -0500
Received: from mail.lang.hm ([64.81.33.126]:53524 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961AbYLOA24 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 19:28:56 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id mBF0SdSS003102;
	Sun, 14 Dec 2008 16:28:39 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <87prju5m6s.fsf@hades.wkstn.nix>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103115>

On Mon, 15 Dec 2008, Nix wrote:

> On 14 Dec 2008, Jakub Narebski spake thusly:
>> BTW. is outgoing SSH transport (from network to outside) blocked as
>> well?
>
> *No* ports are open. All they have is a (non-transparent) buggy HTTP
> proxy. These guys really don't get the Internet, despite their sales
> literature banging on endlessly about it.
>
> Looks like a lot of git-bundling is in my future.

no ports being open and a non-transparent HTTP proxy doesn't tell me that 
they don't get the Internet. They could get the Internet just fine and be 
suitably paranoid about it. Controlling outbound traffic is actually a 
good thing in the current era of botnets (it prevents any of the machines 
in that company from participating in a botnet if they can't reach the 
command system)

the fact that the proxy is buggy could be an issue (I'm curious about what 
types of bugs you are running into, what you see as a bug may not be)



if there is a business reason for the developers on that network to be 
accessing resources on the Internet there should be a way to request that 
the appropriate ports get opened. if the answer from the security folks is 
'no' you should ask them why not and what could be done to get the job 
done.

it may be that they don't want to provide access out from a bunch of 
desktops. If that is the case it may be appropriate to build a box to put 
into the DMZ that pulls from the upstream and then the inside desktops 
pull from this gateway system.


the saying goes "don't attribute to malice what can be explained by 
incompetence", but along the same lines in the security field, don't 
attribute to incompetence what can be explained by people doing their jobs 
that are ignorant of the requirements. they may also be operating under 
constraints that you don't know about.

David Lang
