From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Publishing on a simple HTTP server
Date: Tue, 13 Feb 2007 12:57:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702131256430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <14870.1171311025@localhost>
 <Pine.LNX.4.63.0702130009010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <19695.1171344721@localhost> <Pine.LNX.4.63.0702131106230.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <23628.1171367140@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Xavier Maillard <zedek@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 13 12:58:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGwId-0006sW-A7
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 12:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbXBML5n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 06:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbXBML5m
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 06:57:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:39742 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751303AbXBML5m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 06:57:42 -0500
Received: (qmail invoked by alias); 13 Feb 2007 11:57:40 -0000
X-Provags-ID: V01U2FsdGVkX19LklZJI+pL3hAu6eLreXkx+iZQBtY/ftp0RNR/wQ
	iTzw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <23628.1171367140@localhost>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39518>

Hi,

On Tue, 13 Feb 2007, Xavier Maillard wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > In that case, please extend your mirror script to run 
> > git-update-server-info before mirroring.
> 
> I thought this:
> 
> git --bare --git-dir=/tmp/my-cloned.git update-server-info
> 
> was supposed to achieve this. Doesn't it ?

If you mirror /tmp/my-cloned.git to the HTTP server, then yes, this should 
do it. Make sure that /tmp/my-cloned.git/info/refs is really updated and 
mirrored out, though.

Hth,
Dscho
