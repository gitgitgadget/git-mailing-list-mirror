From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Wed, 19 Aug 2009 07:04:24 -0600
Message-ID: <4A8BF858.5060002@workspacewhiz.com>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>  <1250600335-8642-1-git-send-email-mstormo@gmail.com>  <7vtz05dq0p.fsf@alter.siamese.dyndns.org> <4A8AE7C5.7050600@gmail.com>  <4A8AED8B.9080604@gmail.com>  <alpine.DEB.1.00.0908182349220.8306@pacific.mpi-cbg.de>  <40aa078e0908181502v32cbd223xcde1cd363dc76345@mail.gmail.com>  <alpine.DEB.1.00.0908190038110.8306@pacific.mpi-cbg.de> <40aa078e0908181548t5df05b1ct8013b99ea703ebba@mail.gmail.com> <alpine.DEB.1.00.0908190910270.5594@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Marius Storm-Olsen <marius@storm-olsen.com>,
	Johan 't Hart <johanthart@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com, bonzini@gnu.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 19 15:07:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdksh-0001wM-7b
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 15:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbZHSNEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 09:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbZHSNEb
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 09:04:31 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:58984 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbZHSNE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 09:04:29 -0400
Received: (qmail 11210 invoked by uid 399); 19 Aug 2009 07:04:27 -0600
Received: from unknown (HELO ?192.168.1.107?) (jjensen@workspacewhiz.com@24.10.200.9)
  by hsmail.qwknetllc.com with ESMTPAM; 19 Aug 2009 07:04:27 -0600
X-Originating-IP: 24.10.200.9
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <alpine.DEB.1.00.0908190910270.5594@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126542>

----- Original Message -----
From: Johannes Schindelin
Date: 8/19/2009 1:16 AM
> Using a Makefile from within Visual Studio is just not the intended way to 
> do things, so you will hit the limitations sooner or later.
>   
I use Visual Studio makefile projects daily and have for years.  In my 
case, an additional script takes the Jam build scripts and creates the 
.vcproj files with the proper file lists and project source folders.  
These Makefile .vcproj files have full support for Intellisense, 
debugging, and nearly everything else.  The only thing a Makefile 
project doesn't seem to expose is single file compilation.

Josh
