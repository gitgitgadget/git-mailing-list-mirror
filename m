From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/9] Completely move out worktree setup from
 setup_git_directory_gently()
Date: Thu, 28 Feb 2008 11:26:55 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802281124420.22527@racer.site>
References: <cover.1204130175.git.pclouds@gmail.com> <20080227163934.GA28084@laptop>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1892268629-1204198016=:22527"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 12:28:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUgvk-0002be-Gg
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 12:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756906AbYB1L12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 06:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756890AbYB1L12
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 06:27:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:52313 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756789AbYB1L11 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 06:27:27 -0500
Received: (qmail invoked by alias); 28 Feb 2008 11:27:25 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp004) with SMTP; 28 Feb 2008 12:27:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jtppR4MSjPo3nsoQSeXEpYEfUgCoWom9R7p3wNd
	CxXpoyiNGZ2Pbt
X-X-Sender: gene099@racer.site
In-Reply-To: <20080227163934.GA28084@laptop>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75386>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1892268629-1204198016=:22527
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 27 Feb 2008, Nguyễn Thái Ngọc Duy wrote:

> This was impossible earlier because git_dir can be relative. Now that
> git_dir is absolute, I see no reason for worktree setup inside
> setup_git_directory_gently().

I do see it, though.  Why make the users work harder?  If you want to get 
the git directory, chances are that you want to work with a worktree, too.

And you really cannot properly separate worktree detection from git 
directory detection: in most of the cases, you will find them at the 
_same_ time (if .git/ is the git directory, the working directory is .).

So I am mildly negative on the thrust of your patch series.

Ciao,
Dscho

---1463811741-1892268629-1204198016=:22527--
