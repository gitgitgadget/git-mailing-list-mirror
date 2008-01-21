From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Tue, 22 Jan 2008 01:41:31 +0300
Message-ID: <20080121224131.GD14871@dpotapov.dyndns.org>
References: <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095!@ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <20080121205615.GY14871@dpotapov.dyndns.org> <DEC058ED-EBF0-4A1E-BF7B-448B16DBBD6E@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 23:42:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH5LD-0003Gw-LX
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 23:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754268AbYAUWli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 17:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754544AbYAUWli
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 17:41:38 -0500
Received: from smtp02.mtu.ru ([62.5.255.49]:61877 "EHLO smtp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754268AbYAUWlh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 17:41:37 -0500
Received: from smtp02.mtu.ru (localhost [127.0.0.1])
	by smtp02.mtu.ru (Postfix) with ESMTP id 8F6F632C15;
	Tue, 22 Jan 2008 01:41:30 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-188-102.pppoe.mtu-net.ru [85.141.188.102])
	by smtp02.mtu.ru (Postfix) with ESMTP id CFDDC329B1;
	Tue, 22 Jan 2008 01:41:29 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JH5Kd-0008H4-QF; Tue, 22 Jan 2008 01:41:31 +0300
Content-Disposition: inline
In-Reply-To: <DEC058ED-EBF0-4A1E-BF7B-448B16DBBD6E@sb.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp02.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71360>

On Mon, Jan 21, 2008 at 04:07:27PM -0500, Kevin Ballard wrote:
> 
> Again, I've specified many times that I'm talking about canonical  
> equivalence.
> 
> And yes, HFS+ does normalization, it just doesn't use NFD. It uses a  
> custom variant. I fail to see how this is a problem.

If you think that HFS+ does normalization then you apparently have no
idea of what the term "normalization" means. Have you? But if you
don't know what is "normalization" then you cannot really know what
canonical equivalence means.

> >
> >I don't say they do that without *any* reason, but I suppose all
> >Apple developers in the Copland project had some reasons for they
> >did, but the outcome was not very good...
> 
> Stupid engineers don't get to work on developing new filesystems.

Assigning someone to work on a new filesystem does not make him
suddenly smart. As to that stupid engineers don't get to work,
it is like saying there is no stupid engineers at all. There are
plenty evidence to contrary. And when management is disastrous
then most idiots with big mouth and little capacity to produce
any useful does get assignment to develop new features, while
those who can actually solve problems are assigned to fix the
next build, because the only thing that this management worries
about how to survive another year or another months...

> And  
> Copland didn't fail because of stupid engineers anyway. If I had to  
> blame someone, I'd blame management.

But if the code was so good then why was most of that code thrown away
later when management was changed? Still bad management?

> 
> >>The only information you lose when doing canonical normalization is
> >>what the original byte sequence was.
> >
> >Not true. You lose the original sequence of *characters*.
> 
> Which is only a problem if you care about the byte sequence, which is  
> kinda the whole point of my argument.

Byte sequences are not an issue here. If the filesystem used UTF-16 to
store filenames, that would NOT cause this problem, because characters
would be the same even though bytes stored on the disk were different.
So, what you actually lose here is the original sequence of *characters*.

Dmitry
