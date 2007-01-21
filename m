From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] Add new 'rebase' command.
Date: Mon, 22 Jan 2007 00:26:18 +0100
Message-ID: <20070121232618.GD4665@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070120180329.22621.30534.stgit@gandelf.nowhere.earth> <b0943d9e0701211500v2f54aa61k2592ba060131318@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 00:27:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8m5d-0008PF-Pj
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 00:27:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbXAUX0w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 18:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbXAUX0w
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 18:26:52 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:60951 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779AbXAUX0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 18:26:52 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id F10F147E9D;
	Mon, 22 Jan 2007 00:26:49 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id F2EDB2014; Mon, 22 Jan 2007 00:26:18 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0701211500v2f54aa61k2592ba060131318@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37361>

On Sun, Jan 21, 2007 at 11:00:57PM +0000, Catalin Marinas wrote:
> On 20/01/07, Yann Dirson <ydirson@altern.org> wrote:
> >Take two: I had forgotten to add "rebase" to the list of stack
> >commands for the purpose of help.
> 
> Thanks for the patch. I also added the command to the stgit-completion.bash.
> 
> I applied it but changed the patch a bit so that there is no need for
> the --to option. I understood your point but I find it a bit strange
> to have this mandatory option. Anyway, command line syntax doesn't
> have to follow the natural language exactly :-).

Well, I thought the natural next patch to this command would be,
according to the discussions with Jakub, to make first "--to target"
optional, as a natural replacement for "stg pull . <target>" when the
target is the parent branch, and then possibly add the ability of
running rebase from the target branch as also sugested by Jakub,
leading to the natural "rebase [<stack>|--to <target>]" syntax.

Although I'm not sure we'll do that in the near future, removing the
need for --to would somewhat get in the way of this possibility.

Best regards,
-- 
Yann.
