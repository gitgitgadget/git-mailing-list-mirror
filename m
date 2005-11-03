From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Now What?
Date: Thu, 3 Nov 2005 23:33:13 +0100
Message-ID: <200511032333.13823.Josef.Weidendorfer@gmx.de>
References: <E1EXTw5-00063o-Gt@jdl.com> <Pine.LNX.4.64.0511031151070.25300@iabervon.org> <7vll05bd1w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Nov 03 23:35:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXne5-0001gT-Sc
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 23:33:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbVKCWdR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 17:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbVKCWdR
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 17:33:17 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:40649 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751393AbVKCWdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 17:33:16 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id C24E527BC
	for <git@vger.kernel.org>; Thu,  3 Nov 2005 23:33:15 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <7vll05bd1w.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11104>

On Thursday 03 November 2005 23:07, Junio C Hamano wrote:
> I wonder if it would make sense to have something in .git/remotes/
> file that says "run merge only when I am on frotz branch", like
> this:
> 
>         ~/git/git-core]cat .git/remotes/origin
>         URL: git://git.kernel.org/pub/scm/git/git.git
>         Pull: master:origin
> 	Fetch-Only-Unless: master
> 
>         ~/git/git-core]git-checkout maint
> 	~/git/git-core]git pull
> 	warning: not merging because you are not on 'master' branch.

This is quite limiting, if you keep multiple branches from origin in your
repository.
It would be better to be able to specify per-branch Pull lines. I.e. the
default pull action depends on the branch you are on.

        URL: git://git.kernel.org/pub/scm/git/git.git
        Pull(master): master:origin

        ~/git/git-core]git-checkout maint
 	~/git/git-core]git pull
 	warning: no default pull action for branch 'maint' specified

Syntax arguable.

Josef
