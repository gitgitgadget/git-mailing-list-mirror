From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Autoconf/Automake
Date: Thu, 15 Jun 2006 22:42:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606152239270.7480@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1150324030.23268.12.camel@dv> <20060615072450.GF7766@nowhere.earth>
 <20060615133146.GA5794@steel.home> <20060615201000.600939E2BC@derisoft.derived-software.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 15 22:43:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fqyfx-0004yf-Lv
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 22:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWFOUmm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 16:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWFOUmm
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 16:42:42 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:62179 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932426AbWFOUml (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jun 2006 16:42:41 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 7010DDB6;
	Thu, 15 Jun 2006 22:42:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 646DFDB4;
	Thu, 15 Jun 2006 22:42:40 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 403CEB34;
	Thu, 15 Jun 2006 22:42:40 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Phil Richards <news@derived-software.ltd.uk>
In-Reply-To: <20060615201000.600939E2BC@derisoft.derived-software.demon.co.uk>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21907>

Hi,

On Thu, 15 Jun 2006, Phil Richards wrote:

> On 2006-06-15, Alex Riesen <fork0@t-online.de> wrote:
>
> >  Git already has enough external dependencies (crypto, Python, Perl,
> >  bash, gmake), why create another one?
> > 
> >  If we are about to need a configuration system (and I doubt it), may
> >  be we should at least select a system small enough to have it always
> >  in git repo? (yes, as linux kernel configuration system is)
> 
> Well, since Python is already a dependency, why not use a build system
> that has Python as its scripting/extension language?  It's also quite
> small, and it's called SCons.  I found it rather easy to learn
> when I was having a quick look around at alternative build systems.

Okay, let's face it. There are gazillions of make clones which "guarantee" 
to fix all shortcomings of make. None of them are even close to make 
(regarding developer exposure: take 3 developers, and 1 does not know 
make, and 2 do not know whatever-your-favourite-make-clone-is).

As for now, I fail to see why the current system is not adequate for git!

Ciao,
Dscho
