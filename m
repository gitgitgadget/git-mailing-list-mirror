From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] notes: only clean up message file when editing
Date: Sat, 14 Feb 2009 20:29:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902142029010.10279@pacific.mpi-cbg.de>
References: <b36bbe2f7f0ede6a2caa47190ada868dd4c0099c.1234638466.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Feb 14 20:29:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYQD5-00046i-DV
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 20:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbZBNT2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 14:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbZBNT2V
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 14:28:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:46585 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751611AbZBNT2U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 14:28:20 -0500
Received: (qmail invoked by alias); 14 Feb 2009 19:28:18 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp009) with SMTP; 14 Feb 2009 20:28:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/0pVwx2bD0/XV3XJ9ep2P3IJiFjNvuaRonWpewMp
	DZh5i+CHNu2BIR
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <b36bbe2f7f0ede6a2caa47190ada868dd4c0099c.1234638466.git.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109902>

Hi,

On Sat, 14 Feb 2009, Thomas Rast wrote:

> We clean up the notes file when exiting.  However, actions other than
> 'edit' have nothing to do with the file, so they should not remove it
> when done.

ACK.

Ciao,
Dscho
