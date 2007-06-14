From: Gerrit Pape <pape@smarden.org>
Subject: Re: git-cvsimport cannot handle zsh CVS repo
Date: Thu, 14 Jun 2007 13:25:47 +0000
Message-ID: <20070614132547.16924.qmail@024805695ef066.315fe32.mid.smarden.org>
References: <20070607073336.26979.qmail@178148a41cee98.315fe32.mid.smarden.org> <46a038f90706071219h35d776d2m15a9dcf7f9bc24aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, 426617@bugs.debian.org
X-From: git-owner@vger.kernel.org Thu Jun 14 15:25:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HypKO-0002zN-Vv
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 15:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbXFNNZc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 09:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752478AbXFNNZb
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 09:25:31 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:50197 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752400AbXFNNZb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 09:25:31 -0400
Received: (qmail 16925 invoked by uid 1000); 14 Jun 2007 13:25:47 -0000
Mail-Followup-To: git@vger.kernel.org, 426617@bugs.debian.org
Content-Disposition: inline
In-Reply-To: <46a038f90706071219h35d776d2m15a9dcf7f9bc24aa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50200>

On Fri, Jun 08, 2007 at 07:19:14AM +1200, Martin Langhoff wrote:
> On 6/7/07, Gerrit Pape <pape@smarden.org> wrote:
> >Hi, I'm stuck tracking down this issue, unfortunately reproducing it
> >seems to take ages.  Any help would be appreciated.
> >
> >Please see http://bugs.debian.org/426617
> 
> This is probably a problem with cvsps output on that repo. If you run
> cvsps against the cvs repo, what does its output look like around/past
> patchset 6965
> 
> There's a number of things that can confuse cvsps, as the cvs repo
> format is horrid.

Hi, the cvsps output is attached to the bug report

 http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=426617;msg=72;filename=%3Apserver%3Aanonymous%40zsh.cvs.sourceforge.net%3A%23cvsroot%23zsh%23zsh;att=1

Does this help to track down and hopefully fix the problem?

Thanks, Gerrit.
