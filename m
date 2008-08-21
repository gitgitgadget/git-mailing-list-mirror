From: Sverre Hvammen Johansen <hvammen@gmail.com>
Subject: Re: Call Me Gitless
Date: Thu, 21 Aug 2008 03:40:52 +0000 (UTC)
Message-ID: <loom.20080821T031647-276@post.gmane.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com> <alpine.LNX.1.00.0808181512160.19665@iabervon.org> <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808181628420.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 05:42:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW13p-0004MS-7h
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 05:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbYHUDlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 23:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752793AbYHUDlE
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 23:41:04 -0400
Received: from main.gmane.org ([80.91.229.2]:33841 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982AbYHUDlC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 23:41:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KW12h-0001FO-Ps
	for git@vger.kernel.org; Thu, 21 Aug 2008 03:41:00 +0000
Received: from c66-235-35-214.sea2.cablespeed.com ([66.235.35.214])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 03:40:59 +0000
Received: from hvammen by c66-235-35-214.sea2.cablespeed.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 03:40:59 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.235.35.214 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9) Gecko/2008061816 Remi/fc7 Firefox/3.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93109>

Daniel Barkalow <barkalow <at> iabervon.org> writes:
> I think that having the possibility of adding an empty blob (or maybe a 
> magical "nothing currently here but git-ls-files includes it") would be 
> preferrable to a no-index mode. That is, the operation that corresponds 
> most directly to "cvs add <filename>" is "git update-index --cacheinfo 
> 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 <filename>", which is not 
> exactly easy to do, and just because a user wants to do this doesn't mean 
> the user doesn't want to use the index; a user that makes extensive use of 
> the index is actually more likely to want the state where a file is 
> tracked but all of the content has not yet been staged.

I think it would be more natural if we had two commands for this; 'add' and
'keep/cache/stage'.  The add command would add the file not the content to the
index and the keep command would add the content.  We could then have an
auto-keep option for the add command and an auto-add option for the keep
command.  By setting both of these options they would give current behaviour for
add.

-- 
Sverre Hvammen Johansen
