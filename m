From: Ian Clatworthy <ian.clatworthy@internode.on.net>
Subject: Re: [Fwd: [ANNOUNCE] bzr-fastimport plugin, yet another Bazaar import
	option]
Date: Fri, 22 Feb 2008 17:47:40 +1000
Message-ID: <47BE7E1C.4040303@internode.on.net>
References: <47BE167A.4060005@internode.on.net>
	<20080222073228.GF8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Bazaar <bazaar@lists.canonical.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: bazaar-bounces@lists.canonical.com Fri Feb 22 08:48:23 2008
Return-path: <bazaar-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from chlorine.canonical.com ([91.189.94.204])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSSdp-0008GG-OQ
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 22 Feb 2008 08:48:21 +0100
Received: from localhost ([127.0.0.1] helo=chlorine.canonical.com)
	by chlorine.canonical.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-bounces@lists.canonical.com>)
	id 1JSSdI-0002of-5q; Fri, 22 Feb 2008 07:47:48 +0000
Received: from ipmail05.adl2.internode.on.net ([203.16.214.145])
	by chlorine.canonical.com with esmtp (Exim 4.60)
	(envelope-from <ian.clatworthy@internode.on.net>) id 1JSSdG-0002oY-0c
	for bazaar@lists.canonical.com; Fri, 22 Feb 2008 07:47:46 +0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAE4Mvkd5Lc6oWmdsb2JhbAAIkE0BIIE7niU
X-IronPort-AV: E=Sophos;i="4.25,390,1199626200"; d="scan'208";a="60029485"
Received: from ppp121-45-206-168.lns1.bne1.internode.on.net (HELO
	[192.168.1.6]) ([121.45.206.168])
	by ipmail05.adl2.internode.on.net with ESMTP; 22 Feb 2008 18:17:42 +1030
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <20080222073228.GF8410@spearce.org>
X-Enigmail-Version: 0.95.0
X-BeenThere: bazaar@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar discussion <bazaar.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar>,
	<mailto:bazaar-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar>
List-Post: <mailto:bazaar@lists.canonical.com>
List-Help: <mailto:bazaar-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar>,
	<mailto:bazaar-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-bounces@lists.canonical.com
Errors-To: bazaar-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74701>

Shawn O. Pearce wrote:

> If we are heading in the direction of making this a common stream
> format I'd like to try and work it out such that any additional
> extensions aren't VCS specific, at least as much as we can avoid it.
> That way exports from a source into this format can be loaded into
> any VCS that recognizes it, and have little or no loss.  So yes,
> I am interested in trying to work with you and anyone else who wants
> to extend the format further.

Excellent. That sounds the right way to go. I'll contact you if and when
I want to add stuff.

> Heh.  OOo is _huge_.  I think the best import into Git thus far is
> taking up about 1.5G of disk space once fully repacked.  I don't
> recall how they did the import, but coming from SVN I think they
> used git-svn, which is not based on git-fast-import.
> 
> What frontend are you using to go from SVN -> fast-import?

The pack file in the Git clone I have is 2.4G. I thought that was large
but it's quite small compared to the 82G svn dump that creates a 55G svn
repo!

I'm using svn-fast-export.c currently. I'd rather enhance the Python one
but my Subversion binding knowledge is slim and there's a bug wrt "too
many open files" that causes it to crash almost immediately on the OOo
repo. It's not obvious to me how to fix that unfortunately. It worked
fine for Wordpress OTOH.

The svn-all-fast-export tool sounds interesting but is completely
undocumented to my knowledge.

Ian C.
