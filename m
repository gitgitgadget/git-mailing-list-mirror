From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: On git 1.6 (novice's opinion)
Date: Wed, 01 Apr 2009 08:45:19 +0200
Organization: Universitaetsklinikum Regensburg
Message-ID: <49D329A0.10769.2C57DE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <vpq63hvdqs2.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Apr 01 08:47:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LouEK-0007cq-SW
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 08:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757062AbZDAGpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 02:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756562AbZDAGpu
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 02:45:50 -0400
Received: from rrzmta1.rz.uni-regensburg.de ([194.94.155.51]:4293 "EHLO
	rrzmta1.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756489AbZDAGpt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2009 02:45:49 -0400
Received: from rrzmta1.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 5CE38ABCC0;
	Wed,  1 Apr 2009 08:45:46 +0200 (CEST)
Received: from mailgate.dvm.klinik.uni-regensburg.de (kgate2.klinik.uni-regensburg.de [132.199.176.19])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by rrzmta1.rz.uni-regensburg.de (Postfix) with ESMTP id 339A3ABCA8;
	Wed,  1 Apr 2009 08:45:45 +0200 (CEST)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by mailgate.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20060824MT-1) with ESMTP id n316jaV2024768;
	Wed, 1 Apr 2009 08:45:36 +0200
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    1 Apr 09 08:45:35 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 1 Apr 09 08:45:27 +0100
In-reply-to: <vpq63hvdqs2.fsf@bauges.imag.fr>
X-mailer: Pegasus Mail for Windows (4.41)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.29/Sophos-P=4.37.0+V=4.37+U=2.07.219+R=05 January 2009+T=589357@20090401.064458Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115341>

On 27 Mar 2009 at 14:44, Matthieu Moy wrote:

> "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:
> 
> > I don't understand:
> > If I modify files, then do a make, then do check-in/check-out (and the file times 
> > are unchanged), how would that affect make?
> 
> From "make"'s point of view, chechout is just a modification of the
> file (as any other modification you would do with a text editor). If
> you compile foo.c to foo.o, then checkout another version of foo.c,
> then you want foo.c to be recompiled. If checkout modifies the
> timestamp to pretend it was modified before foo.o, then make thinks
> the file is up to date.
> 
> > If I do an "update/merge from remote" (there is no total ordering of release 
> > numbers anyway) without a "make clean" before, I'm having a problem
> > anyway.
> 
> No, you don't have a problem. Recompiling files after they're modified
> is the job of make, and it just does it. make doesn't know about
> revision numbers or identifiers, just timestamps.

Hi!

If you compiled a Linux kernel, then do an "upgrade" to the tree, it's quite 
likely that a "make clean" after that upgrade does something different to the 
"make clean" before the upgrade. Thus I'd "make clean" before the upgrade. (which, 
I think, proves my point)

Regards,
Ulrich
