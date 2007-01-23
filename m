From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Tue, 23 Jan 2007 20:12:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701232012120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <eovccc$usc$1@sea.gmane.org>
 <Pine.LNX.4.63.0701211207500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17846.20498.635623.173653@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 20:12:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9R4W-0005MQ-RU
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 20:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932793AbXAWTMl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 14:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932952AbXAWTMl
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 14:12:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:56692 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932793AbXAWTMk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 14:12:40 -0500
Received: (qmail invoked by alias); 23 Jan 2007 19:12:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp051) with SMTP; 23 Jan 2007 20:12:38 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Bill Lear <rael@zopyra.com>
In-Reply-To: <17846.20498.635623.173653@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37557>

Hi,

On Tue, 23 Jan 2007, Bill Lear wrote:

> I can't seem to get this to work, no matter what I do, using the latest 
> 1.5.0-rc2 code.  I have the environment variables LESS, PAGER, 
> PAGER_FLAGS, and I can't seem to get 'git diff' to not plough through my 
> screen each time it is run, no matter the combinations...  Could someone 
> post the magic?

Try this:

	PAGER=less LESS=-FRS git diff

Hth,
Dscho
