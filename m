From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] INSTALL: git-merge no longer uses cpio
Date: Wed, 6 Feb 2008 22:46:12 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802062245010.8543@racer.site>
References: <20080206070353.6559.qmail@2b033f98573ecd.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 23:47:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMt3G-0004fB-On
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 23:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759124AbYBFWrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 17:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758813AbYBFWrA
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 17:47:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:56031 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758309AbYBFWq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 17:46:58 -0500
Received: (qmail invoked by alias); 06 Feb 2008 22:46:57 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp034) with SMTP; 06 Feb 2008 23:46:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18AGk199JoAmqKh/VPW0hEqIFTUsPbr9ym9Ur1fIv
	iS61GbW2EB2hjQ
X-X-Sender: gene099@racer.site
In-Reply-To: <20080206070353.6559.qmail@2b033f98573ecd.315fe32.mid.smarden.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72867>

Hi,

On Wed, 6 Feb 2008, Gerrit Pape wrote:

> Since a64d7784e830b3140e7d0f2b45cb3d8fafb84cca git merge doesn't use cpio
> anymore, adapt the documentation.

$ git grep cpio | cut -c1-60
INSTALL:        - "cpio" is used by git-merge for saving and restor
git-clone.sh:           find objects -depth -print | cpio -pumd$l "$G
git-gui/Makefile:INSTALL_A1 = | cpio -pud
git-gui/Makefile:       INSTALL_A1 = && echo '   ' INSTALL '   ' `

So it seems that git-clone still relies on it.

Ciao,
Dscho
