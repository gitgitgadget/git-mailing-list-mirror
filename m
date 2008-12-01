From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/8] generate-cmdlist.sh: avoid selecting synopsis at
 wrong place
Date: Mon, 1 Dec 2008 15:10:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812011505551.30769@pacific.mpi-cbg.de>
References: <1228042478-1886-1-git-send-email-pclouds@gmail.com> <1228042478-1886-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-601636228-1228140551=:30769"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 15:03:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L79NB-0003lA-J1
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 15:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbYLAOCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 09:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbYLAOCU
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 09:02:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:56090 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751578AbYLAOCT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 09:02:19 -0500
Received: (qmail invoked by alias); 01 Dec 2008 14:02:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp035) with SMTP; 01 Dec 2008 15:02:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18VGWA/HNQVdcr+ua41EIHUDC4IHEV2MxdnDlWOpW
	wyKCe/Pzv0cxOp
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1228042478-1886-2-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Content-ID: <alpine.DEB.1.00.0812011509350.30769@pacific.mpi-cbg.de>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102035>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-601636228-1228140551=:30769
Content-Type: TEXT/PLAIN; CHARSET=VISCII
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.1.00.0812011509351.30769@pacific.mpi-cbg.de>

Hi,

On Sun, 30 Nov 2008, Nguy­n Thái Ng÷c Duy wrote:

> In "common" man pages there is luckily no "NAME" anywhere except at 
> beginning of documents. If there is another "NAME", sed could mis-select 
> it and lead to common-cmds.h corruption. So better nail it at beginning 
> of line, which would reduce corruption chance.

I have no idea why you put this into the sparse checkout patch series.

As it is, the patch series is _already_ hard to review (as it is large not 
only in term of number of patches, but also individual patch size), 
_especially_ given the fact that there is no clear, precise and short 
description of why/how the sparse checkout is implemented.

For example, instead of using the BLURP area of the cover letter to put 
forth convincing arguments why this is needed, and why it is implemented 
in the best possible manner, you wasted two lines stating the obvious.

IMO that is almost like _asking_ people not to have a look at it.

Ciao,
Dscho
--8323328-601636228-1228140551=:30769--
