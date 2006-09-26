From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 01:27:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609270127010.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060926232316.98065.qmail@web51009.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 01:27:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSMKz-000223-08
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 01:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbWIZX1i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 19:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWIZX1i
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 19:27:38 -0400
Received: from mail.gmx.de ([213.165.64.20]:1473 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965146AbWIZX1h (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 19:27:37 -0400
Received: (qmail invoked by alias); 26 Sep 2006 23:27:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 27 Sep 2006 01:27:35 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matthew L Foster <mfoster167@yahoo.com>
In-Reply-To: <20060926232316.98065.qmail@web51009.mail.yahoo.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27836>

Hi,

On Tue, 26 Sep 2006, Matthew L Foster wrote:

> After seeing how git currently accepts a remote repository's timestamp 
> it occurred to me that git should probably instead prefer the time a 
> particular changeset was committed to _this_ repository.

Git accepts it, but does not rely on it. Instead, it relies on 
parent-child relations.

Hth,
Dscho
