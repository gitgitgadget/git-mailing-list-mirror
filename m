From: Sean <seanlkml@sympatico.ca>
Subject: Re: Problems setting up bare repository (git 1.5.3.3)
Date: Tue, 2 Oct 2007 14:55:56 -0400
Message-ID: <BAYC1-PASMTP05AB6AE16E90C15710819EAEAE0@CEZ.ICE>
References: <m3fy0u7bk3.fsf@barry_fishman.acm.org>
	<7vejgeqxd1.fsf@gitster.siamese.dyndns.org>
	<87bqbisae6.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0710021045430.28395@racer.site>
	<87641psey8.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0710021841300.28395@racer.site>
	<7vwsu5l6j8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Carl Worth <cworth@cworth.org>,
	Barry Fishman <barry_fishman@acm.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 20:56:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icmut-0004IM-Ty
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 20:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780AbXJBS4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 14:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756776AbXJBS4B
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 14:56:01 -0400
Received: from bay0-omc2-s23.bay0.hotmail.com ([65.54.246.159]:18476 "EHLO
	bay0-omc2-s23.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756766AbXJBSz7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Oct 2007 14:55:59 -0400
Received: from BAYC1-PASMTP05 ([65.54.191.165]) by bay0-omc2-s23.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 2 Oct 2007 11:55:59 -0700
X-Originating-IP: [65.93.41.219]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.41.219]) by BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Tue, 2 Oct 2007 11:55:58 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with smtp (Exim 4.43)
	id 1IcmuS-0001Bp-Fx; Tue, 02 Oct 2007 14:55:56 -0400
In-Reply-To: <7vwsu5l6j8.fsf@gitster.siamese.dyndns.org>
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i686-pc-linux-gnu)
X-OriginalArrivalTime: 02 Oct 2007 18:55:58.0830 (UTC) FILETIME=[DEB398E0:01C80525]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59711>

On Tue, 02 Oct 2007 11:23:39 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> If your push were "next~27^2:frotz", it becomes even less clear.
> It may be that I am pushing out the tip of a topic branch I
> usually do not push out, so it would be easier for some specific
> person to build on top of.  Or maybe I am marking that place as
> a lightweight tag.  They are equally likely.

But you could pick a reasonable default in assuming that a new
branch is desired with the above example.  If someone wants to
push a tag, they can create the tag locally, and then push it.

Sean
