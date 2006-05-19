From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Allow pickaxe and diff-filter options to be used by git
 log.
Date: Fri, 19 May 2006 01:49:38 -0400
Message-ID: <BAYC1-PASMTP092CB0667E05EA20FBA30EAEA70@CEZ.ICE>
References: <BAYC1-PASMTP04945C92FB14DA65AB1AC7AEA70@CEZ.ICE>
	<7vac9elm2p.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP096010F052E9BF78B5FD4AAEA70@CEZ.ICE>
	<7vbqtuk1uw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 07:55:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgxxN-0005o7-M4
	for gcvg-git@gmane.org; Fri, 19 May 2006 07:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWESFzW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 01:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWESFzW
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 01:55:22 -0400
Received: from bayc1-pasmtp09.bayc1.hotmail.com ([65.54.191.169]:41507 "EHLO
	BAYC1-PASMTP09.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932226AbWESFzV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 01:55:21 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP09.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 18 May 2006 22:57:02 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 0384C644C28;
	Fri, 19 May 2006 01:55:20 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060519014938.272dd7a1.seanlkml@sympatico.ca>
In-Reply-To: <7vbqtuk1uw.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 19 May 2006 05:57:03.0156 (UTC) FILETIME=[0D1CEF40:01C67B09]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 18 May 2006 22:41:43 -0700
Junio C Hamano <junkio@cox.net> wrote:

> To me, if the user explicitly says --diff-filter or -S, it seems
> more natural to interpret that the user wanted _some_ sort of
> diff.  Now, there are people who say raw format is anti-human,
> which I consider is a valid view, but I think it is better than
> NO_OUTPUT in that case.
> 
> I wonder if doing something like this instead makes more sense
> perhaps?

Well, I was looking at the use of diff-filter and -S as a way
to prune uninteresting commits from the log rather than as an 
desire to see the patch information.

It's pretty natural to add -p or --stat along with the above 
options if that is what the user wants.  If you make those implied
by using --diff-filter or -S is there a way for the user to say,
no patch and no stat?

Sean
