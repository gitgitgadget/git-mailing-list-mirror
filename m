From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current branch reflog
Date: Fri, 02 Feb 2007 11:31:23 +0100
Organization: At home
Message-ID: <epv3r9$4f7$2@sea.gmane.org>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home> <20070201191323.GA18608@spearce.org> <7vmz3xoas9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 02 11:30:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCvgZ-00085Z-D6
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 11:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbXBBKaY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 05:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbXBBKaY
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 05:30:24 -0500
Received: from main.gmane.org ([80.91.229.2]:34438 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897AbXBBKaX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 05:30:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCvgG-0007Pe-4Z
	for git@vger.kernel.org; Fri, 02 Feb 2007 11:30:08 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 11:30:08 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 11:30:08 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38487>

Junio C Hamano wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
>> Nicolas Pitre <nico@cam.org> wrote:
>>> The work in progress to enable separate reflog for HEAD will make it
>>> independent from reflog of any branch HEAD might be pointing to. In
>>> the mean time disallow HEAD@{...} until that work is completed. Otherwise
>>> people might get used to the current behavior which makes HEAD@{...} an
>>> alias for <current_branch>@{...} which won't be the case later.
>>
>> I happen to really like the fact that HEAD@{...} is an alias for
>> <current_branch>@{...}.
> 
> It is usually easier to type.
> 
>> But now that HEAD will soon be getting its own reflog, I guess I
>> better relearn how to type <current_branch>.  :-)
> 
> One thing that is certain is that master@{...} will mean the
> same thing no matter what happens to Nico's series -- it talks
> about where the tip of that particular branch was at any recent
> time.  Right now HEAD@{...} happens to talk about "the current
> branch" (and only the current branch) -- Nico's patch would
> change the semantics when/if it is merged.

Perhaps we should use @{...} to refer to reflog for HEAD, or use
yet another special notation?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
