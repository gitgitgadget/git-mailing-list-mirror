From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Use find instead of perl in t5000 to get file
	modification time
Date: Sat, 1 Nov 2008 15:24:34 +0100
Message-ID: <20081101142434.GA7157@steel.home>
References: <81b0412b0810290338j1beaa25bx9fb373a69f5dfe7@mail.gmail.com> <1225344554.10803.17.camel@maia.lan> <20081031070003.GA4458@blimp.localdomain> <alpine.DEB.1.00.0810312314190.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081031233736.GB21997@steel.home> <alpine.DEB.1.00.0811010121570.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?iso-8859-15?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 01 15:26:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwHQS-0001J9-AL
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 15:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbYKAOYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 10:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbYKAOYu
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 10:24:50 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:62978 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbYKAOYt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 10:24:49 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx9CE82pYs=
Received: from tigra.home (Fa914.f.strato-dslnet.de [195.4.169.20])
	by post.webmailer.de (mrclete mo63) (RZmta 17.14)
	with ESMTP id 200e4bkA1Bjcse ; Sat, 1 Nov 2008 15:24:38 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 953EA277C8;
	Sat,  1 Nov 2008 16:24:37 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id F0E0E56D27; Sat,  1 Nov 2008 15:24:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0811010121570.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99744>

Johannes Schindelin, Sat, Nov 01, 2008 01:23:32 +0100:
> 
> Well, if you install Git for Windows (as opposed to cygwin), it is minimum 
> hassle, and Perl is delivered right with it.
> 

I'd like to try it again, but weren't ther some fatal problems with
cygwin1.dll being in PATH? I always work either in Cygwin's bash or
just have to have it in PATH, because of the build environment even
being strictly Windows based (case-insensitive and alike) just have to
use sane tooling in its scripts.

> 
> P.S.: some guys at the GSoC mentor summit convinced me in at least trying 
> to fix _their_ problems on msysGit, so chances are good I'll fix issues 
> you would encounter in the same run.
> 

Do you still plan to distribute MinGW with it? It's very nice to be
able to track Junio's repo, have own branches and rebuild Git from
time to time. For me, at least.
