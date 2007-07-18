From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Empty directories...
Date: Wed, 18 Jul 2007 10:06:13 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site>
 <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
 <vpq4pk1vf7q.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jul 18 19:12:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBD4o-0006of-84
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 19:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859AbXGRRMe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 13:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758751AbXGRRMe
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 13:12:34 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35675 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755022AbXGRRMd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 13:12:33 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6IH6Iqn027091
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jul 2007 10:06:20 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6IH6DNC019690;
	Wed, 18 Jul 2007 10:06:13 -0700
In-Reply-To: <vpq4pk1vf7q.fsf@bauges.imag.fr>
X-Spam-Status: No, hits=-2.669 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52882>



On Wed, 18 Jul 2007, Matthieu Moy wrote:
> 
> If you checkout a branch, create an empty directory in this branch
> (probably a placeholder, either for future versionned files, or for
> generated files), you cannot tell git "this empty directory is in this
> branch, but not in other ones" without adding a file in it.

Right. Which is the suggested setup: add an empty ".gitignore" file to the 
directory, and you're done. It now acts "as if" git tracked the directory 
(git will remove the directory when switching branches), but without the 
lie that we really track any directory contents.

			Linus
