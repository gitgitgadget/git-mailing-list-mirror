From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git log --graph and root commits
Date: Sat, 14 Feb 2009 00:40:58 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngpc4op.jdo.sitaramc@sitaramc.homelinux.net>
References: <slrngp9t0u.va9.sitaramc@sitaramc.homelinux.net>
 <alpine.DEB.1.00.0902131237490.10279@pacific.mpi-cbg.de>
 <slrngpb2gl.rhg.sitaramc@sitaramc.homelinux.net>
 <m3wsbuthp1.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 01:42:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY8cA-0006Ob-8v
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 01:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbZBNAlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 19:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753390AbZBNAlL
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 19:41:11 -0500
Received: from main.gmane.org ([80.91.229.2]:45318 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750714AbZBNAlK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 19:41:10 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LY8ag-0000cG-TU
	for git@vger.kernel.org; Sat, 14 Feb 2009 00:41:06 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 00:41:06 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 00:41:06 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109792>

On 2009-02-13, Jakub Narebski <jnareb@gmail.com> wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>> On 2009-02-13, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

>>> 	git log --graph --pretty=format:'%h %s%n'

>> It doubles the height requirement, but you gave me an idea:
>> 
>>     git log --graph --pretty=tformat:'%h <%p> %s' --all |
>>         perl -pe '$_.="----\n" if /<>/; s/<.*?> //'
>> 
>> Thanks for pointing me in the right direction.
>
> Gaaah... I tried running it on git.git :-))))

:-)

Seriously, I find 'log --graph' is useful on projects where
not everyone is an expert and things might go a little
haywire here and there.  People merge the wrong thing with
the wrong other thing, maybe, and you want to see how
precisely they got there.

A project managed by git.gods can become a lot more complex
and not have to actually care about this visualisation.

Of course, gitk is really good and manages a lot more
complexity, obviously, but I like 'log --graph' also.  And
I've sort of fallen in love with --simplify-by-decoration
too.  Very cool stuff.

The things you can do on an xterm...!
