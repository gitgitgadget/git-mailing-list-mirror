From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] run-command.c: remove run_command_v_opt_cd()
Date: Thu, 2 Oct 2008 13:09:01 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810021304360.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20081002191425.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 13:04:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlLyN-0004HS-UB
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 13:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316AbYJBLCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 07:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752875AbYJBLCq
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 07:02:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:57091 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751697AbYJBLCp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 07:02:45 -0400
Received: (qmail invoked by alias); 02 Oct 2008 11:02:43 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp064) with SMTP; 02 Oct 2008 13:02:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19MhDpHjohMyBtBq4jjt7xsi0k8rAIugd5Qo3h9XX
	BxxbFj3p2Nxfej
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081002191425.6117@nanako3.lavabit.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97313>

Hi,

On Thu, 2 Oct 2008, Nanako Shiraishi wrote:

> This function is not used anywhere.

I have to say that it fills me with sorrow, seeing that the direction 
these patches take is the _opposite_ of libifying Git.  So far I was only 
disappointed that nobody pushed this goal, but now I am concerned that 
anybody thinking about it is actively discouraged.

Just think about Git Cheetah: if it were ever to benefit from an official 
libgit, then the function you remove would be _ideal_.  By removing that 
function, you make it even less attractive to try to use Git as a proper 
library.

Ciao,
Dscho
