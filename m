From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] ls-remote fix for rsync:// transport
Date: Thu, 25 May 2006 01:01:25 -0400
Message-ID: <BAYC1-PASMTP073667D87F8BC653B62894AE990@CEZ.ICE>
References: <7v7j4a3f9i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 07:07:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj84E-0001NK-GN
	for gcvg-git@gmane.org; Thu, 25 May 2006 07:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbWEYFHX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 01:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbWEYFHX
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 01:07:23 -0400
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:18417 "EHLO
	BAYC1-PASMTP07.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S965038AbWEYFHX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 01:07:23 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP07.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 24 May 2006 22:10:42 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id EE67E644C17;
	Thu, 25 May 2006 01:07:20 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060525010125.e2d6325d.seanlkml@sympatico.ca>
In-Reply-To: <7v7j4a3f9i.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.9.1; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 25 May 2006 05:10:42.0921 (UTC) FILETIME=[92713D90:01C67FB9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 24 May 2006 21:22:17 -0700
Junio C Hamano <junkio@cox.net> wrote:

> I think this would fix the "cloning rsync:// clones repository fine but
> does not check out the working tree" problem.

Nice find, works here.

Sean
