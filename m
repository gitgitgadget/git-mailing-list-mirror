From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Installation failure caused by CDPATH environment variable
Date: Thu, 12 Jul 2007 12:52:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707121250170.4516@racer.site>
References: <9693D8E9-6F11-4AA1-AFCA-7E8456FA6420@wincent.com>
 <Pine.LNX.4.64.0707111807470.4516@racer.site> <86sl7u12m3.fsf@lola.quinscape.zz>
 <7vodiivx50.fsf@assigned-by-dhcp.cox.net> <4C80B6B8-F6D6-4C8B-86F5-629B5662247C@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 13:53:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8xEP-0000Cg-KN
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 13:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530AbXGLLxK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 07:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbXGLLxJ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 07:53:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:50839 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753257AbXGLLxH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 07:53:07 -0400
Received: (qmail invoked by alias); 12 Jul 2007 11:53:06 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp029) with SMTP; 12 Jul 2007 13:53:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/8/RgP6cX8lb/T8m6tMGLSt3E1DCHuI+8Gwx1wKT
	ukIKiFchRXX8gY
X-X-Sender: gene099@racer.site
In-Reply-To: <4C80B6B8-F6D6-4C8B-86F5-629B5662247C@wincent.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52270>

Hi,

On Thu, 12 Jul 2007, Wincent Colaiuta wrote:

> El 12/7/2007, a las 10:34, Junio C Hamano escribi?:
> 
> > David Kastrup <dak@gnu.org> writes:
> > 
> > > Don't educate people.  Just don't trigger their problems.  Of 
> > > course, there are millions of ways of shooting oneself in the foot, 
> > > but in this case the same foot has been hit several times already.
> > 
> > Yup.  We do exactly that in git-clone, git-sh-setup and t/test-lib to 
> > avoid getting bugged by this stupidity.
> 
> El 12/7/2007, a las 9:51, David Kastrup escribi?:
> 
> > [ "X" = "X$CDPATH" ] || unset CDPATH # ignore braindamaged exports
> 
> Whatever decision is taken in the end, I think we should avoid terms 
> like "stupidity" and "braindamaged" to avoid causing possible offense. 
> Exporting CDPATH is a simple mistake that can be made inadvertently or 
> unwittingly, but very easily (Googling for "export CDPATH" yields 
> 18,000+ results, many of them purporting to be Bash "tutorials").

Sorry, my words were indeed to strong.  I apologise.  My only excuse is 
that this crops up ever so often, and it does get slightly annoying.  Of 
course, you did not read all those mails, and so my words were unmerited.  

For an example, see

http://article.gmane.org/gmane.comp.version-control.git/13736/match=cdpath

Ciao,
Dscho
