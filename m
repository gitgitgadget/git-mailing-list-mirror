From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-cvsserver doesn't respect core.sharedrepository
Date: Tue, 13 Feb 2007 19:10:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702131910020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702131438.30291.andyparkins@gmail.com>
 <Pine.LNX.4.63.0702131611010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200702131605.29088.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 13 19:11:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH27Z-0002ef-9r
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 19:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbXBMSKy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 13:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbXBMSKy
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 13:10:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:58773 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751437AbXBMSKx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 13:10:53 -0500
Received: (qmail invoked by alias); 13 Feb 2007 18:10:52 -0000
X-Provags-ID: V01U2FsdGVkX19dWBFj++Fd1AdvGpyWoYWgIqtqJ1L7wCGFW64IP8
	/SkA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702131605.29088.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39568>

Hi,

On Tue, 13 Feb 2007, Andy Parkins wrote:

> On Tuesday 2007 February 13 15:11, Johannes Schindelin wrote:
> 
> > Since ref updates are not write-into-existing-file, but rather
> > write-into-new-file-and-replace-old, it should work, no?
> 
> That perhaps might be the explanation for the bad behaviour.

Ummm. What I tried to say is that this is intended behaviour, not bad 
behaviour. The file does not have to have write permissions for the group. 
The _directory_ has to have them.

Ciao,
Dscho
