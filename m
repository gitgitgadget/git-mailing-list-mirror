From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git commit won't add an untracked file given on the command
 line
Date: Wed, 19 Nov 2008 12:27:45 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811191226530.30769@pacific.mpi-cbg.de>
References: <20081118211237.234d8035@crow> <200811182227.20076.fge@one2team.com> <20081118214730.005fc72d@crow> <alpine.DEB.1.00.0811190206170.30769@pacific.mpi-cbg.de> <20081119095452.3018d2de@crow>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mark Burton <markb@ordern.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 12:21:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2l7L-0004KU-4Z
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 12:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbYKSLTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 06:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbYKSLTw
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 06:19:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:60438 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752009AbYKSLTv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 06:19:51 -0500
Received: (qmail invoked by alias); 19 Nov 2008 11:19:49 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp037) with SMTP; 19 Nov 2008 12:19:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/YVbZB+L3YjR6BH1O/n2Kvj98Ifx4+LKdt7qRcEl
	2yGvv6jIWaKJYE
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081119095452.3018d2de@crow>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101325>

Hi,

On Wed, 19 Nov 2008, Mark Burton wrote:

> Having said that, I still like the concept of being able to add named 
> files without touching the index.

That's just impossible.  You cannot create a tree object, let alone a 
commit object, without touching the index (AKA staging area).

Ciao,
Dscho
