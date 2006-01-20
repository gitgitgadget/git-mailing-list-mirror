From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [QUESTION] about .git/info/grafts file
Date: Fri, 20 Jan 2006 15:48:51 -0500
Message-ID: <20060120204851.GB19212@mythryan2.michonline.com>
References: <cda58cb80601170928r252a6e34y@mail.gmail.com> <cda58cb80601170932o6f955469y@mail.gmail.com> <7v8xtdrqwg.fsf@assigned-by-dhcp.cox.net> <43CF739F.2030204@op5.se> <cda58cb80601190531q238a8f40r@mail.gmail.com> <43CF97AF.9060300@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 20 21:50:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F03CW-0002yE-3h
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 21:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWATUth (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 15:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWATUth
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 15:49:37 -0500
Received: from mail.autoweb.net ([198.172.237.26]:44722 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S932178AbWATUtg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 15:49:36 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1F03CP-0006kG-H1; Fri, 20 Jan 2006 15:49:35 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1F03CO-0002DE-BT; Fri, 20 Jan 2006 15:49:33 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1F03C3-00084Q-Sb; Fri, 20 Jan 2006 15:49:11 -0500
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <43CF97AF.9060300@op5.se>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14977>

On Thu, Jan 19, 2006 at 02:44:15PM +0100, Andreas Ericsson wrote:
> 
> The full kernel tree, with history since 1991 or some such, is about 3.2 
> GB. It was for this reason that the early history was dropped. I don't 
> think another drop will be necessary any time soon, since incremental 
> updates are fairly cheap over git and git+ssh. Only gitk suffers, but 
> that's just for a short while.

Just to make sure this is corrected, the 3.2GB was for a fully unpacked
tree, which is still fairly bad in the current tree.

The historical tree, packed, runs about 266M in a single pack.
Admittedly, I still refuse to try to run gitk on it.

> >But I'm not saying that it's bad thing to keep
> >that history. It just would be nice to allow developpers that don't
> >care about old history to get rid of it.
> 
> You could ofcourse create a new repository with the files from the 
> version you want, but then you'd have a hard time merging the two repos 
> if you ever want to import the old history.

It's always possible to use a "graft" to tie the history together, and
if you really need to merge changes across the boundary, my graft-ripple
(in the archives) tool can make it happen, though it does some ... nasty
things to the history tree in the process.  (It might be useful on a
throwaway tree to provide a way to merge, then, from which a set of
diffs could be taken and applied back on an un-messy tree.)

-- 

Ryan Anderson
  sometimes Pug Majere
