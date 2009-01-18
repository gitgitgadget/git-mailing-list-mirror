From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: log-tree.c: date hardwired
Date: Sun, 18 Jan 2009 00:40:32 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngn4uk0.r31.sitaramc@sitaramc.homelinux.net>
References: <87r637oq41.fsf@jidanni.org> <87fxjhcy3i.fsf@jidanni.org>
 <81b0412b0901171538l5e9fb66bh862c9b7a125fc98f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 18 01:44:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOLmC-00067G-Tf
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 01:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755832AbZARAkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 19:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755689AbZARAkn
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 19:40:43 -0500
Received: from main.gmane.org ([80.91.229.2]:36969 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755052AbZARAkm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 19:40:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LOLiS-0000QY-LB
	for git@vger.kernel.org; Sun, 18 Jan 2009 00:40:40 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 00:40:40 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 00:40:40 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106117>

On 2009-01-17, Alex Riesen <raa.lkml@gmail.com> wrote:
> 2009/1/18  <jidanni@jidanni.org>:
>> Can I get a go-ahead from somebody for me to begin work
>> on implementing a fix?
>
> No. Try and guess why

OK, I'll bite...

Because it's only used as the date for the mbox format
leader line, and not an actual email (RFC 822/2822) header
line?  And in that format it represents "delivery date",
which is irrelevant for stuff you're generating to be sent
out anyway, meaning this line doesn't actually get sent out
to anyone when you mail your patches, so we don't care what
it is.

I can't think of anything else, so if it isn't that please
do tell.  Not that I cared about it before, but once someone
says "try and guess why" it somehow becomes important :-)
