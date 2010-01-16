From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] [PATCH] Installer: Create builtins as symbolic links
 on Vista
Date: Sat, 16 Jan 2010 01:41:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001160139070.4985@pacific.mpi-cbg.de>
References: <1263593219-6032-1-git-send-email-michael.lukashov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit <msysgit@googlegroups.com>, git@vger.kernel.org,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 01:35:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVwdc-0006VN-VQ
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 01:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951Ab0APAfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 19:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754849Ab0APAfd
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 19:35:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:34532 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754307Ab0APAfc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 19:35:32 -0500
Received: (qmail invoked by alias); 16 Jan 2010 00:35:30 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 16 Jan 2010 01:35:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18QlrtOWVEQNvhPj6a5SE0XrtWD8lMM8Q133Ic3aY
	WM81IfPgiMuMm/
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1263593219-6032-1-git-send-email-michael.lukashov@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137173>

Hi,

On Fri, 15 Jan 2010, Michael Lukashov wrote:

> When create builtins, first try to use CreateSymbolicLinkW function. If 
> symbolic link creating fails, hard links are created.
> 
> Tested under WinXP (both FAT32 and NTFS), Vista and Win7.
> 
> This patch applies on top of ss/installer-improvements branch.

The commit message is a wonderful place to convince readers that the 
patched code has a tremendous advantage over the existing code.

Maybe you forgot to add this discussion?

Ciao,
Dscho

P.S.: I am quite sure that the Git mailing list is maybe better suited for 
patches to the Git source code rather than for patches to the InnoSetup 
code of Git for Windows.
