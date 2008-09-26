From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: git-sharp, was Re: Implementations of Git (was: re-licensing pkt-line.c
 code)
Date: Fri, 26 Sep 2008 13:42:07 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0809261335240.13830@pacific.mpi-cbg.de.mpi-cbg.de>
References: <d411cc4a0809251017h5509bbdmaef935c61cc0929@mail.gmail.com> <m3od2c2k29.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git list <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 13:37:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjBdN-0004kH-G4
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 13:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbYIZLgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 07:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbYIZLgF
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 07:36:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:32921 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751754AbYIZLgE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 07:36:04 -0400
Received: (qmail invoked by alias); 26 Sep 2008 11:36:01 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp051) with SMTP; 26 Sep 2008 13:36:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/vK/E8NJjvA+0exCuf1RiHSKLdbD3WDBqlUOS9YC
	j4g/RWMgbyoIAs
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <m3od2c2k29.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96846>

Hi,

On Thu, 25 Sep 2008, Jakub Narebski wrote:

> P.S. Do you know what is the status of git#, implementation of Git in 
> C#, which was one of this year Google Summer of Code projects?

As I suspected (hoping I would be wrong), the lack of communication (this 
time with the Git community) did not help at all.

The latest commit is this:

http://code.google.com/p/mono-soc-2008/source/detail?r=471

implementing a diff algorithm.

>From what I can tell from the source (I do not have a working C# 
environment), the implementation repeats a lot of what Shawn told us 
earlier were his lessons from his first stab at JGit.  For example, I saw 
that the contents of blobs are read into memory when the blob is read.  I 
haven't checked closely, but I did not have the impression that there were 
accessors making it easy to turn this into a lazy read.

Take-home message: if you think you should develop Open Source in a 
secretive manner, you are almost certainly wrong, and your project will 
almost certainly be slow or even fail (BTW I also see exactly this same 
problem with Govind's try last year, which had a cool name, and then 
another cool name, but not much to show for it).

Ciao,
Dscho
