From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: What is the idea for bare repositories?
Date: Mon, 12 Nov 2007 11:19:27 -0200
Message-ID: <20071112131927.GA1701@c3sl.ufpr.br>
References: <86k5on8v6p.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 14:46:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrZcW-0003OF-NR
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 14:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758393AbXKLNqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 08:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758344AbXKLNqP
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 08:46:15 -0500
Received: from mx.c3sl.ufpr.br ([200.17.202.3]:49493 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758260AbXKLNqO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 08:46:14 -0500
X-Greylist: delayed 1597 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Nov 2007 08:46:14 EST
Received: from localhost (temari.c3sl.ufpr.br [200.17.202.89])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 137F73019A30;
	Mon, 12 Nov 2007 11:19:33 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <86k5on8v6p.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64619>

A bare repository is the way to publish your changes to the public.
git-daemon  and http-clones use a bare repository that only contains
adminsitrative files.

>From man page
       --bare Make a bare GIT repository. That is, instead of creating
              <directory> and placing the administrative files in
              <directory>/.git, make the <directory> itself the $GIT_DIR. This
              obviously implies the -n because there is nowhere to check out
              the working tree. Also the branch heads at the remote are copied
              directly to corresponding local branch heads, without mapping
              them to refs/remotes/origin/. When this option is used, neither
              remote-tracking branches nor the related configuration variables
              are created.

On Mon, Nov 12, 2007 at 02:11:58PM +0100, David Kastrup wrote:
> 
> Hi,
> 
> I have a repository declared as bare.  Some commands treat it as such,
> other's don't.  For example, I get
> 
> git-diff [no complaint]
> git-status
> fatal: /usr/local/bin/git-status cannot be used without a working tree.
> git-reset [no complaint]
> git-reset --hard
> HEAD is now at db862c1... installmanager.sh: setze GIT_WORK_TREE
> git-commit
> fatal: /usr/local/bin/git-commit cannot be used without a working tree.
> git-add
> fatal: This operation must be run in a work tree
> 
> So this is all somewhat inconsistent.  What is the situation supposed
> to be?
> 
> -- 
> David Kastrup
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br 
