From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Simple support for tree entry specification with
	relative pathnames
Date: Tue, 18 Dec 2007 22:17:13 +0100
Message-ID: <20071218211713.GG2875@steel.home>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201> <20071218204623.GC2875@steel.home> <20071218204752.GD2875@steel.home> <56b7f5510712181303h1e7ae35dpa0adfd6804a7cecd@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 22:17:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4jor-0000Wp-PU
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 22:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbXLRVRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 16:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbXLRVRS
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 16:17:18 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:49040 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbXLRVRR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 16:17:17 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBsGSh4=
Received: from tigra.home (Fcb97.f.strato-dslnet.de [195.4.203.151])
	by post.webmailer.de (mrclete mo2) (RZmta 14.6)
	with ESMTP id Z069b6jBIKiH6O ; Tue, 18 Dec 2007 22:17:15 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3D112277AE;
	Tue, 18 Dec 2007 22:17:15 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id F2FED56D22; Tue, 18 Dec 2007 22:17:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56b7f5510712181303h1e7ae35dpa0adfd6804a7cecd@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68817>

Dana How, Tue, Dec 18, 2007 22:03:04 +0100:
> ACK from me...

But NAK from me. Definitely not in this form. Please consider the
patches *only* as an RFC.

> I submitted a similar patch last May 4 which also changed
> sha1_name.c to do this.  The patch added a config variable to
> control this (probably not desirable).  The patch also handled
> leading/embedded . and .. .

This one (the last in series) too.

> In p4 you can say
>   p4 <operation> file#rev
> and file is interpreted relatively.
> 
> I wanted to be able to say
>   git <operation> tree:file
> and have file interpreted relatively.
> This should only happen when you are inside the work tree.

It is pure coincedence the syntaxes look similar. They are very deeply
different in Git and Perforce.
