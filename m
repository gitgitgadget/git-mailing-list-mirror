From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 08:53:52 -0700
Message-ID: <4718D310.3040101@midwinter.com>
References: <20071019062219.GA28499@coredump.intra.peff.net> <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com> <20071019073938.GN14735@spearce.org> <4718D25A.7040109@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 17:54:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiuAq-0002ZB-Cq
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 17:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304AbXJSPx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 11:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754049AbXJSPx4
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 11:53:56 -0400
Received: from tater.midwinter.com ([216.32.86.90]:60217 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753863AbXJSPxz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 11:53:55 -0400
Received: (qmail 31699 invoked from network); 19 Oct 2007 15:53:55 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=wks0x8IYcV5+lOYESAee3paVFH3rU+eBa3UDEpg1mn8ADrADCNAW3J0AdshtaPdz  ;
Received: from localhost (HELO sgrimm-mbp.lan) (koreth@127.0.0.1)
  by localhost with SMTP; 19 Oct 2007 15:53:55 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <4718D25A.7040109@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61728>

(Sorry for the repeat; my mail client tried to send this as HTML at 
first and the git list rejected it.)

On 19/10/2007, Jeff King <peff@peff.net> wrote:
 > This makes the fetch output much more terse. It is likely to
 > be very controversial. Here's an example of the new output:
 >
 > Indexing objects: 100% (1061/1061), done.
 > Resolving deltas: 100% (638/638), done.

Those two lines are actually my beef with the fetch output. As a newbie, 
I had no idea what "Indexing objects" actually meant. We have this thing 
called "the index" in git so I would expect "Indexing objects" to have 
something to do with that, but it doesn't seem to.

How about something more descriptive of the high-level operation that's 
going on, along the lines of:

Gathering changes from remote: 100% (1061/1061), done.
Applying changes locally: 100% (638/638), done.

-Steve
