From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git config oddity
Date: Tue, 15 Jul 2008 16:02:16 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807151600170.8950@racer>
References: <bd6139dc0807150744l78eb8d54ld167d3a9a5a600f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Tue Jul 15 17:03:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIm48-0001m0-SG
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 17:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003AbYGOPCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 11:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753124AbYGOPCS
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 11:02:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:44259 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753003AbYGOPCR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 11:02:17 -0400
Received: (qmail invoked by alias); 15 Jul 2008 15:02:15 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp025) with SMTP; 15 Jul 2008 17:02:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ZlLFmgnHZyANd4xiOVg0NEqQZPQnb4Dg2M1K4O9
	WsBF70eljZIKdJ
X-X-Sender: gene099@racer
In-Reply-To: <bd6139dc0807150744l78eb8d54ld167d3a9a5a600f@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88563>

Hi,

On Tue, 15 Jul 2008, Sverre Rabbelier wrote:

> I noticed today that when unsetting the last value in a group git
> config leaves the empty group header.

That is on purpose.  As .git/config was always meant as a user-editable 
file, you can put comments into that section.  Or comment out some values.

So "git config" does not remove the section, even if no variable is there 
at the moment.

It is somewhat unfortunate that setting a variable does not find the 
section; the reason is that it sees sections only when a variable is set 
(to avoid having to do the parsing itself).

Hth,
Dscho
