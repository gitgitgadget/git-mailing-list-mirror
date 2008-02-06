From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] INSTALL: git-merge no longer uses cpio
Date: Wed, 6 Feb 2008 23:55:05 +0100
Organization: glandium.org
Message-ID: <20080206225505.GA16181@glandium.org>
References: <20080206070353.6559.qmail@2b033f98573ecd.315fe32.mid.smarden.org> <alpine.LSU.1.00.0802062245010.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 23:56:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMtBx-0007vQ-BI
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 23:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758901AbYBFWzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 17:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760540AbYBFWzN
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 17:55:13 -0500
Received: from vuizook.err.no ([85.19.215.103]:34034 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760475AbYBFWzL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 17:55:11 -0500
Received: from aputeaux-153-1-42-109.w82-124.abo.wanadoo.fr ([82.124.6.109] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JMtBP-0007iy-GH; Wed, 06 Feb 2008 23:56:05 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JMtAX-0004EN-1Q; Wed, 06 Feb 2008 23:55:05 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802062245010.8543@racer.site>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72869>

On Wed, Feb 06, 2008 at 10:46:12PM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 6 Feb 2008, Gerrit Pape wrote:
> 
> > Since a64d7784e830b3140e7d0f2b45cb3d8fafb84cca git merge doesn't use cpio
> > anymore, adapt the documentation.
> 
> $ git grep cpio | cut -c1-60
> INSTALL:        - "cpio" is used by git-merge for saving and restor
> git-clone.sh:           find objects -depth -print | cpio -pumd$l "$G
> git-gui/Makefile:INSTALL_A1 = | cpio -pud
> git-gui/Makefile:       INSTALL_A1 = && echo '   ' INSTALL '   ' `
> 
> So it seems that git-clone still relies on it.

BTW, is there a topic-branch somewhere with a reimplementation of
git-clone in C ?

Mike
