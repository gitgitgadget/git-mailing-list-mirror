From: Johan Herland <johan@herland.net>
Subject: Re: __git_ps1 not showing submodule dirty state
Date: Thu, 31 Dec 2009 02:40:07 +0100
Message-ID: <200912310240.07741.johan@herland.net>
References: <A98B75F4-B9BD-4CB4-9335-754C59ECB64F@sb.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Kevin Ballard <kevin@sb.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 31 02:40:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQA1W-0007Jj-0f
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 02:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbZLaBkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 20:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752827AbZLaBkM
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 20:40:12 -0500
Received: from smtp.getmail.no ([84.208.15.66]:39993 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752640AbZLaBkL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Dec 2009 20:40:11 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KVH00HEPTYWXN50@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 31 Dec 2009 02:40:08 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KVH00LKGTYWFT20@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 31 Dec 2009 02:40:08 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.12.31.12719
User-Agent: KMail/1.12.4 (Linux/2.6.31-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <A98B75F4-B9BD-4CB4-9335-754C59ECB64F@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135928>

On Wednesday 30 December 2009, Kevin Ballard wrote:
> Why does the __git_ps1 function in git-completion.bash explicitly ignore
>  submodules when showing the GIT_PS1_SHOWDIRTYSTATE status? The most
>  common issue with my current repository is not realizing when submodules
>  need to be updated because I blindly trust my prompt to tell me when I
>  have dirty state.

According to git blame, it has been there since GIT_PS1_SHOWDIRTYSTATE was 
introduced in 738a94a... by Thomas Rast (CCed), but the commit message does 
not say why submodules are explicitly ignored.

FWIW, I agree with Kevin, and would like changed submodules to be included 
in the status.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
