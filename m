From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] Support ent:relative_path
Date: Sun, 6 May 2007 17:14:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705061653100.4015@racer.site>
References: <463BD40C.6080909@gmail.com> <Pine.LNX.4.64.0705050324580.4015@racer.site>
 <7vwszolz26.fsf@assigned-by-dhcp.cox.net> <56b7f5510705042346s759a2ef9tfa3a223fe7af7c16@mail.gmail.com>
 <Pine.LNX.4.64.0705051637450.4015@racer.site> <7vwszmfod8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 06 17:15:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkiS6-0004R9-F1
	for gcvg-git@gmane.org; Sun, 06 May 2007 17:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbXEFPPA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 11:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbXEFPPA
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 11:15:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:47557 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750893AbXEFPO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 11:14:59 -0400
Received: (qmail invoked by alias); 06 May 2007 15:14:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 06 May 2007 17:14:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19t2/IyRH5t84BQwqQ/vZtXomOzQOQClMrp1A1fOH
	DGmlLYF8w1r5g/
X-X-Sender: gene099@racer.site
In-Reply-To: <7vwszmfod8.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46338>

Hi,

On Sat, 5 May 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> (a) In a bare repository, I believe 
> >> setup.c:setup_git_directory_gently() determines the prefix to be 
> >> NULL.  This means my patch will see ALL paths as absolute, except 
> >> :../path which will result in an error.
> >
> > My point was that it feels inconsistent to take the current path into 
> > account in one case, but not in the other.
> 
> I do not understand your reasoning.  In a bare repository you cannot 
> even be in a subdirectory to begin with.

Exactly! That is my point. If you can do it in a working directory, but 
also with a bare repository, I find it highly confusing and inconsistent 
to have different meaning.

Ciao,
Dscho
