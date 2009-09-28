From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Getting a list of last commit's files and piping them..
Date: Mon, 28 Sep 2009 16:01:04 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909281559001.16710@intel-tinevez-2-302>
References: <4f302eef91c72cd4583e0aa4707ab4c0@ahmednuaman.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Ahmed Nuaman, Freelance Designer and Developer" 
	<ahmed@ahmednuaman.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 16:02:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsGnj-00033w-Cz
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 16:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbZI1OBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 10:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752078AbZI1OBM
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 10:01:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:57615 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752067AbZI1OBL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 10:01:11 -0400
Received: (qmail invoked by alias); 28 Sep 2009 14:01:13 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp042) with SMTP; 28 Sep 2009 16:01:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Kd6EMXDAKHztbtzX5tfnL5YKzXun7y/uxmJV2Oz
	jCqAt+9QG+pPij
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4f302eef91c72cd4583e0aa4707ab4c0@ahmednuaman.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129263>

Hi,

On Mon, 28 Sep 2009, Ahmed Nuaman, Freelance Designer and Developer wrote:

> I use git for a local versioning system and was wondering if there was a 
> way that I could write a bash script that would get the paths of the 
> files from the latest commit and then pipe them to ftp or ssh for 
> deployment.

If you mean all the files that were touched by the last commit:

	git diff --name-only HEAD^..

If you mean all the files of the latest revision:

	git ls-tree --name-only -r HEAD

Both commands take -z options in which case they delimit the names with 
NULs for better parsability.

Hth,
Dscho
