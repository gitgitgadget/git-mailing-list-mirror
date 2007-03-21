From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Rename handling
Date: Thu, 22 Mar 2007 00:01:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703212341020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org>
 <45FED31B.8070307@midwinter.com> <200703191903.20005.andyparkins@gmail.com>
 <45FEE2B2.6050904@midwinter.com> <etpson$qih$1@sea.gmane.org>
 <Pine.LNX.4.63.0703210120230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <4601B199.9060300@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 00:02:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU9pR-0006Yh-CM
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 00:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096AbXCUXCF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 19:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753089AbXCUXCF
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 19:02:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:48933 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753072AbXCUXCC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 19:02:02 -0400
Received: (qmail invoked by alias); 21 Mar 2007 23:02:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 22 Mar 2007 00:02:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18spp86Z54s8qqe6y4FsWdCBJ/SRLYWU8iRcBllUY
	zf6T2xpC6SRq/s
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <4601B199.9060300@midwinter.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42824>

Hi,

On Wed, 21 Mar 2007, Steven Grimm wrote:

> Johannes Schindelin wrote:
> > P.S.: It would be so nice if somebody (preferably someone who 
> > previously thought manual renames were a pretty clever thing) to write 
> > up the arguments, and add that to the "why automatic renaming?" 
> > section of the FAQ...
> 
> For some reason whenever I try to argue that we need, IN ADDITION to the 
> automatic rename detection, a way to provide hints to the merge engine 
> that a non-auto-detectable rename has occurred, the responses I get back 
> are mostly of the form, "But the automatic rename detection handles all 
> these cases that wouldn't be handled with manual rename marking!"

No. That's not the argument. The argument goes like this:

	Whatever solutions you choose to handle renames, it _will_ have 
	problems. We chose a solution which appears to have the least
	problems.

> Say you're tracking a directory full of video files. Even a slight tweak 
> to one of them (to put a logo in the corner, say, while moving it into 
> an "accessible by the public" directory) will result in a file that has 
> no content in common at all if you look at it as purely a stream of 
> bytes. Short of decoding the thing to video frames and looking for 
> similarities in the images, there's no way any merge tool will ever be 
> able to tell the two versions are the same file unless the user 
> indicates it.

That is a particularly bad example: you are not renaming files in that 
example!

> Of course, git actually does give you a way to mark renames manually: 
> commit them by themselves without changing the content. The problem is 
> that that overloads the "record this snapshot of the tree for posterity" 
> command purely for the purpose of working around the merge tool's 
> inability to detect the rename.

Not at all. You are actually recording the rename. So, you proved that you 
do have a method to record a rename manually.

> It also means that if I want reliable renames, I can no longer impose 
> the requirement that my project be in a buildable state at each commit. 
> That doesn't seem like all that unreasonable a thing to want (but maybe 
> it is?) -- I don't want to be in the situation where I say, e.g. "git 
> checkout -b testbranch '@{1 day ago}'" and get a broken working copy 
> because I happened to do it at just the wrong time of day. But with the 
> "just commit your renames separately" approach, that's exactly what can 
> happen.

Hey, I might be wrong. Why don't you prove me wrong? Code talks.

Ciao,
Dscho
