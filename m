From: sean <seanlkml@sympatico.ca>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Thu, 12 Jan 2006 23:06:33 -0500
Message-ID: <BAYC1-PASMTP067B249A8110916F036FB3AE260@CEZ.ICE>
References: <BAYC1-PASMTP117A18814EAAFACFE0F31DAE270@CEZ.ICE>
	<7vzmm1mcfz.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP102ED7B30D2B48BEE601F5AE260@CEZ.ICE>
	<7v4q48hizr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 05:11:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExGHN-0003PY-63
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 05:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161334AbWAMELD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 23:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWAMELD
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 23:11:03 -0500
Received: from bayc1-pasmtp06.bayc1.hotmail.com ([65.54.191.166]:23704 "EHLO
	BAYC1-PASMTP06.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S964799AbWAMELC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 23:11:02 -0500
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.6.171]) by BAYC1-PASMTP06.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 12 Jan 2006 20:11:34 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id AD8A6644C23;
	Thu, 12 Jan 2006 23:10:54 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060112230633.0858694a.seanlkml@sympatico.ca>
In-Reply-To: <7v4q48hizr.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 13 Jan 2006 04:11:34.0734 (UTC) FILETIME=[7107DEE0:01C617F7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 12 Jan 2006 20:03:36 -0800
Junio C Hamano <junkio@cox.net> wrote:

> sean <seanlkml@sympatico.ca> writes:
> 
> > ...   Apparently he is more or less
> > hand munging mutliple cvs branches into a nice git package for 
> > Linus to pull.  He said that many of the patches don't apply as-is
> > and need some manual tweaking before committing.
> 
> Then what is needed is an exporter from those cvs branches into
> git.  Well, don't we have one already?  If it does not work for
> dirty changes, wouldn't it be better to fix it so it is
> restartable, just like when rebase stops it lets you fix up and
> go on, without having you to write "From: " or GIT_AUTHOR_*
> yourself and just does the right thing?
> 

Yes perhaps there is some streamlining of the cvs importer that could
be done.  However, I got the impression from him that he was cherry 
picking stuff out of multiple cvs branches so perhaps that's beyond 
what the cvs importer was ever designed to handle.

Anyway, I think this is a more general problem than just the cvs 
importing case; the current interface for setting author information 
is brain damaged and a better method should be offered.

I think you're over estimating the downsides of allowing this to be
set the same was as it is in the git-am case and underestimating the
number of people who would find it useful, but I personally don't 
really care if you'd rather have it as a command line option.

Cheers,
Sean
