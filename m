From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH v2] Teach 'git pull' about --rebase
Date: Wed, 28 Nov 2007 12:35:57 -0800
Message-ID: <27E5EF3C-19EF-441C-BB12-0F5B29BEAEDB@midwinter.com>
References: <Pine.LNX.4.64.0710252351130.4362@racer.site> <alpine.LFD.0.999.0710251602160.30120@woody.linux-foundation.org> <Pine.LNX.4.64.0710260007450.4362@racer.site> <7v3avy21il.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0710261047450.4362@racer.site> <7v3aurcjpq.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711281307420.27959@racer.site>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 21:36:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxTdx-0007p6-Nv
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 21:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757641AbXK1UgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 15:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754364AbXK1UgA
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 15:36:00 -0500
Received: from tater.midwinter.com ([216.32.86.90]:38619 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754167AbXK1Uf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 15:35:59 -0500
Received: (qmail 29626 invoked from network); 28 Nov 2007 20:35:59 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=N9VH/IXuC87iON6U4fYbn89kyW1SjG1+fr/59sQ1x0SZgSj2mgmgJamsv3ZOow5W  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 28 Nov 2007 20:35:59 -0000
In-Reply-To: <Pine.LNX.4.64.0711281307420.27959@racer.site>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66422>

On Nov 28, 2007, at 5:11 AM, Johannes Schindelin wrote:
> As a convenience, you can set the default behavior for a branch by
> defining the config variable branch.<name>.rebase, which is
> interpreted as a bool.  This setting can be overridden on the command
> line by --rebase and --no-rebase.

I wonder if this shouldn't be branch.<name>.pulltype or something like  
that, so we can represent more than just "rebase or not." Values could  
be "rebase", "merge" (the default) and maybe even "manual" to specify  
that git-pull should neither merge nor rebase a particular branch even  
if it matches a wildcard refspec.

Not too sure about that last suggestion but it seems like there might  
be other settings than "rebase" and "merge" in the future even if  
that's not one of them.

-Steve
