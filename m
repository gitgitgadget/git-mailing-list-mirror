From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: n-heads and patch dependency chains
Date: Tue, 04 Apr 2006 22:18:02 +0200
Organization: At home
Message-ID: <e0uk9o$oj6$1@sea.gmane.org>
References: <4430D352.4010707@vilain.net> <7vsloucuxk.fsf@assigned-by-dhcp.cox.net> <4431B60E.3030008@vilain.net> <7vhd596ua0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Apr 04 22:18:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQryy-0008LS-LE
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 22:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWDDUS0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 16:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWDDUS0
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 16:18:26 -0400
Received: from main.gmane.org ([80.91.229.2]:8859 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750825AbWDDUS0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Apr 2006 16:18:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FQryX-0008Es-Of
	for git@vger.kernel.org; Tue, 04 Apr 2006 22:18:05 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Apr 2006 22:18:05 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Apr 2006 22:18:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18407>

Junio C Hamano wrote:

> I was re-reading the hydra stuff and realized I've seen the "a
> cap that bundles independent tracks together" pattern somewhere
> else in the history of git.
> 
> It is very similar to how "bind commit" would have worked.
[...] 
> A "bind commit" proposal was made to support subprojects living
> in their own subdirectories.  The picture to describe the commit
> ancestry chain would be almost the same as the above picture,
> except that it did not uncap and recap, but would have built its
> own ancestry chain.

One of versions of "hydra commit" proposals, in the mail which is yet to
appear on Gmane git mailing list archive, and Gmane NNTP interface to git
mailing list, was to define commit dependency (to which chain commit would
get) in the terms of affecting files in the same directory. Simple
generalization to subtree (directory and its subdirectories) gives "bind
commit for subprojects".

> It had two different kinds of commit relationships: parenthood
> and directory structure binding.

Great minds think alike :-P -- we (Sam and I) were talking on #git about
adding "depends-on" field to commit.

In the email to write I would propose that instead of adding "depends-on"
field (or "bind") one can at least in prototype stage make parallel
development, commiting simultaneously to the tree where history is history,
and to the tree where history is dependence, or bind. I hope I will make
myself clearer in upcoming message; see Sam post beginning this thread - we
want to make both pictures (on the left and on the right) simultaneously.

-- 
Jakub Narebski
Warsaw, Poland
