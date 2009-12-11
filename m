From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/6] GITWEB - Add git:// link to summary pages
Date: Fri, 11 Dec 2009 13:52:23 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912111350340.4985@pacific.mpi-cbg.de>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org> <1260488743-25855-2-git-send-email-warthog9@kernel.org> <1260488743-25855-3-git-send-email-warthog9@kernel.org> <1260488743-25855-4-git-send-email-warthog9@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>
To: John 'Warthog9' Hawley <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 11 13:47:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ4ub-00015v-G1
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 13:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755588AbZLKMrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 07:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754770AbZLKMrp
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 07:47:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:47097 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754559AbZLKMrp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 07:47:45 -0500
Received: (qmail invoked by alias); 11 Dec 2009 12:47:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 11 Dec 2009 13:47:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zBf8CTa5z6edFWXAwNyx2JxQJ4Slf4TUew8BABc
	80yhUUh/DaBu/S
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1260488743-25855-4-git-send-email-warthog9@kernel.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135084>

Hi,

On Thu, 10 Dec 2009, John 'Warthog9' Hawley wrote:

> This adds a git:// link to the summary pages should a common $gitlinkurl 
> be defined (default is nothing defined, thus nothing shown)

Nice.

I forgot to mention in my comments to 2/6 that you seem to wrap after more 
than 80 characters.  However, I have no idea what the suggested line width 
is for gitweb.

Again, this could be done by having the variable defined as undef.

Maybe it would be even nicer if the administrator could specify the 
protocol, e.g. when they do not want/cannot allow git:// but only http:// 
access to the repositories?

Ciao,
Dscho
