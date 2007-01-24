From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-rm'ing all dead files
Date: Wed, 24 Jan 2007 17:25:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701241723560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <loom.20070124T171435-429@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Pazu <pazu@pazu.com.br>
X-From: git-owner@vger.kernel.org Wed Jan 24 17:26:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9kwe-00021W-AH
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 17:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbXAXQZx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 11:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbXAXQZx
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 11:25:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:60078 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750786AbXAXQZw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 11:25:52 -0500
Received: (qmail invoked by alias); 24 Jan 2007 16:25:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp024) with SMTP; 24 Jan 2007 17:25:51 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <loom.20070124T171435-429@post.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37650>

Hi,

On Wed, 24 Jan 2007, Pazu wrote:

> I couldn't find an easy way to remove all "dead" files from the index, 
> i.e., call git-rm on all files that are missing from the working copy.

How about

	git ls-files -z --deleted | git update-index -z --remove --stdin

?

Ciao,
Dscho
