From: Mike Hommey <mh@glandium.org>
Subject: Re: git fetch workflow improvements
Date: Sat, 9 Feb 2008 14:27:45 +0100
Organization: glandium.org
Message-ID: <20080209132745.GA13997@glandium.org>
References: <3f4fd2640802090257m9ab8e24l2a836abfd2ef6bf@mail.gmail.com> <alpine.LSU.1.00.0802091318080.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Reece Dunn <msclrhd@googlemail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 09 14:27:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNpkE-00067m-5q
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 14:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292AbYBIN1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 08:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752920AbYBIN1P
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 08:27:15 -0500
Received: from vuizook.err.no ([85.19.215.103]:55404 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150AbYBIN1P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 08:27:15 -0500
Received: from aputeaux-153-1-42-109.w82-124.abo.wanadoo.fr ([82.124.6.109] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JNpkV-0005wq-Aw; Sat, 09 Feb 2008 14:28:14 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JNpk9-0003je-Fi; Sat, 09 Feb 2008 14:27:45 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802091318080.11591@racer.site>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73226>

On Sat, Feb 09, 2008 at 01:20:29PM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 9 Feb 2008, Reece Dunn wrote:
> 
> > I have some ideas on improvements I would like to make to git fetch. I 
> > am not familiar with the implementation details of builtin-fetch.c and 
> > friends, and having a brief look at the implementation I am unsure how 
> > to proceed.
> > 
> > The ideas for improvements I have are:
> > 
> >     1.  When running `git fetch` on a bare repository that does not have 
> > a remote called 'origin', fetch fails. I would like this to pick up the 
> > first remote entry in the config file.
> 
> I am opposed to that.  If you want a default remote, then set the remote 
> "origin".  That is well established semantics, and you would only confuse 
> yourself if all of a sudden you fetched from a remote that you erroneously 
> added at some stage.
> 
> >     2.  When mirroring a repository such as the Linux kernel and its 
> > stable repositories in the same git repository, it would be useful to be 
> > able to fetch the latest data from all the remotes that you are tracking 
> > in the config file. I envision this being done by running `git fetch 
> > -all`.
> 
> $ git remote update

BTW, is the following normal?

$ git remote update origin
Remote group origin does not exists.

(there *is* an origin remote)

Mike
