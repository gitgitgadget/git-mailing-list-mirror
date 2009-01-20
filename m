From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git rebase -i failing on cygwin -- git checkout-index says File
 Exists
Date: Wed, 21 Jan 2009 00:23:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901210022290.15160@racer>
References: <4285cd450901201209i792195dfmdec1fb14d627b25e@mail.gmail.com>  <alpine.DEB.1.00.0901202212470.3586@pacific.mpi-cbg.de>  <4285cd450901201420l8929dci25688dc9723c917a@mail.gmail.com> <4285cd450901201444g711626afm296bf372a100b999@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ludvig Strigeus <strigeus@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 00:25:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPPxk-0001Fm-P3
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 00:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762288AbZATXXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 18:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756581AbZATXXG
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 18:23:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:33137 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755521AbZATXXE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 18:23:04 -0500
Received: (qmail invoked by alias); 20 Jan 2009 23:23:01 -0000
Received: from pD9EB302D.dip0.t-ipconnect.de (EHLO noname) [217.235.48.45]
  by mail.gmx.net (mp011) with SMTP; 21 Jan 2009 00:23:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/hK8gWeDbhV6QG/DThBiRRK+RrEBZjq8wa3Y9IYt
	UrDmT2v4oSE43V
X-X-Sender: gene099@racer
In-Reply-To: <4285cd450901201444g711626afm296bf372a100b999@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106537>

Hi,

On Tue, 20 Jan 2009, Ludvig Strigeus wrote:

> On Tue, Jan 20, 2009 at 11:20 PM, Ludvig Strigeus <strigeus@gmail.com> wrote:
> >
> > Maybe this command log is useful. I got this while aborting the 
> > rebase. Looks like some file creation race condition? Windows doesn't 
> > allow files to be deleted while they're open.
> 
> I believe I found the source of my problems with git rebase. I had an 
> editor open that wanted to reload the files when changed, and this 
> seemed to conflict with git's file manipulations. After closing the 
> editor, I don't get the mysterious errors anymore.

Yep, that's a Windows issue.  Once you keep a file open in an editor, it 
cannot be overwritten/deleted.

Live with it, or upgrade to a real operating system :-)

Ciao,
Dscho
