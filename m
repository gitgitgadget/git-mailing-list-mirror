From: david@lang.hm
Subject: Re: is gitosis secure?
Date: Sun, 14 Dec 2008 22:32:35 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0812142229010.17688@asgard.lang.hm>
References: <200812090956.48613.thomas@koch.ro> <bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com> <87hc58hwmi.fsf@hades.wkstn.nix> <gi1qsl$22p$1@ger.gmane.org> <m3zlizdofy.fsf@localhost.localdomain> <87prju5m6s.fsf@hades.wkstn.nix>
 <alpine.DEB.2.00.0812142121090.9552@vellum.laroia.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Nix <nix@esperi.org.uk>, git@vger.kernel.org
To: Asheesh Laroia <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Mon Dec 15 06:32:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC64V-00053U-J6
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 06:32:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbYLOFba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 00:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbYLOFba
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 00:31:30 -0500
Received: from mail.lang.hm ([64.81.33.126]:33985 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742AbYLOFb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 00:31:29 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id mBF5VMZJ004084;
	Sun, 14 Dec 2008 21:31:22 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.DEB.2.00.0812142121090.9552@vellum.laroia.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103131>

On Sun, 14 Dec 2008, Asheesh Laroia wrote:

> On Mon, 15 Dec 2008, Nix wrote:
>
>> On 14 Dec 2008, Jakub Narebski spake thusly:
>>> BTW. is outgoing SSH transport (from network to outside) blocked as well?
>> 
>> *No* ports are open. All they have is a (non-transparent) buggy HTTP proxy. 
>> These guys really don't get the Internet, despite their sales literature 
>> banging on endlessly about it.
>
> If that's the only way you can access the network, you can take advantage of 
> the way HTTP proxies deal with HTTPS: they typically let it through byte for 
> byte.
>
> "connect.c is the simple relaying command to make network connection via 
> SOCKS and https proxy. It is mainly intended to be used as proxy command of 
> OpenSSH."
>
> Run sshd on port 443, use connect.c, and you're set.
>
> (Except for some really smart SSL-aware HTTP proxies that verify that it's an 
> SSL connection of some kind.  In theory, you could then sslwrap your sshd and 
> then be set.)

although, if the company is doing this as a deliberate security measure 
(as opposed to not knowing what they are doing), setting up a bypass like 
this can get you fired for deliberatly bypassing a security device.

also, examples of people going to this sort of effort to bypass security 
policies end up with employees being trusted less.

you are far better off going through channels and discussing what you are 
trying to do and why.

David Lang
