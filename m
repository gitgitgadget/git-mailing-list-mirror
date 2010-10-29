From: Mathias Lafeldt <misfire@debugon.org>
Subject: Re: Unable to remove git branch
Date: Fri, 29 Oct 2010 09:54:16 +0200
Message-ID: <4CCA7DA8.3020607@debugon.org>
References: <201010290943.13177.sasch.pe@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sascha Peilicke <sasch.pe@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 29 09:54:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBjn8-0006QH-K7
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 09:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759106Ab0J2HyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 03:54:23 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:55908 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756477Ab0J2HyW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 03:54:22 -0400
Received: from [172.20.2.23] (p578D1B63.dip.t-dialin.net [87.141.27.99])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0Lsfxh-1ORq7s0wfJ-012ICP; Fri, 29 Oct 2010 09:54:19 +0200
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <201010290943.13177.sasch.pe@gmx.de>
X-Provags-ID: V02:K0:UfsU3eOexKzMjtx+OUM5NnFa2O2ot/2hCAgIYKf/PRd
 5Ki1w0kLWroUTYax7DbKUadQVy8zh9RbkwYF9+fEsxWP/764Lh
 cVodERgP1yDL2//zmVLigYQDMBsj7yQKZlhPPLJ9M1fl9bTwxx
 k6sPdsA/Dxz/b2x6eI9NjkAcBAIxq/0wbYsr5qt72Fx8BEsw2K
 VDxz93DxFRDqvBCtk5kUnmjZu7Eo7j6owFTBeEdtGE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160314>

Sascha Peilicke wrote:
> Hi guys,
> 
> I accidentally did an 'git co -b --track origin/foo' ending up with a local 
> branch '--track'. Sadly, git is unable to remove or rename that branch because 
> it always interprets it as a parameter. 
> 
> As a consequence, 'git br -d "--track"' does nothing and 'git br -m "--track" 
> foo' even renames the current branch, say, master,  to 'foo'. Any hints on how 
> to get rid of that pesky branch?
> 
> BTW please CC me as I'm not subscribed to this list.

Try:

$ git br -D -- --track

-Mathias
