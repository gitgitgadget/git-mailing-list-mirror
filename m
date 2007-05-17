From: david@lang.hm
Subject: Re: Smart fetch via HTTP?
Date: Wed, 16 May 2007 18:04:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0705161803580.1280@asgard.lang.hm>
References: <20070515201006.GD3653@efreet.light.src>
 <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com>
 <Pine.LNX.4.64.0705161232120.6410@racer.site>
 <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com>
 <Pine.LNX.4.64.0705170152470.6410@racer.site> <20070517010335.GU3141@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 17 03:10:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoUVS-0001Yw-Oe
	for gcvg-git@gmane.org; Thu, 17 May 2007 03:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755714AbXEQBJz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 21:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755753AbXEQBJz
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 21:09:55 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:60903
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755664AbXEQBJy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 21:09:54 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l4H19SY6031601;
	Wed, 16 May 2007 18:09:28 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20070517010335.GU3141@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47475>

On Wed, 16 May 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
>>> And for services like SF.net it'd be a safe low-cpu way of serving git
>>> files. 'cause the git protocol is quite expensive server-side (io+cpu)
>>> as we've seen with kernel.org. Being really smart with a cgi is
>>> probably going to be expensive too.
>>
>> It's probably better and faster than relying on a feature which does not
>> exactly help.
>
> Yes.  Packing more often and pack v4 may help a lot there.
>
> The other thing is kernel.org should really try to encourage the
> folks with repositories there to try and share against one master
> repository, so the poor OS has a better chance at holding the bulk
> of linux-2.6.git in buffer cache.

do you mean more precisely share against one object store or do you really 
mean repository?

David Lang

> I'm not suggesting they share specifically against Linus' repository;
> maybe hpa and the other admins can host one seperately from Linus and
> enourage users to use that repository when on a system they maintain.
>
> In an SF.net type case this doesn't help however.  Most of SF.net
> is tiny projects with very few, if any, developers.  Hence most
> of that is going to be unsharable, infrequently accessed, and uh,
> not needed to be stored in buffer cache.  For the few projects that
> are hosted there that have a large developer base they could use
> a shared repository approach as I just suggested for kernel.org.
>
> aka the "forks" thing in gitweb, and on repo.or.cz...
>
>
