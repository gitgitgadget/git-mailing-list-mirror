From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH] Have git-revert, git-cherry-pick cleanup ./.msg upon successful completion.
Date: Mon, 7 May 2007 07:46:55 +0000
Message-ID: <20070507074655.14670.qmail@7aab74a0460bd8.315fe32.mid.smarden.org>
References: <20070504143022.8539.qmail@4071cc1c178e73.315fe32.mid.smarden.org> <20070504143210.8690.qmail@a4171e0dbe98e3.315fe32.mid.smarden.org> <20070505034615.GE16538@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 09:46:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkxvb-0005Gz-I0
	for gcvg-git@gmane.org; Mon, 07 May 2007 09:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbXEGHqg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 03:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbXEGHqg
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 03:46:36 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:60498 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752784AbXEGHqg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 03:46:36 -0400
Received: (qmail 14671 invoked by uid 1000); 7 May 2007 07:46:55 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070505034615.GE16538@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46424>

On Fri, May 04, 2007 at 11:46:15PM -0400, Shawn O. Pearce wrote:
> Gerrit Pape <pape@smarden.org> wrote:
> > git-revert and git-cherry-pick left behind the commit message file ./.msg,
> > have them use the -f option to git-commit to properly cleanup the
> > automatically created file.
> 
> I'm actually sort of against changing the behavior of git-commit
> -f to mean "delete the file".  We never did that before.  Users
> might get surprised when their file goes away!

-f never was documented AFAICS, only -F, and even though the file is
gone, the commit message is available through git show then.  I
personally would like to have such an option to git commit regardless of
revert and cherry-pick.

I concur with Alex that the teporary file should be in the git directory
and not working directory.

Regards, Gerrit.
