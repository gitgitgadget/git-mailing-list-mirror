From: sean <seanlkml@sympatico.ca>
Subject: Re: problem installing latest cogito
Date: Sat, 21 Jan 2006 15:01:42 -0500
Message-ID: <BAYC1-PASMTP04E629315AB2ABBF6FC1FFAE1E0@CEZ.ICE>
References: <fof4t15q95qkakgk6b7fbfuqh3r6q7ei17@4ax.com>
	<20060121194826.GK28365@pasky.or.cz>
	<20060121144901.33b03395.seanlkml@sympatico.ca>
	<20060121200345.GL28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: morgad@eclipse.co.uk, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 21:06:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0P0R-00024p-3h
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 21:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWAUUGh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 15:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWAUUGh
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 15:06:37 -0500
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:47740 "EHLO
	BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932304AbWAUUGg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 15:06:36 -0500
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.6.171]) by BAYC1-PASMTP04.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 21 Jan 2006 12:06:35 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id CD375644C23;
	Sat, 21 Jan 2006 15:06:34 -0500 (EST)
To: Petr Baudis <pasky@suse.cz>
Message-Id: <20060121150142.4b1bb47e.seanlkml@sympatico.ca>
In-Reply-To: <20060121200345.GL28365@pasky.or.cz>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.10; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 21 Jan 2006 20:06:36.0094 (UTC) FILETIME=[2E9B85E0:01C61EC6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 21 Jan 2006 21:03:45 +0100
Petr Baudis <pasky@suse.cz> wrote:

> 
> Yes, the problem goes away because then make will split that to two
> lines, causing:
> 
>         sed -e 's/\${COGITO_LIB}/\${COGITO_LIB:-\/home\/xpasky\/lib\/cogito\/}/g;
> /bin/sh: -c: line 0: unexpected EOF while looking for matching `''
> /bin/sh: -c: line 1: syntax error: unexpected end of file
> 


Ah sorry I didn't test it in within the makefile context.   However, just
typing the above on the command line works, whereas the one with the
quoted end-of-line gives the error message mentioned in the initial report
so I suspect it's at least a clue to the real problem.


Sean
