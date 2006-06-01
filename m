From: Sean <seanlkml@sympatico.ca>
Subject: Re: git reset --hard not removing some files
Date: Thu, 1 Jun 2006 15:21:52 -0400
Message-ID: <BAYC1-PASMTP02F2FF1D978A880AFDDA1DAE900@CEZ.ICE>
References: <20060601160052.GK14325@admingilde.org>
	<BAYC1-PASMTP04B113F61282BAE465D7F0AE900@CEZ.ICE>
	<e5n7lv$3tl$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 01 21:28:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlsqZ-00045W-Js
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 21:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965268AbWFAT2V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 15:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbWFAT2V
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 15:28:21 -0400
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:44632 "EHLO
	BAYC1-PASMTP02.CEZ.ICE") by vger.kernel.org with ESMTP
	id S965268AbWFAT2U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jun 2006 15:28:20 -0400
X-Originating-IP: [65.93.43.191]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.191]) by BAYC1-PASMTP02.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 1 Jun 2006 12:28:19 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 1B191644C28;
	Thu,  1 Jun 2006 15:28:18 -0400 (EDT)
To: Jakub Narebski <jnareb@gmail.com>
Message-Id: <20060601152152.35ce04a5.seanlkml@sympatico.ca>
In-Reply-To: <e5n7lv$3tl$1@sea.gmane.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.9.1; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 01 Jun 2006 19:28:19.0693 (UTC) FILETIME=[89F5C9D0:01C685B1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 01 Jun 2006 19:21:19 +0200
Jakub Narebski <jnareb@gmail.com> wrote:

> Do you think it is _frequently_ asked question, worth adding
> to http://git.or.cz/gitwiki/GitFaq ?

Hi Jakub,

Not sure if it needs to be in the FAQ at this point, but i guess it couldn't
hurt either.  The man page actually mentions that --hard deals with tracked
files.  An extra example or a more explicit notice about untracked files
might be helpful though.

Sean
