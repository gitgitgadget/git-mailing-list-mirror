From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 04/10] Make setup_work_tree() return new prefix
Date: Tue, 11 Mar 2008 14:27:21 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803111426521.3873@racer.site>
References: <cover.1204453703.git.pclouds@gmail.com> <20080302103405.GA8942@laptop>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-797168556-1205242043=:3873"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 14:28:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ4WP-0006R7-5B
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 14:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbYCKN1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 09:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752276AbYCKN1V
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 09:27:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:41817 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751059AbYCKN1U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 09:27:20 -0400
Received: (qmail invoked by alias); 11 Mar 2008 13:27:17 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp035) with SMTP; 11 Mar 2008 14:27:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX194htZP2Lt4PrxSGjvg42Em1M1q4N0t9ae2wimYOT
	tYGzRSgQ6+IOEl
X-X-Sender: gene099@racer.site
In-Reply-To: <20080302103405.GA8942@laptop>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76842>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-797168556-1205242043=:3873
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 2 Mar 2008, Nguyễn Thái Ngọc Duy wrote:

> worktree setup inside setup_git_directory*() is not perfect. It does not 
> take core.worktree into account. So when you do setup_work_tree(), the 
> real work tree may be not the one setup_git_directory*() gives you. You 
> need a new prefix in that case.

Probably the real fix would be to setup_git_directory(), no?

Ciao,
Dscho

--8323584-797168556-1205242043=:3873--
