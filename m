From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Unresolved issues #4
Date: Fri, 06 Oct 2006 12:56:48 +0200
Organization: At home
Message-ID: <eg5co6$g9n$1@sea.gmane.org>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net> <7vfye20xjt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Oct 06 12:57:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVnOL-00067O-QQ
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 12:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWJFK5T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 06:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWJFK5T
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 06:57:19 -0400
Received: from main.gmane.org ([80.91.229.2]:57286 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751474AbWJFK5S (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 06:57:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GVnNo-0005vJ-PY
	for git@vger.kernel.org; Fri, 06 Oct 2006 12:56:48 +0200
Received: from host-81-190-18-48.torun.mm.pl ([81.190.18.48])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Oct 2006 12:56:48 +0200
Received: from jnareb by host-81-190-18-48.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Oct 2006 12:56:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-48.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28398>

Junio C Hamano wrote:

> Recent issues I am aware of but haven't kept track of closely
> enough and as a result do not have a clue about X-<.
> 
> From: A Large Angry SCM <gitzilla@gmail.com>
> Subject: Notes on Using Git with Subprojects
> Message-ID: <45196628.9010107@gmail.com>
> 
> [jc: a very nice write-up of a subprojects workflow. I do not
>  remember if it produced any actionable items, though]

It did produce two workflows: the original "build time"
by A Large Angry SCM/Gitzilla, which I think is/will be
available at http://git.rsbx.net/Notes/Git_Subprojects.txt
and second using linked objects and refs. Both I think not
quite finished; perhaps some of the code could be put
in 'pu'.

Perhaps to be added to Subpro.txt in 'todo' branch,
and/or to git wiki...

> From: Shawn Pearce <spearce@spearce.org>
> Message-ID: <20060930045037.GB18479@spearce.org>
> 
> "git ref-log" command to interact with ref-log?
> 
> [jc: not much interest from users?]

I thing it can increase number of reflog users. 

> From: Josh Triplett <josh@freedesktop.org>
> Message-ID: <451A30E4.50801@freedesktop.org>
> 
> git-split

Should be git-split-hierarchy or git-split-by-directory
I think. We could have also git-split-history, which would
split current history into archive repository, and active
repository with archive repository grafted in; or add to
archive repository if it exists, regraft active (current work)
repository and prune below new grafts. 

> [jc: no response to the initial review comments]

It is "done once" problem, and usable only for some repositories,
so perhaps this is the cause of not many responses.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
