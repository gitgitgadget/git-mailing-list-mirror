From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 17:51:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708221713540.20400@racer.site>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
 <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz>
 <alpine.LFD.0.999.0708221154150.16727@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 22 18:52:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INtRF-0004YS-Aj
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 18:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbXHVQvt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 12:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764364AbXHVQvt
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 12:51:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:49979 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763320AbXHVQvs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 12:51:48 -0400
Received: (qmail invoked by alias); 22 Aug 2007 16:51:46 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO [192.168.0.57]) [132.187.25.128]
  by mail.gmx.net (mp052) with SMTP; 22 Aug 2007 18:51:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX183C0coac83Z1QORMx/H++4msk04EwsnscID20rKD
	nO4CiKylgK8ttL
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.999.0708221154150.16727@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56399>

Hi,

On Wed, 22 Aug 2007, Nicolas Pitre wrote:

> On Wed, 22 Aug 2007, David Kastrup wrote:
> 
> > Personally, I would prefer an approach of using an embedded script 
> > interpreter: then language incompatibilities become a non-issue. 
> > git-busybox sounded like a great idea for portability.
> 
> Indeed.  And while the conversion of some script into C was the right 
> thing to do performance wise, many other scripts are hardly performance 
> critical.

What is wrong with going from shell to C?  C _is_ portable.  Instead of 
relying on _yet_ another scripting language, introducing _yet_ another 
language that people have to learn to hack git, introducing _yet_ another 
place for bugs to hide, why not just admit that shell is nice for 
_prototyping_?

Why do we have to to have the same discussion over and over and over 
again?

> The current scripting ability will never go away.  But it is less and 
> less used meaning that scripting could never be a dependable ability on 
> all platforms if the current trend continues.

That is just not true.  The regular git hackers, you included, will always 
use scripts (or alias versions of them), so there is not much chance that 
scriptability will be hurt by builtinification.

> > If the scripting engine of choice for cobbling together prototypes
> > remains the Unix toolchain outside of git proper, then Windows users
> > will _always_ remain second class citizens since they will get to work
> > with and on new porcelain much later than the rest of the world:
> > namely when somebody bothers porting his new favorite tool for them to
> > C.
> 
> Right.

And not making the scripts builtins helps Windows users how, exactly?

Ciao,
Dscho
