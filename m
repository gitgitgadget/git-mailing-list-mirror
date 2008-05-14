From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] chdir after computing new cwd in
 check_repository_format_gently
Date: Wed, 14 May 2008 09:02:12 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805140901420.30431@racer>
References: <482A7C71.6050509@facebook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Reiss <dreiss@facebook.com>
X-From: git-owner@vger.kernel.org Wed May 14 10:03:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwBxI-0007J6-GD
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 10:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467AbYENICS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 04:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754452AbYENICQ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 04:02:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:52286 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752758AbYENICO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 04:02:14 -0400
Received: (qmail invoked by alias); 14 May 2008 08:02:12 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp050) with SMTP; 14 May 2008 10:02:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+JFNx+M8GJZEhxBttPoKkMZEYCqUpua6o1NiQ2VP
	ASRvii7QTLBzCS
X-X-Sender: gene099@racer
In-Reply-To: <482A7C71.6050509@facebook.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82085>

Hi,

On Tue, 13 May 2008, David Reiss wrote:

> In preparation for adding a check before the chdir. This should be a 
> no-op because the cwd is not read in the interim and any nonlocal exits 
> either chdir to an absolute path or die.

I think it would be clearer if you squashed that commit into the other 
one.

Ciao,
Dscho
