From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] annotate: Support annotation of files on other revisions.
Date: Mon, 6 Mar 2006 10:24:10 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0603061021240.1422@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060305111334.GB23448@c165.ib.student.liu.se>
 <440B751F.5000801@michonline.com> <46a038f90603051629ke34a0a6u89dad995bbd777b0@mail.gmail.com>
 <20060306024353.GA23001@mythryan2.michonline.com> <440BC92E.4060306@gmail.com>
 <440BCB67.4070406@michonline.com> <20060306055036.GB26820@spearce.org>
 <440BD4F4.3060906@gmail.com> <7vk6b8axz4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitzilla@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 10:24:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGBww-0004ZP-7K
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 10:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbWCFJYN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 04:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752343AbWCFJYM
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 04:24:12 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:27092 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1752342AbWCFJYL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 04:24:11 -0500
Received: from virusscan.mail (mail03.mail [172.25.1.102])
	by mailrelay.mail (Postfix) with ESMTP id 7DF0B15A3;
	Mon,  6 Mar 2006 10:24:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 71CAFB16;
	Mon,  6 Mar 2006 10:24:10 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 4ABCB977;
	Mon,  6 Mar 2006 10:24:10 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6b8axz4.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17290>

Hi,

On Sun, 5 Mar 2006, Junio C Hamano wrote:

> > Is there any reason that git-{annotate,blame} can't take more than one
> > filename, ever?
> 
> I do not see it would be much useful -- the output does not
> have a sign to show file boundary.

CVS does it. Why shouldn't git, too?

Ciao,
Dscho

P.S.: The output for more than one file is separated by something like

	Annotations for <filename.txt>
	***************
