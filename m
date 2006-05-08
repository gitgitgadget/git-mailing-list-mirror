From: sean <seanlkml@sympatico.ca>
Subject: Re: Implementing branch attributes in git config
Date: Sun, 7 May 2006 21:44:29 -0400
Message-ID: <BAYC1-PASMTP076C2693FBB563A41CD193AEA80@CEZ.ICE>
References: <1147037659.25090.25.camel@dv>
	<Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
	<1147048587.17371.13.camel@dv>
	<Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
	<7vfyjli9vf.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
	<Pine.LNX.4.63.0605080344480.14008@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 03:49:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcusS-0007iV-C6
	for gcvg-git@gmane.org; Mon, 08 May 2006 03:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWEHBtd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 21:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWEHBtd
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 21:49:33 -0400
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:23381 "EHLO
	BAYC1-PASMTP07.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932237AbWEHBtc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 21:49:32 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP07.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 7 May 2006 18:52:36 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 4F416644C28;
	Sun,  7 May 2006 21:49:31 -0400 (EDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-Id: <20060507214429.623905a6.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.63.0605080344480.14008@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 08 May 2006 01:52:37.0062 (UTC) FILETIME=[14E55660:01C67242]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 8 May 2006 03:45:47 +0200 (CEST)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Hi,
> 
> On Sun, 7 May 2006, sean wrote:
> 
> > Not worth it.  Branch names should be alnums and imho should be
> > case sensitive too.
> 
> Why should they be case sensitive? So you have a branch "origin" and 
> another named "Origin" and get totally confused?
> 

I don't care either way, just think we should be consistent.  Currently
we support case sensitivity in branch names and let people get 
totally confused.   But in practice people don't really get confused
by the linux filesystem which is case sensitive.

Sean
