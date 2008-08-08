From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to replace a single corrupt, packed object?
Date: Fri, 8 Aug 2008 18:48:33 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808081841290.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0808081639490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <0BF03F86-8E4E-46D2-9B04-4385CEBD6902@ai.rug.nl> <20080808161937.GC9152@spearce.org> <90E12BC7-1950-41DF-8BE5-C6B63CE060D9@ai.rug.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	nico@cam.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Fri Aug 08 18:45:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRV5p-00033F-VN
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 18:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759307AbYHHQoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 12:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760305AbYHHQoB
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 12:44:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:42645 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757913AbYHHQoA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 12:44:00 -0400
Received: (qmail invoked by alias); 08 Aug 2008 16:43:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp037) with SMTP; 08 Aug 2008 18:43:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1823TFnhSQ2ZWgNw4tsV+mbrmyrU01J0Iv/KcjSAD
	tKHX7NXrEm9g8U
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <90E12BC7-1950-41DF-8BE5-C6B63CE060D9@ai.rug.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91692>

Hi,

On Fri, 8 Aug 2008, Pieter de Bie wrote:

> On 8 aug 2008, at 18:19, Shawn O. Pearce wrote:
> 
> >The unpack-objects process will fail when it finds this bad object, and 
> >everything after that in the pack file will be dropped on the floor and 
> >not get unpacked.
> 
> Even with the -r switch?
> 
>       -r     When unpacking a corrupt packfile, the command dies at the first
>       corruption. This flag tells it to keep going and make
>              the best effort to recover as many objects as possible.

In any case, the pack is too large for me to let my computer repack 
everything, when only one object needs repacking.

Ciao,
Dscho
