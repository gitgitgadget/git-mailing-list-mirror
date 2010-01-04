From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: submodules, was Re: RFC: display dirty submodule working directory
 in git gui and      gitk
Date: Mon, 4 Jan 2010 12:46:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001041157020.3695@intel-tinevez-2-302>
References: <4B3F6742.6060402@web.de>    <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de> <61083.85.16.196.198.1262601871.squirrel@archive.darksea.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jens Lehmann <jens.lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Lars Hjemli <hjemli@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Jan 04 12:46:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRlOk-0005eq-AY
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 12:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486Ab0ADLqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 06:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298Ab0ADLqx
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 06:46:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:36789 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750742Ab0ADLqx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 06:46:53 -0500
Received: (qmail invoked by alias); 04 Jan 2010 11:46:50 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp064) with SMTP; 04 Jan 2010 12:46:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+crmInkbacSgLu/dZOikzRaSA/h23AAA0Ze3/6JZ
	pRn/H2TKqVbHgc
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <61083.85.16.196.198.1262601871.squirrel@archive.darksea.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136108>

Hi,

On Mon, 4 Jan 2010, Heiko Voigt wrote:

> Johannes wrote:
> > The real problem is that submodules in the current form are not very 
> > well designed.  For example, a submodule being at a different commit 
> > than in the superproject's index is not as fatal as the submodule 
> > having changes.
> >
> > So in the long run, IMHO a proper redesign of the submodules would not 
> > make only a little sense (it does not help, though, that those who 
> > implemented and furthered the current approach over other discussed 
> > approaches do not use submodules themselves -- not even now).
> 
> Do you mean the complete workflow (submodules are links to other git 
> repos) or the current implementation? Do you have links to other design 
> approaches/threads? Would be nice if we could take that into account for 
> any decision.

Unfortunately, I do not have any information about different approaches 
except the approach Subversion takes.  While Subversion's externals are 
not perfect for all applications, for some, they are.  So I consider this 
a serious shortcoming that Git does not support that workflow (and in 
fact, AFAIR Shawn's repo does not use submodules for that exact reason).

But I think that an important precondition to come up with a better design 
of the submodules is to have suffered the current implementation in 
real-world work using submodules. (Which reminds me very much of the 
autocrlf mess.)

Ciao,
Dscho
