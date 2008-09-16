From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
Date: Tue, 16 Sep 2008 13:26:33 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0809161316030.19665@iabervon.org>
References: <98627.82548.qm@web95002.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Brown <git@davidb.org>, Junio C Hamano <gitster@pobox.com>,
	GIT SCM <git@vger.kernel.org>, Simon Hausmann <simon@lst.de>
To: dhruva <dhruva@ymail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 19:27:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfeL1-0002IL-NQ
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 19:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277AbYIPR0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 13:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753273AbYIPR0f
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 13:26:35 -0400
Received: from iabervon.org ([66.92.72.58]:39706 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753214AbYIPR0f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 13:26:35 -0400
Received: (qmail 4680 invoked by uid 1000); 16 Sep 2008 17:26:33 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Sep 2008 17:26:33 -0000
In-Reply-To: <98627.82548.qm@web95002.mail.in2.yahoo.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96020>

On Tue, 16 Sep 2008, dhruva wrote:

> Hi,
> 
> 
> 
> ----- Original Message ----
> > From: David Brown <git@davidb.org>
> > Part of the problem is that p4 isn't very good at knowing whether
> > files have changed or not.  'p4 sync' will update the file _if_ if
> > thinks your version is out of date, but it does nothing if someone has
> > locally modified the file, hence the need for the 'p4 sync -f'.
> 
> If you have modified a file without doing a 'p4 edit' and if there is a 
> new version of the edited file on p4 (from what you have got from a 
> previous 'p4 sync'), 'p4 sync' will overwrite your changes (if the file 
> does not have write perm set or if you have enabled clobbering of 
> writable files). Whereas 'p4 sync -f' will always overwrite all unopened 
> files if a newer version is available.  

p4 sync -f will overwrite all unopened files. It will clobber writable 
files, and it will clobber files where there isn't a newer file (it's one 
of the ways of dealing with accidentally erasing your workspace).

	-Daniel
*This .sig left intentionally blank*
