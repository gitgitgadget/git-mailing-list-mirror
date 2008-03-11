From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 06/10] Completely move out worktree setup from
 setup_git_directory_gently()
Date: Tue, 11 Mar 2008 14:31:48 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803111429380.3873@racer.site>
References: <cover.1204453703.git.pclouds@gmail.com> <20080302103433.GA8970@laptop>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-264883886-1205242308=:3873"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 14:32:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ4ad-0007xh-8J
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 14:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbYCKNbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 09:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbYCKNbo
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 09:31:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:50179 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751085AbYCKNbn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 09:31:43 -0400
Received: (qmail invoked by alias); 11 Mar 2008 13:31:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp043) with SMTP; 11 Mar 2008 14:31:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+hyE80NROhQC8rwQjEVpKA3isG1vjzRib+AR1ZQq
	BMEnfNwk/7wzdV
X-X-Sender: gene099@racer.site
In-Reply-To: <20080302103433.GA8970@laptop>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76844>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-264883886-1205242308=:3873
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 2 Mar 2008, Nguyễn Thái Ngọc Duy wrote:

> This was impossible earlier because git_dir can be relative. Now that
> git_dir is absolute, I see no reason for worktree setup inside
> setup_git_directory_gently(). The semantic is now clearer: if you need
> worktree, call setup_work_tree yourself (well, I will clean up
> setup_git_directory() part later)

As I said earlier, the work for getting the prefix as most likely be done 
already in the search for .git/.  I mean, it _is_ the common case to have 
a working tree with a .git/ in it, and that's it.

So I am quite certain that it is not worth the complicated and intrusive 
patch to separate the logic.

Particularly since working tree has a bad reputation already, as Junio 
pointed out: whenever we touch it, we get burnt.

Ciao,
Dscho
--8323584-264883886-1205242308=:3873--
