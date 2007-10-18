From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
Subject: RE: linux-2.6.git mirror
Date: Thu, 18 Oct 2007 15:46:10 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E270168517F@az33exm24.fsl.freescale.net>
References: <598D5675D34BE349929AF5EDE9B03E2701684C77@az33exm24.fsl.freesca le.net> <alpine.LFD.0.999.0710181518120.26902@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 00:46:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iie8e-0000SZ-Q5
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 00:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760330AbXJRWqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 18:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757550AbXJRWqQ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 18:46:16 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:42840 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758853AbXJRWqP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2007 18:46:15 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id l9IMkBK1007370
	for <git@vger.kernel.org>; Thu, 18 Oct 2007 15:46:12 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9IMkBUi026564
	for <git@vger.kernel.org>; Thu, 18 Oct 2007 17:46:11 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <alpine.LFD.0.999.0710181518120.26902@woody.linux-foundation.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: linux-2.6.git mirror
Thread-Index: AcgR1wZgkrY1fzqNTvCwC6qGIP2JTQAAH3Eg
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61568>

Hi Linus,


> > Is this something I should be worried about?
> 
> No, but if it still happens with a newer git, holler.

I tested this with Junio's latest master and a couple of stable releases
from the maint branch with the same result. In my ignorance I suspected
the build infrastructure so I tried different gcc versions (4.x and 3.x)
and optimization levels (including -O0) different libraries, etc. that I
had on a few machines around here. The result was the same.

What worried me is that I think I traced the source of the error message
in commit.c and in both two possible places from where the message could
come the processing flow seems to be cut shorter because of this.


Thanks for your reply,
Emil.
