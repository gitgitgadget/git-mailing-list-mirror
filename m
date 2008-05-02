From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Update German translation
Date: Fri, 2 May 2008 21:49:14 +1000
Message-ID: <18458.65466.449698.790306@cargo.ozlabs.ibm.com>
References: <200805012142.10151.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Fri May 02 13:50:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrtmA-0003l9-Sd
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 13:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762197AbYEBLtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 07:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761577AbYEBLtT
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 07:49:19 -0400
Received: from ozlabs.org ([203.10.76.45]:41567 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759596AbYEBLtT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 07:49:19 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 9EB51DDDFF; Fri,  2 May 2008 21:49:17 +1000 (EST)
In-Reply-To: <200805012142.10151.stimming@tuhh.de>
X-Mailer: VM 7.19 under Emacs 22.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80980>

Christian Stimming writes:

> Attached to avoid whitespace problems. This patch is against master of 
> gitk.git at git.kernel.org.

Thanks.

> By the way, the following two keybinding explanations seem ambiguous to me:
> 
> >   <Home>  Move to first commit
> >   <End>   Move to last commit
> 
> What happens is that <home> jumps to the newest commit and <end> jumps to the 
> oldest commit. Whether the "first" commit should be the newest or the oldest 
> is, well, somewhat ambiguous. I'd propose to talk about the newest or topmost 
> commit, but rather not about the "first".

Well, the commits aren't in date order, strictly speaking, and the
last commit isn't necessarily the oldest (though the first commit will
in fact be the newest).  How about:

<Home>	Move to head of list
<End>	Move to tail of list

Would that be any clearer?

Paul.
