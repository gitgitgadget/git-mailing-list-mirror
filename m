From: sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Another config file parsing fix.
Date: Sat, 6 May 2006 14:25:11 -0400
Message-ID: <BAYC1-PASMTP08FCAC8B8FB768ED1791F1AEAA0@CEZ.ICE>
References: <20060506141402.3909cb37.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sat May 06 20:30:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcRXl-0003av-TY
	for gcvg-git@gmane.org; Sat, 06 May 2006 20:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWEFSaM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 14:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWEFSaM
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 14:30:12 -0400
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]:46828 "EHLO
	BAYC1-PASMTP08.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751080AbWEFSaL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 14:30:11 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP08.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 6 May 2006 11:34:38 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 66446644C28;
	Sat,  6 May 2006 14:30:09 -0400 (EDT)
To: sean <seanlkml@sympatico.ca>
Message-Id: <20060506142511.667fe954.seanlkml@sympatico.ca>
In-Reply-To: <20060506141402.3909cb37.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 06 May 2006 18:34:39.0156 (UTC) FILETIME=[BBA15740:01C6713B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 6 May 2006 14:14:02 -0400
sean <seanlkml@sympatico.ca> wrote:

> If the variable we need to store should go into a section
> that currently only has a single variable (not matching
> the one we're trying to insert), we will already be into
> the next section before we notice we've bypassed the correct
> location to insert the variable.
> 
> To handle this case we store the current location as soon
> as we find a variable matching the section of our new
> variable.
> 
    
Sorry.. this should really be amended to mention that it was Linus
who spotted the problem.


Sean
