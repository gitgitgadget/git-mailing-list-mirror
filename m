From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: bug: build from tarball uses git-describe
Date: Wed, 14 Feb 2007 20:30:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702142028230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <eqtfso$7mo$1@sea.gmane.org>
 <Pine.LNX.4.63.0702140159440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vd54dwnvb.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702140206550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vlkj0o814.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 20:30:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHPpg-000504-0b
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 20:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbXBNTaV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 14:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbXBNTaV
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 14:30:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:51874 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932485AbXBNTaU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 14:30:20 -0500
Received: (qmail invoked by alias); 14 Feb 2007 19:30:19 -0000
X-Provags-ID: V01U2FsdGVkX18DAkMk5m8DPqUreKYl2jBO/v8/I6glfwajmDhroS
	GC0g==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vlkj0o814.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39728>

Hi,

On Wed, 14 Feb 2007, Junio C Hamano wrote:

> Ok, then let's do this.  Our tarballs do have version file, and if the 
> upperlevel Makefile wants to set a different version it can drop 
> 'version' file before descending into us.

Okay. But I started hacking git by getting it, compiling it, doing "git 
init", a "git fetch origin", "git read-tree HEAD" and "git update-index 
--refresh". In that case, .git is there, but also the file "version".

But that's too obscure a case as to care about, so I am okay with your 
patch.

Ciao,
Dscho
