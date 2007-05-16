From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: newby question about merge.
Date: Wed, 16 May 2007 12:43:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705161241560.6410@racer.site>
References: <20070515113820.2621c8d5@localhost.localdomain> <f2c23k$dm0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 13:43:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoHuY-000750-HP
	for gcvg-git@gmane.org; Wed, 16 May 2007 13:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757707AbXEPLnN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 07:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758386AbXEPLnN
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 07:43:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:54956 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757707AbXEPLnM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 07:43:12 -0400
Received: (qmail invoked by alias); 16 May 2007 11:43:09 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 16 May 2007 13:43:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+YsBpxUDCYPPsX8x25tOWbTyE7zq7PS8wU4nqLE5
	GuTyHXjqNhCjOF
X-X-Sender: gene099@racer.site
In-Reply-To: <f2c23k$dm0$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47436>

Hi,

On Tue, 15 May 2007, Jakub Narebski wrote:

> You can just do "git cat-file -p :2:filename > filename", then "git add 
> filename" (or "git update-index filename") to resolve conflict.

Do we really want to advertise this obscure-looking plumbing? Wouldn't it 
be better to teach people to use "git show" instead?

I mean, people can get intimidated by that...

Ciao,
Dscho
