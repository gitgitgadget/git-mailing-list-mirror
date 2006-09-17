From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Notes on supporting Git operations in/on partial Working Directories
Date: Sun, 17 Sep 2006 22:28:52 +0200
Organization: At home
Message-ID: <eekb4o$5nj$1@sea.gmane.org>
References: <4509A7EC.9090805@gmail.com>	<7vu03a2po8.fsf@assigned-by-dhcp.cox.net> <4509B954.60101@gmail.com>	<7v8xkl26kb.fsf@assigned-by-dhcp.cox.net> <450AEDBF.9050307@gmail.com> <7vvenm3h9f.fsf@assigned-by-dhcp.cox.net> <450D9847.4080308@gmail.com> <eek5l4$kaa$1@sea.gmane.org> <450DA99F.8000009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Sep 17 22:29:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GP3Fv-00029V-28
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 22:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWIQU2n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 16:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWIQU2n
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 16:28:43 -0400
Received: from main.gmane.org ([80.91.229.2]:33155 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932396AbWIQU2n (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Sep 2006 16:28:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GP3Fd-00025X-3Y
	for git@vger.kernel.org; Sun, 17 Sep 2006 22:28:29 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 22:28:29 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 22:28:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27202>

A Large Angry SCM wrote:
> Jakub Narebski wrote:
>> A Large Angry SCM wrote:
>> 
>>> There is no fundamental reason Git can not support partial 
>>> checkouts/working directories. In fact, there is no fundamental reason 
>>> Git can not support operations on partial (sparse?) repositories in both 
>>> space (working content/state, etc.) and time (history); it's just a 
>>> matter of record keeping[*1*]. That isn't how the Linux kernel 
>>> developers want to use their VCS but it _is_ how others want to use
>>> theirs. 
>> 
>> There is perhaps not much trouble with partial checkouts, but there is
>> problem with partial _commits_, at least for snapshot based SCM 
>> (as opposed to patchset based SCM). 
> 
> By "partial commit" I take it you mean a commit with only partial 
> information about the new (content) state? If so, the missing 
> information about the new state can be assumed to have not changed from 
> the previous recorded state (commit).

That of course assumes that 1) the whole state is recorded somewhere
(perhaps in the repository); so the partial checkout saves space only if
repository compress really well, 2) there are no merges outside checked out
part.

Is anybody working on "bind" header and subproject support?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
