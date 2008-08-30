From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 04/12] xmerge.c: "diff3 -m" style clips merge reduction
 level to EAGER or less
Date: Sat, 30 Aug 2008 11:34:43 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808301133550.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1220056963-2352-1-git-send-email-gitster@pobox.com> <1220056963-2352-2-git-send-email-gitster@pobox.com> <1220056963-2352-3-git-send-email-gitster@pobox.com> <1220056963-2352-4-git-send-email-gitster@pobox.com>
 <1220056963-2352-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 11:30:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZMmz-0005YR-T0
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 11:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbYH3J3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 05:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbYH3J3d
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 05:29:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:60385 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750878AbYH3J3c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 05:29:32 -0400
Received: (qmail invoked by alias); 30 Aug 2008 09:29:31 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp030) with SMTP; 30 Aug 2008 11:29:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19dFHg7VuddwKrF2bh69qHMzOxFoOvQ98CrdUvEkM
	DInVuja02voe7/
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <1220056963-2352-5-git-send-email-gitster@pobox.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94367>

Hi,

On Fri, 29 Aug 2008, Junio C Hamano wrote:

> Representing the last illustration like this is misleading to say the 
> least:
> 
>     output:      1234A<BCD|56=XY>E789   ; broken "diff3 -m" style
> 
> because the preimage was not ...4A56E... to begin with.  "A" and "E" are
> common only between the postimages.

Okay, I understand now.

Thanks,
Dscho
