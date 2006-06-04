From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Importing Mozilla CVS into git
Date: Sun, 04 Jun 2006 09:05:36 +0200
Organization: At home
Message-ID: <e5u0o0$3rm$1@sea.gmane.org>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com> <9e4733910606012100s7ace4721le6fbfbcaadfb6c43@mail.gmail.com> <46a038f90606012116t478edacex72a441544f395af4@mail.gmail.com> <200606040116.38036.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0606031631480.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Jun 04 09:06:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmmgt-0006rw-CV
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 09:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWFDHGF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 03:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWFDHGF
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 03:06:05 -0400
Received: from main.gmane.org ([80.91.229.2]:29074 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932176AbWFDHGE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 03:06:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FmmgS-0006or-L2
	for git@vger.kernel.org; Sun, 04 Jun 2006 09:06:00 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Jun 2006 09:06:00 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Jun 2006 09:06:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21248>

On Sun, 4 Jun 2006, Linus Torvalds wrote:

> On Sun, 4 Jun 2006, Robin Rosenberg (list subscriber) wrote:
>> 
>> (Yet) Another problem is that many windows tools use CR LF as the line ending.
>> Almost all windows editors default to CRLF and some detect existing line 
>> endings. No editing with notepad anymore. Of course that is a problem 
>> regardless of whether a git or cvs client is used. You'll get these big 
>> everything-changed commits that alter between CRLF and LF.
> 
> The only sane approach there (if you want to be at all cross-platform) is 
> to just force everybody to _commit_ in UNIX '\n'-only format. Especially 
> as most Windows tools probably handle that fine on reading (just have 
> trouble writing them).
> 
> And that shouldn't actually be that hard to do. The most trivial approach 
> is to have just a pre-trigger on commits, but let's face it, that would 
> not be a good "full" solution. A better one is to just make the whole
> "git update-index" thing just have a "automatically ignore CR/LF" mode.

Why wouldn't it be good solution?

BTW. wouldn't Mercurial encode/decode filters

  http://www.selenic.com/mercurial/wiki/index.cgi/EncodeDecodeFilter

be a better solution than modifying files by "git update-index", 
with all problems it can cause (not detected binary files, text files
which have to be in CR/LF line ending,...).

-- 
Jakub Narebski
Warsaw, Poland
