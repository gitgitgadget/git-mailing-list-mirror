From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add missing inside_work_tree setting in setup_git_directory_gently
Date: Sat, 3 Nov 2007 13:25:24 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711031325150.4362@racer.site>
References: <20071103100323.GA25305@laptop> <20071103131806.GA25109@laptop>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1143090864-1194096324=:4362"
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 14:26:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoJ1B-0004PA-0S
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 14:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753933AbXKCN0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 09:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753849AbXKCN0P
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 09:26:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:42942 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753841AbXKCN0O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 09:26:14 -0400
Received: (qmail invoked by alias); 03 Nov 2007 13:26:10 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp034) with SMTP; 03 Nov 2007 14:26:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3KIc1+fj3tHNtL6QExNuHjZFUU7pXhEcUWa0JTK
	KF2erHS3bFwBZ3
X-X-Sender: gene099@racer.site
In-Reply-To: <20071103131806.GA25109@laptop>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63267>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1143090864-1194096324=:4362
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 3 Nov 2007, Nguyễn Thái Ngọc Duy wrote:

> When both GIT_DIR and GIT_WORK_TREE are set, and
> setup_git_directory_gently() changes the current working
> directory accordingly, it should also set inside_work_tree = 1.
> 
> Without this, work_tree handling code in setup_git_directory()
> will be activated. If you stay in root work tree (no prefix),
> it does not harm. It does if you work from a subdirectory though.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Updated commit message accordingly

Thanks,
Dscho
--8323584-1143090864-1194096324=:4362--
