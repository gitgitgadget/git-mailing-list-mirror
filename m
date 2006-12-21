From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Attempt to make git-checkout man page a bit more clear.
Date: Thu, 21 Dec 2006 03:31:00 -0500
Message-ID: <BAYC1-PASMTP071BBC53B5CE7917CE8DE1AECE0@CEZ.ICE>
References: <20061221015350.245cc964.seanlkml@sympatico.ca>
	<7vbqlx1yht.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 09:31:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxJKV-0004qQ-Md
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 09:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422855AbWLUIbE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 03:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422859AbWLUIbE
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 03:31:04 -0500
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:39689 "EHLO
	BAYC1-PASMTP07.BAYC1.HOTMAIL.COM" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422855AbWLUIbD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Dec 2006 03:31:03 -0500
X-Originating-IP: [65.93.43.74]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.74]) by BAYC1-PASMTP07.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 21 Dec 2006 00:37:54 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GxIOI-0005uA-MF; Thu, 21 Dec 2006 02:30:58 -0500
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20061221033100.b244573d.seanlkml@sympatico.ca>
In-Reply-To: <7vbqlx1yht.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 21 Dec 2006 08:37:54.0500 (UTC) FILETIME=[4EFD2840:01C724DB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Dec 2006 23:47:42 -0800
Junio C Hamano <junkio@cox.net> wrote:

> The 'restore from arbitrary tree-ish' form does not take -m as
> far as I know.
> 
> Although it might be interesting to do a single-file three-way
> merge, I do not think the command is _checkout_ anymore once it
> starts doing that.

Yeah, I should have caught that.  As well, your explanation makes me
wonder if it makes sense to change <branch> in the third form to
<tree-ish> ?  Would you like an updated patch or will you just make
the touch up(s) yourself?

Sean
