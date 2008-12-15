From: david@lang.hm
Subject: Re: is gitosis secure?
Date: Sun, 14 Dec 2008 16:50:03 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0812141645060.17688@asgard.lang.hm>
References: <200812090956.48613.thomas@koch.ro> <bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com> <87hc58hwmi.fsf@hades.wkstn.nix> <gi1qsl$22p$1@ger.gmane.org> <alpine.DEB.1.10.0812132126470.17688@asgard.lang.hm>
 <m34p17f3bh.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 00:50:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC0j8-00053W-Pr
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 00:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbYLNXs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 18:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbYLNXsz
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 18:48:55 -0500
Received: from mail.lang.hm ([64.81.33.126]:48544 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724AbYLNXsz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 18:48:55 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id mBENmoLw002990;
	Sun, 14 Dec 2008 15:48:50 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <m34p17f3bh.fsf@localhost.localdomain>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103108>

On Sun, 14 Dec 2008, Jakub Narebski wrote:

> david@lang.hm writes:
>
>> this is really a reply to an earlier message that I deleted.
>>
>> the question was asked 'what would the security people like instead of
>> SSH'
>>
>> as a security person who doesn't like how ssh is used for everything,
>> let me list a couple of concerns.
>>
>> ssh is default allow (it lets you run any commands), you can lock it
>> down with effort.
>
> How is VPN better than that?
>
>> ssh defaults to establishing a tunnel between machines that other
>> network traffic can use to bypass your system. yes I know that with
>> enough effort and control of both systems you can tunnel over
>> anything, the point is that ssh is eager to do this for you (overly
>> eager IMHO)
>
> How is VPN better than that?
>
>> ssh depends primarily on certificates that reside on untrusted
>> machines. it can be made to work with tokens or such, but it takes a
>> fair bit of effort.
>
> There probably VPN differs...
>
>> sshd runs as root on just about every system
>
> And VPN doesn't?

you aren't having the VPN software running commands passed to it by the 
outside world.

> [...]
>
> The idea with using SSH was, I think, that it is easier and better to
> use existing solution for authentication and authorization than roll
> your own (see the case of CVS pserver, and Subversion svnserve).

I'm not saying that it's good to roll your own from scratch, you need to 
use libraries that have been examined and validated, but SSH is a swiss 
army knife, it's designed to do lots of things, and when you are exposing 
things to the outside world you want them to be as limited as possible to 
limit the damage that they can do.

David Lang
