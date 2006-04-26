From: sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Alter git-rebase command line options.
Date: Wed, 26 Apr 2006 09:04:47 -0400
Message-ID: <BAYC1-PASMTP097EE76D2B44A2B59F9DF8AEBC0@CEZ.ICE>
References: <BAYC1-PASMTP0659C709B7FFCB63182FE1AEBC0@CEZ.ICE>
	<e2np4p$b9a$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 26 15:09:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYjlb-0007lf-IA
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 15:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWDZNJM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 09:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWDZNJM
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 09:09:12 -0400
Received: from bayc1-pasmtp09.bayc1.hotmail.com ([65.54.191.169]:40658 "EHLO
	BAYC1-PASMTP09.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932425AbWDZNJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Apr 2006 09:09:10 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP09.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 26 Apr 2006 06:10:40 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 2F09B644C28;
	Wed, 26 Apr 2006 09:09:09 -0400 (EDT)
To: Jakub Narebski <jnareb@gmail.com>
Message-Id: <20060426090447.0053165c.seanlkml@sympatico.ca>
In-Reply-To: <e2np4p$b9a$1@sea.gmane.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 26 Apr 2006 13:10:40.0890 (UTC) FILETIME=[D163D5A0:01C66932]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 26 Apr 2006 14:30:47 +0200
Jakub Narebski <jnareb@gmail.com> wrote:
> 
> What about 'git-rebase --onto <newbase> <upstream> <branch>' three options
> version?

Ahh yes, I didn't look closely enough at that, and got fooled by a bug
in the current version[1] into thinking it was never used anyway.  Will have
to respin, the script and come up with some docs.  What's a reason someone
would want or need to use this three option version ?

Sean

[1]  Line 110:  if test "$upstream" = "onto"
