From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Allow git-svnimport to take "" as the trunk directory.
Date: Tue, 14 Aug 2007 15:33:47 +0200
Message-ID: <86ps1qfdfo.fsf@lola.quinscape.zz>
References: <11870641981207-git-send-email-albertito@gmail.com> <85vebi3bzv.fsf@lola.goethe.zz> <20070814123604.GA10472@homero.springfield.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 14 15:34:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKwXR-0001nY-8X
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 15:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757437AbXHNNeN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 09:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755870AbXHNNeM
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 09:34:12 -0400
Received: from main.gmane.org ([80.91.229.2]:53874 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754583AbXHNNeK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 09:34:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IKwX9-0007YA-MJ
	for git@vger.kernel.org; Tue, 14 Aug 2007 15:34:07 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Aug 2007 15:34:07 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Aug 2007 15:34:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:GrjDdXHlrDhX0Ff3sdz6FAh/dKQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55832>

Leandro Lucarella <llucax@gmail.com> writes:

> David Kastrup, el 14 de agosto a las 07:45 me escribiste:
>> Alberto Bertogli <albertito@gmail.com> writes:
>> 
>> > Some repositories started with the trunk in "/" and then moved it to the
>> > standard "trunk/" location.
>> >
>> > On these repositories, the correct thing would be to call
>> > git-svnimport -T "",
>> 
>> I would not call that the best solution: it makes the bad decision
>> from the past impact useful work in the future.  I very much like git
>> having a good toplevel directory structure.
>
> Besides the example of a mutating trunk directory, I have repositories
> where there is only trunk (in "/" directory) and it never changes. Without
> this patch, I can't even import that kind of repositories.

[...]

> The patch is for git-svnimport, not git-svn

Oops.  In that case, I have no qualified opinion.

-- 
David Kastrup
