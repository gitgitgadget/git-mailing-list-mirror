From: Abdelrazak Younes <younes.a@free.fr>
Subject: Re: [RFC] Distributing Windows binary package compiled with non gpl
   code
Date: Fri, 28 Dec 2007 00:10:08 +0100
Message-ID: <fl1bcn$k2h$1@ger.gmane.org>
References: <e5bfff550712271032q25d135e7y47d68337e937d401@mail.gmail.com> <alpine.LNX.1.00.0712271647130.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 28 00:12:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J81tW-0001LL-Lm
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 00:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbXL0XLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2007 18:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753355AbXL0XLe
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Dec 2007 18:11:34 -0500
Received: from main.gmane.org ([80.91.229.2]:40695 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752429AbXL0XLd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2007 18:11:33 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1J81sX-00034e-QE
	for git@vger.kernel.org; Thu, 27 Dec 2007 23:11:05 +0000
Received: from gre92-5-82-237-199-162.fbx.proxad.net ([82.237.199.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Dec 2007 23:11:05 +0000
Received: from younes.a by gre92-5-82-237-199-162.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Dec 2007 23:11:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: gre92-5-82-237-199-162.fbx.proxad.net
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <alpine.LNX.1.00.0712271647130.13593@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69272>

Daniel Barkalow wrote:
> On Thu, 27 Dec 2007, Marco Costalba wrote:
> 
>> Packaged together with qgit.exe there are the necessary Micorsoft
>> Visual C dll's. Is this a problem for someone?

My two cents below; I hope you don't mind my interference.

> 
> It depends on how they're packaged together. If it's possible to unpack 
> them (into a bunch of separate files, where each is either all GPL or no 
> GPL), then this is "mere aggregation" and perfectly fine (assuming you're 
> allowed to distribute the Visual C dlls, of course). IIRC, bundled 
> libraries for Windows programs are stored on the user's disk as separate 
> files anyway, so this is automatically okay.

Yes, MSVC dlls are redistributable.

> I'd actually be more concerned about whether you can (or should) 
> distribute GPL code compiled with a proprietary compiler;

This is the exact same situation as with other proprietary platforms 
(Solaris, HPUx, etc). You should not make a difference for Windows IMHO. 
Besides, many open source projects have no problem at all with MSVC.

> people who get 
> the binaries and the source still couldn't edit the source and generate a 
> corresponding binary, because they don't necessarily have the build 
> environment you used.

This particular tool is free (as in beer) to download and use.

> On the other hand, nothing you could do differently 
> would be any better for anyone with the right to complain, so it shouldn't 
> be an issue in practice. (And a user of qgit for Windows is more likely 
> than usual to have MSVC anyway)

Well said :-)

Abdel.
