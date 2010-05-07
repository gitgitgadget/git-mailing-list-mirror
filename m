From: Gelonida <gelonida@gmail.com>
Subject: Re: What should be the CRLF policy when win + Linux?
Date: Fri, 07 May 2010 09:15:59 +0200
Message-ID: <hs0enf$vij$1@dough.gmane.org>
References: <4BE141E3.2060904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 09:16:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAHnl-0001ML-Iw
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 09:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191Ab0EGHQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 03:16:10 -0400
Received: from lo.gmane.org ([80.91.229.12]:34033 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929Ab0EGHQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 03:16:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OAHn6-00013Y-Ed
	for git@vger.kernel.org; Fri, 07 May 2010 09:16:08 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 May 2010 09:16:08 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 May 2010 09:16:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <4BE141E3.2060904@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146526>

I'm not convinced, that one policy is a good solution, but it really
depends on your project.


What we do:
.bat files with windows line endings
.cmd .vbs files with windows line endings
.sh files with unix file endings
 source files (.c .h .py .pl) with unix file endings
.txt files with unix file endings

The rest untouched:
you might add a precommti hook to verify this.
SO war we din't bother to automate it, but I must admint, that we had
occasional rare jickups.


bye


N


mat wrote:
> Hi
> 
> I have two git projects:
> -one (A) with linux people only
> -one (B) with someone using windows
> 
> As we had "end of line" problems with the person using windows (B), I used:
> 
> git config --global core.autocrlf true
> 
> Following advices from:
> http://help.github.com/dealing-with-lineendings/
> 
> So everything now if fine with project B, but now some problems using
> project (A): I wanted to copy the whole project file to another dir, and
> now it is complaining about the change, signaling warning:
> 
> CRLF will be replaced by LF in .../A.
> 
> So I don't know exactly what I should do...Should I change all the CRLF
> from project A, but people will have also problems, or can I switch the
> config, once I'm using project A and B? It is not so clear in my mind
> and I would appreciate any advice!!
> 
> Thanks a lot
> 
> Matthieu Stigler
> 
> 
> 
