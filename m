From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 13:57:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702271356040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <E1HM1XL-00071C-N5@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 27 13:57:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM1tT-0002Sk-He
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 13:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030614AbXB0M5U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 07:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030621AbXB0M5U
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 07:57:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:51030 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030614AbXB0M5U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 07:57:20 -0500
Received: (qmail invoked by alias); 27 Feb 2007 12:57:18 -0000
X-Provags-ID: V01U2FsdGVkX1+k67h75RykdzoA5OJS2zW7r8gHU/XzgXm4JBUMuf
	8A5A==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <E1HM1XL-00071C-N5@candygram.thunk.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40727>

Hi,

On Tue, 27 Feb 2007, Theodore Ts'o wrote:

> 	cvs -r v1.37 -p e2fsck/pass1.c

> git-cat-file and git-show only work on a object identifier (they are 
> low-level plumbing commands).

git-show, of all, is _not_ plumbing. It is one of the foremost porcelain 
programs core Git ships.

git show v.37:e2fsck/pass1.c

Is probably what you want.

Ciao,
Dscho
