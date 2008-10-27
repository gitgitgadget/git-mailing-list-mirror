From: "Pascal Obry" <pascal@obry.net>
Subject: Re: rebase, file permissions and removed file
Date: Mon, 27 Oct 2008 16:09:57 +0100
Message-ID: <a2633edd0810270809w7fec93b2rc314cc025f41d41f@mail.gmail.com>
References: <a2633edd0810270702x416bb659ke183b0cc6266071@mail.gmail.com>
	 <4905D276.9020308@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 27 16:11:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuTkQ-0001To-HV
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 16:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbYJ0PJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 11:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbYJ0PJ6
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 11:09:58 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:36721 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbYJ0PJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 11:09:58 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2175370rvb.1
        for <git@vger.kernel.org>; Mon, 27 Oct 2008 08:09:57 -0700 (PDT)
Received: by 10.141.51.15 with SMTP id d15mr3320176rvk.106.1225120197359;
        Mon, 27 Oct 2008 08:09:57 -0700 (PDT)
Received: by 10.141.51.13 with HTTP; Mon, 27 Oct 2008 08:09:57 -0700 (PDT)
In-Reply-To: <4905D276.9020308@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99236>

On Mon, Oct 27, 2008 at 3:38 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Since you don't have any content to lose, you can always just
>
>  $ touch file1
>  $ git add file1
>  $ git rm file1

Does not work:

$ git rebase --continue
Applying: Fix perm file1
No changes - did you forget to use 'git add'?

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".



The only solution I found is to abort the rebase, edit my topic branch (fixperms
in this example) to remove file1 from the commit and redo the rebase... Not
that simple especially since there was many other commits on my topic branch.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
