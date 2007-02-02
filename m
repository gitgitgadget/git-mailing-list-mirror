From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current
 branch reflog
Date: Fri, 2 Feb 2007 11:42:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702021140340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>
 <20070201191323.GA18608@spearce.org> <7vmz3xoas9.fsf@assigned-by-dhcp.cox.net>
 <epv3r9$4f7$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 11:43:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCvsh-0005zE-M0
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 11:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbXBBKmw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 05:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbXBBKmw
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 05:42:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:40722 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751892AbXBBKmv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 05:42:51 -0500
Received: (qmail invoked by alias); 02 Feb 2007 10:42:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 02 Feb 2007 11:42:50 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <epv3r9$4f7$2@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38488>

Hi,

On Fri, 2 Feb 2007, Jakub Narebski wrote:

> Perhaps we should use @{...} to refer to reflog for HEAD, or use yet 
> another special notation?

No.

IMHO "bla@{yesterday}" should give you what "bla" pointed to, yesterday. 
In that sense, the proposed reflog on "HEAD" makes perfect sense.

I am not quite sure what I need most, the reflog for "HEAD", or that for 
my current branch. I guess it is the latter, so I am okay that 
"@{yesterday}" should mean the current branch, yesterday.

Ciao,
Dscho
