From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Excluding files from git-diff
Date: Fri, 17 Oct 2008 17:08:53 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810171708270.4180@racer>
References: <20081017145313.GA23471@eriks>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Erik Hahn <erik_hahn@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 17 17:11:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqqym-000417-Eo
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 17:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756925AbYJQPJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 11:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756919AbYJQPI7
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 11:08:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:34246 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756920AbYJQPIz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 11:08:55 -0400
Received: (qmail invoked by alias); 17 Oct 2008 15:08:54 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO private-schindelin-ap.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp016) with SMTP; 17 Oct 2008 17:08:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19965R3nSB9H9FsTrkKMY6MfnQdI0vhUbMWGXvc/u
	LsDOudfZaISSQE
X-X-Sender: gene099@racer
In-Reply-To: <20081017145313.GA23471@eriks>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98483>

Hi,

On Fri, 17 Oct 2008, Erik Hahn wrote:

> I'm currently working on a script whose developer does not use git. 
> Hence, when I mail him the patch, I don't want to include the .gitignore 
> file. Is it possible to exclude a file from git-diff (except not adding 
> it to git, of course?)

You can specify everything else:

	git diff -- *

Hth,
Dscho
