From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Cast things properly to handle >2G files.
Date: Sun, 14 Jun 2009 21:25:34 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906142118250.3305@localhost.localdomain>
References: <E1MFvux-0001ix-I7@fencepost.gnu.org> <alpine.DEB.1.00.0906142215560.26154@pacific.mpi-cbg.de> <E1MG32S-0004C6-8A@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Alfred M. Szmidt" <ams@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jun 15 06:26:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MG3mJ-00043K-Nd
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 06:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbZFOEZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 00:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbZFOEZm
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 00:25:42 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51517 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750870AbZFOEZl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jun 2009 00:25:41 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5F4PYqL032158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 14 Jun 2009 21:25:35 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5F4PYjl029429;
	Sun, 14 Jun 2009 21:25:34 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <E1MG32S-0004C6-8A@fencepost.gnu.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-5.467 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121581>



On Sun, 14 Jun 2009, Alfred M. Szmidt wrote:
> 
> I cannot agree to the D-C-O in good faith, since it speaks of open
> source licenses, a group of licenses that include non-free software
> licenses, something which I cannot support.

If you can't sign off on it, then Junio shouldn't take it, since you're 
basically saying that you cannot say that you own the copyrights or cannot 
license it under the appropriate copyright.

Yes, it speaks of "open source licenses", but it says: "under the open 
source license indicated in the file", and "appropriate open source
license".

For git, that's GPLv2 (or GPLv2-compatible, ie something like the 
simplified BSD license that can just be converted to GPLv2).

The DCO is phrased that way so that other projects that use things like 
the BSD or Apache license can still use the DCO as-is.

Side note: for somebody with a "gnu.org" address, you're showing some 
really bad taste. Do you know that the FSF ends up asking for a hell of a 
lot of paperwork and other crazy things to take peoples submissions. And 
they actually want the copyrights signed over, so that they can change it 
to _any_ license.

The DCO, in contrast, is a paragon of simplicity and clarity, and doesn't 
ask you to sign away any rights.

			Linus
