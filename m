From: Brian Smith <linuxfood@linuxfood.net>
Subject: Re: Tracking and committing back to Subversion?
Date: Thu, 9 Feb 2006 16:50:54 -0800
Message-ID: <200602091650.55370.linuxfood@linuxfood.net>
References: <1138834301.21899.40.camel@wilber.wgtn.cat-it.co.nz> <200602040727.30965.linuxfood@linuxfood.net> <43E7DA7F.6060503@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 01:51:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7MV1-0004r9-Oj
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 01:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWBJAu5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 19:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWBJAu5
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 19:50:57 -0500
Received: from [67.124.82.122] ([67.124.82.122]:41031 "EHLO linuxfood.net")
	by vger.kernel.org with ESMTP id S1750905AbWBJAu5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 19:50:57 -0500
Received: (qmail 9421 invoked from network); 9 Feb 2006 16:50:56 -0800
Received: from unknown (HELO borealis.linuxfood.net) (192.168.1.2)
  by 192.168.1.6 with AES256-SHA encrypted SMTP; 9 Feb 2006 16:50:56 -0800
To: Sam Vilain <sam@vilain.net>
User-Agent: KMail/1.9
In-Reply-To: <43E7DA7F.6060503@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15851>

On Monday 06 February 2006 15:23, Sam Vilain wrote:
> >>Has anyone done any work on bidirectional access to SVN repositories?
> >>ie, tracking and committing.
> >
>> [snip]
>
> Indeed, mirroring SVN repositories via SVN::Mirror (which is used by
> SVK) can take hours for large projects with thousands of commits.
>

Actually, I wasn't so much talking about the time required as the fact that
git-svnimport expects a very specific directory format, and KDE, since it was
migrated from CVS doesn't follow it, not to mention, I'm writing my tools
for the purpose of tracking single projects (i.e. Kopete which is part of KDE 
project).

>> [snip]
>
> Right; I was looking for an approach that did not require working copies
> of the remote subversion repository to be kept locally.  Still, perhaps
> that approach has merit, though I would probably start in Perl and use
> SVK::Simple (see CPAN) to give a richer SVN mirroring API.
>

While that is an admirable goal, unless you can point me to something that
will allow you to actually commit back to SVN without a working copy, it 
defeats the purpose of my tools which is basically to use to git for the 
purpose of holding intermediate development before sending it into SVN as a 
final commit. That, and being able to use git tools which speak to me on a 
level far greater than SVN tools. ;)

> Are you planning on publishing these scripts?
>

Sure, you can actually pick up the current development straight from
git://linuxfood.net/pub/git/kosek.git

Brian
