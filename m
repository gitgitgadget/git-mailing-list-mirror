From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH v3 3/3] archive.c: add basic support for submodules
Date: Sat, 24 Jan 2009 20:52:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901242049580.14855@racer>
References: <1232659071-14401-1-git-send-email-hjemli@gmail.com>  <1232659071-14401-2-git-send-email-hjemli@gmail.com>  <1232659071-14401-3-git-send-email-hjemli@gmail.com>  <1232659071-14401-4-git-send-email-hjemli@gmail.com>  <alpine.DEB.1.00.0901230044300.3586@pacific.mpi-cbg.de>
  <8c5c35580901231040i380c6458x1a6103cd6f55c479@mail.gmail.com>  <alpine.DEB.1.00.0901232054360.21467@intel-tinevez-2-302>  <8c5c35580901240044y452b465fj94df82fc2b8f7ee9@mail.gmail.com>  <alpine.DEB.1.00.0901241443270.13232@racer>
 <8c5c35580901241126q2da83f50m1472ed017b92c982@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 20:55:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQobf-0008Mw-NX
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 20:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846AbZAXTvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 14:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752284AbZAXTvl
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 14:51:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:37904 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751761AbZAXTvk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 14:51:40 -0500
Received: (qmail invoked by alias); 24 Jan 2009 19:51:37 -0000
Received: from pD9EB3F9A.dip0.t-ipconnect.de (EHLO noname) [217.235.63.154]
  by mail.gmx.net (mp003) with SMTP; 24 Jan 2009 20:51:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hV59YfNwhEym0+9ST/GtP4LYkGDxjy4pb6mX2Nw
	wEYGPPjpGWtLMF
X-X-Sender: gene099@racer
In-Reply-To: <8c5c35580901241126q2da83f50m1472ed017b92c982@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106999>

Hi,

On Sat, 24 Jan 2009, Lars Hjemli wrote:

> $ git archive --submodules <tree-ish>: Create an archive which
> includes the trees of all gitlink entries in <tree-ish>, fail unless
> all the required objects are available.
> 
> $ git archive --submodules=<group>: Same as above, but only traverse
> submodules in the specified group (as defined in $GIT_CONFIG).

How about having the former with --submodules='*' and let --submodules 
without argument include those submodules that are checked out (none in a 
bare repository)?

Thanks,
Dscho
