From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: jgit merge question
Date: Wed, 14 Jan 2009 11:26:26 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901141124460.3586@pacific.mpi-cbg.de>
References: <S1760244AbZANHqN/20090114074613Z+1959@vger.kernel.org> <4EDE3D74-CEA3-473C-ADD1-03B79AAB9EDF@asu.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Birchfield <dbirchfield@asu.edu>
X-From: git-owner@vger.kernel.org Wed Jan 14 11:27:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN2xr-0002ro-F3
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 11:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845AbZANKZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 05:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754740AbZANKZh
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 05:25:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:54559 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752615AbZANKZg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 05:25:36 -0500
Received: (qmail invoked by alias); 14 Jan 2009 10:25:34 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp033) with SMTP; 14 Jan 2009 11:25:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Br08blUABv8Xzh6sEIfnDN4gLLp9PmcqYQtLDgT
	MhjZ3xtiPH6RQz
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4EDE3D74-CEA3-473C-ADD1-03B79AAB9EDF@asu.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105610>

Hi,

On Wed, 14 Jan 2009, David Birchfield wrote:

> I have been working with the JGit library and with the pgm files and 
> other documentation I have been able to implement most of the basic 
> functions that I need for my testing application - including fetch.  
> This is great!  However, I have not been able to successfully implement 
> the merge function with JGit. There is some reference to this in the 
> mail archive, but I cannot find any of the merge code that is referenced 
> in the distribution.

You mean

http://thread.gmane.org/gmane.comp.version-control.git/100524/focus=100589

?

Yes, it has not been implemented, basically because it needs a diff 
implementation, and I constantly run out of time working on it.  I have 
something that works, but needs lots of improvements to be usable 
(basically, it has to avoid deep recursion depths).

Ciao,
Dscho
