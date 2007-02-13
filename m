From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-cvsserver doesn't respect core.sharedrepository
Date: Tue, 13 Feb 2007 16:11:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702131611010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702131438.30291.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 13 16:12:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGzKB-0007aK-91
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 16:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbXBMPMB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 10:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbXBMPMB
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 10:12:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:55560 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750713AbXBMPMA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 10:12:00 -0500
Received: (qmail invoked by alias); 13 Feb 2007 15:11:58 -0000
X-Provags-ID: V01U2FsdGVkX1+9SLRwajG9vJzI/cP02BfVhdtpHWCjZ7HY7gK5w6
	jaSQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702131438.30291.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39531>

Hi,

On Tue, 13 Feb 2007, Andy Parkins wrote:

> I'm using git-cvsserver with a repository that has core.sharedrepository set 
> to "group".  After a commit has been pushed using git-cvsserver I have to 
> correct the permissions again.

Are you sure?

Since ref updates are not write-into-existing-file, but rather 
write-into-new-file-and-replace-old, it should work, no?

Ciao,
Dscho
