From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] wcwidth redeclaration
Date: Tue, 8 May 2007 12:03:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705081202080.4167@racer.site>
References: <20070508044608.GA32223@us.ibm.com> <7vmz0f52no.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Amos Waterland <apw@us.ibm.com>
X-From: git-owner@vger.kernel.org Tue May 08 12:03:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlMXi-00067C-Ql
	for gcvg-git@gmane.org; Tue, 08 May 2007 12:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934820AbXEHKDe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 06:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934824AbXEHKDd
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 06:03:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:53581 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934820AbXEHKDd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 06:03:33 -0400
Received: (qmail invoked by alias); 08 May 2007 10:03:31 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp050) with SMTP; 08 May 2007 12:03:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18qXoQyrpkqotrRXjFUIxfJVk6C5Ri/O7F+Ks0g69
	mInME9CgprfOR8
X-X-Sender: gene099@racer.site
In-Reply-To: <7vmz0f52no.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46559>

Hi,

On Mon, 7 May 2007, Junio C Hamano wrote:

> apw@us.ibm.com (Amos Waterland) writes:
> 
> > Build fails for git 1.5.1.3 on AIX, with the message: 
> >
> > utf8.c:66: error: conflicting types for 'wcwidth'
> > /.../lib/gcc/powerpc-ibm-aix5.3.0.0/4.0.3/include/string.h:266: error: previous declaration of 'wcwidth' was here
> >
> > Here is a patch that fixes it for me.  If there is a different way that
> > is preferred, please let me know.
> 
> It's static in that file, so renaming our version to our own
> name as you did is perfectly good.
> 
> Thanks for helping, as not many people seem to be on AIX on this
> list.

Thanks indeed. I thought that a static function could shadow a global 
function, but probably not with a different signature. Just out of 
curiosity: what is the signature of wcwidth in your string.h?

Ciao,
Dscho
