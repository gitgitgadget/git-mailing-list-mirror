From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Sun, 21 Jan 2007 12:08:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701211207500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <eovccc$usc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 12:08:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8aYw-0004Y0-T2
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 12:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbXAULI1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 06:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbXAULI1
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 06:08:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:44264 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751351AbXAULI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 06:08:27 -0500
Received: (qmail invoked by alias); 21 Jan 2007 11:08:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 21 Jan 2007 12:08:25 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eovccc$usc$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37317>

Hi,

On Sun, 21 Jan 2007, Jakub Narebski wrote:

> By the way, was the pager configured to saner values, so "git diff" on a 
> repository with no changes does not output empty page?

As Junio mentioned: it already does. Maybe you have set the environment 
variable "LESS", and forgot to include "-F"?

Hth,
Dscho
