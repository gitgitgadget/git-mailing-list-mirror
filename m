From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Wed, 19 Dec 2007 08:42:15 +0100
Message-ID: <20071219074215.GB2957@steel.home>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201> <20071218204623.GC2875@steel.home> <200712182224.28152.jnareb@gmail.com> <20071218222032.GH2875@steel.home> <Pine.LNX.4.64.0712182239500.23902@racer.site> <56b7f5510712181503l1e5dcacds23511d968f98aedb@mail.gmail.com> <alpine.LFD.0.9999.0712181711100.21557@woody.linux-foundation.org> <56b7f5510712181752s7ecebca9m32794c635cba9fd@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 08:42:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4tZi-00089E-Cr
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 08:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbXLSHmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 02:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbXLSHmS
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 02:42:18 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:15242 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbXLSHmR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 02:42:17 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+a72E=
Received: from tigra.home (Fc89a.f.strato-dslnet.de [195.4.200.154])
	by post.webmailer.de (fruni mo17) (RZmta 14.6)
	with ESMTP id w03637jBJ7QkYe ; Wed, 19 Dec 2007 08:42:15 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 344E5277AE;
	Wed, 19 Dec 2007 08:42:15 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 1527156D22; Wed, 19 Dec 2007 08:42:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56b7f5510712181752s7ecebca9m32794c635cba9fd@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68861>

Dana How, Wed, Dec 19, 2007 02:52:23 +0100:
> Given that the root of the current working tree,  the commit, the cwd,
> and the path (suffix) given on the command line are all known precisely,
> it does not seem dangerous to come up with an exact rule to combine them
> which is only triggered by some specific syntax.
> 
> This does not need to work in bare repositories.
> 

And it wont in both patches (your and mine): they don't have prefix
(aka cwd) at all. The bare repos are just no problem, the pathnames
there are always project-absolute.
