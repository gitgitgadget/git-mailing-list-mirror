From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Possible regression in git-rev-list --header
Date: Sat, 30 Dec 2006 19:57:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612301955340.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 30 19:57:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0jOs-0005Zg-13
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 19:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbWL3S5m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 13:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbWL3S5m
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 13:57:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:43051 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030295AbWL3S5l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 13:57:41 -0500
Received: (qmail invoked by alias); 30 Dec 2006 18:57:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 30 Dec 2006 19:57:40 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35625>

Hi,

On Sat, 30 Dec 2006, Marco Costalba wrote:

> When 'commitencoding' variable is set in config file then git-rev-list
> called with --header option sends also the encoding information.

As Jakub pointed out, qgit should not expect to know all headers. I am 
very sorry, since I said I looked at all parsers of the commit header in 
git, but that was _only_ git, and no porcelains.

Please fix qgit, since I really consider this a bug.

Ciao,
Dscho
