From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Tue, 02 Jan 2007 20:22:14 +0100
Organization: At home
Message-ID: <eneb7b$ll7$1@sea.gmane.org>
References: <7vy7omyuaf.fsf@assigned-by-dhcp.cox.net> <560316.34562.qm@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jan 02 20:19:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1pAf-0005Qy-1b
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 20:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932910AbXABTTU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 14:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932854AbXABTTT
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 14:19:19 -0500
Received: from main.gmane.org ([80.91.229.2]:50924 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932910AbXABTTS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 14:19:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H1pAK-0002nM-EK
	for git@vger.kernel.org; Tue, 02 Jan 2007 20:19:16 +0100
Received: from host-81-190-20-195.torun.mm.pl ([81.190.20.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Jan 2007 20:19:16 +0100
Received: from jnareb by host-81-190-20-195.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Jan 2007 20:19:16 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-195.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35800>

Luben Tuikov wrote:

> --- Junio C Hamano <junkio@cox.net> wrote:
>> Luben Tuikov <ltuikov@yahoo.com> writes:
>> 
>>> Questions:
>>>
>>> What is the reasonining of defining branch.<name>.merge to point
>>> to the "remote's setup"?
>> 
>> See list archives.  
>> 
>> Because you are not required to use remote tracking branches.
> 
> Then why does it point to the _remote_ mapping?  One shouldn't
> care what it is, and how it looks in the remote repo.  That is
> handled by [remote].  In [branch] I shouldn't have to have any
> absolute references, i.e. branch.<name>.remote points to [remote],
> and branch.<name>.merge should only give a _branch_ name,
> whose remote-to-local mapping (which preserves the branch name)
> can be found by dereferencing branch.<name>.remote to get to
> remote.<rname>.fetch.

Once again: if you _don't_ have _local_ tracking branch, so you _must_
use _remote_ name.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
