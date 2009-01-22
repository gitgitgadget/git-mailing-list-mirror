From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH v3 3/3] archive.c: add basic support for submodules
Date: Fri, 23 Jan 2009 00:44:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901230044300.3586@pacific.mpi-cbg.de>
References: <1232659071-14401-1-git-send-email-hjemli@gmail.com> <1232659071-14401-2-git-send-email-hjemli@gmail.com> <1232659071-14401-3-git-send-email-hjemli@gmail.com> <1232659071-14401-4-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 00:46:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ9FU-0004IJ-EJ
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 00:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266AbZAVXor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 18:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755031AbZAVXoq
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 18:44:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:46442 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754255AbZAVXoq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 18:44:46 -0500
Received: (qmail invoked by alias); 22 Jan 2009 23:44:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp061) with SMTP; 23 Jan 2009 00:44:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19tNPMou/Jt4AEjQ/47bH7a+qXr9s1Ghjqu0fNb/m
	WSysAuD+LQ4JDh
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1232659071-14401-4-git-send-email-hjemli@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106804>

Hi,

On Thu, 22 Jan 2009, Lars Hjemli wrote:

> The new --submodules option is used to trigger inclusion of checked out 
> submodules in the archive.
> 
> The implementation currently does not verify that the submodule has been 
> registered as 'interesting' in .git/config, neither does it resolve the 
> currently checked out submodule HEAD but instead uses the commit SHA1 
> recorded in the gitlink entry to identify the submodule root tree.

Please understand that I skipped the rest of the patch.

Ciao,
Dscho
