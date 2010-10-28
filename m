From: Mathias Lafeldt <misfire@debugon.org>
Subject: Re: fatal: ambiguous argument 'HEAD^': unknown revision or path not
 in the working tree.
Date: Thu, 28 Oct 2010 15:42:32 +0200
Message-ID: <4CC97DC8.1010508@debugon.org>
References: <loom.20101028T150254-457@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Todd Wells <ttopwells@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 15:42:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBSki-0005NL-E5
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 15:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758766Ab0J1Nmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 09:42:39 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:49715 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758694Ab0J1Nmh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 09:42:37 -0400
Received: from [172.20.2.23] (p578D1ACA.dip.t-dialin.net [87.141.26.202])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0Lbevf-1OjEby43iN-00kpQl; Thu, 28 Oct 2010 15:42:34 +0200
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <loom.20101028T150254-457@post.gmane.org>
X-Provags-ID: V02:K0:ZDZJa9yZeGMOz7pOgvDpGivnakYrZ6QeQLncShY3Nrw
 iHkG5kc0uzcfG4CbDC/VWve84riT5EkWrIw73thUKTjuX3Ekes
 PMiUPi9ei5EmMvugTurQOmhk679TSBvxWm4H34OUeyK7zkEUnV
 k/9Av55z+U2UlBE94h50M7/sehBrVX6Y1ClP0wI5j2PyT4AgPv
 wVsknWb3GUM31T4dZi59XM30ziJecTDKA4lmEDzjB4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160175>

Todd Wells wrote:
> I was using GitX to prepare a commit. Something happened -- I don't 
> know what --  and suddenly my branch only had a single commit 
> in it that appears to contain all  the files in my tree. So I went to the 
> command line and did this:
> 
> $ git reset --soft HEAD^ 
> fatal: ambiguous argument 'HEAD^': unknown revision or path not 
> in the working tree.
> 
> When I do 'git log' in this branch, there's only one commit. Now, I 
> had many commits in this branch a few minutes ago. I really, 
> really, don't want to lose this.
> 
> What steps should I take to attempt to recover?

Check if you can reset your HEAD to a previous state saved in your
(local) reflog.

See section "RefLog Shortnames" in http://progit.org/book/ch6-1.html

-Mathias
