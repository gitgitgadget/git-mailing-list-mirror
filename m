From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git push failure in the case of SSH to localhost
Date: Wed, 11 Feb 2009 22:03:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902112159240.10279@pacific.mpi-cbg.de>
References: <8e04b5820902110824u1ab99cc1r4df6349b20d62f84@mail.gmail.com>  <20090211184429.GA27896@coredump.intra.peff.net>  <8e04b5820902111103n69cde3e1le5781fb1818b622c@mail.gmail.com>  <20090211191445.GU30949@spearce.org> 
 <8e04b5820902111120w4cb87b41sfca647a838bab43c@mail.gmail.com>  <20090211192245.GA28832@coredump.intra.peff.net>  <8e04b5820902111132v5b7c8e14s15c6fad13b5b76a9@mail.gmail.com>  <20090211194218.GA28927@coredump.intra.peff.net> 
 <8e04b5820902111203t344881f6g31f25cfbff5fd822@mail.gmail.com>  <7vvdrgd8pb.fsf@gitster.siamese.dyndns.org> <8e04b5820902111249n5fb87ff1r3d030b008fec0c28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 22:04:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXMFV-0002yc-S2
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 22:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631AbZBKVCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 16:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756465AbZBKVCd
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 16:02:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:46165 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756557AbZBKVCd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 16:02:33 -0500
Received: (qmail invoked by alias); 11 Feb 2009 21:02:27 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp045) with SMTP; 11 Feb 2009 22:02:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+rGwYtXuirBxIOCVKUyRw7cH4vfb1h4WNhM9NuKK
	2tF7AO9XuKJ9eK
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <8e04b5820902111249n5fb87ff1r3d030b008fec0c28@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109528>

Hi,

On Wed, 11 Feb 2009, Ciprian Dorin, Craciun wrote:

>     By moving the repository I mean moving it on another machine...
> Let me give you an example...
> 
>     Thus (inspired by one of my current usages of Git) suppose I'm
> working at a scientific project (let's assume algorithmic nature) and
> after I succeed in having a working version of my algorithm, I decide
> to test it on a better hardware with bigger workloads...

Already you showed that your workflow leaves to be desired.  You need to 
move the repository using filesystem commands now.  Why?  Because you have 
stuff in .git/ that does not belong there, and does not get pushed or 
fetched as a consequence.

In similar cases, I followed three different options (and yes, I use all 
of them, in different repositories):

- commit the scripts (that works amazingly well with Git :-)

- have an independent branch for the scripts that I check out in a 
  subdirectory, or

- put the scripts into a submodule right away, when they are useful for 
  more than one project.

Hth,
Dscho
