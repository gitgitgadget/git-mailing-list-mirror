From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: error: cannot lock ref 'refs/remotes/origin/*'
Date: Tue, 17 Jun 2008 11:41:54 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806171140470.6439@racer>
References: <1213635227.17814.6.camel@localhost> <1213667245.14393.3.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nicolas Bock <nbock@lanl.gov>
X-From: git-owner@vger.kernel.org Tue Jun 17 12:44:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Yg0-0001iy-4L
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 12:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961AbYFQKnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 06:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754778AbYFQKnb
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 06:43:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:58736 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754797AbYFQKnb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 06:43:31 -0400
Received: (qmail invoked by alias); 17 Jun 2008 10:43:29 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp054) with SMTP; 17 Jun 2008 12:43:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ld/smJDYlh5aVLe+Oft6QH9csGfWDUjxzHafSd0
	Rj7btFZe66XZCk
X-X-Sender: gene099@racer
In-Reply-To: <1213667245.14393.3.camel@localhost>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85288>

Hi,

On Mon, 16 Jun 2008, Nicolas Bock wrote:

> > $ git gc
> > error: cannot lock ref 'refs/remotes/origin/*'
> > error: failed to run reflog

This is a bogus ref name.  Hrm.  Can you look with "git show-ref" if you 
have (by some funny accident) an invalid ref there?

Ciao,
Dscho
