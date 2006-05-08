From: sean <seanlkml@sympatico.ca>
Subject: Re: Implementing branch attributes in git config
Date: Sun, 7 May 2006 21:11:45 -0400
Message-ID: <BAYC1-PASMTP087BACE5DC41C608DDC18DAEA80@CEZ.ICE>
References: <1147037659.25090.25.camel@dv>
	<Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
	<BAYC1-PASMTP08D42DA222BA9843352CC1AEA80@CEZ.ICE>
	<Pine.LNX.4.64.0605071751050.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: proski@gnu.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 03:16:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcuMo-0003uN-BH
	for gcvg-git@gmane.org; Mon, 08 May 2006 03:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWEHBQt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 21:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWEHBQt
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 21:16:49 -0400
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]:36618 "EHLO
	BAYC1-PASMTP08.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932238AbWEHBQt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 21:16:49 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP08.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 7 May 2006 18:21:18 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 77E1A644C28;
	Sun,  7 May 2006 21:16:47 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Message-Id: <20060507211145.36fb1be4.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0605071751050.3718@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 08 May 2006 01:21:19.0093 (UTC) FILETIME=[B58A0250:01C6723D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 7 May 2006 17:55:25 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> On Sun, 7 May 2006, sean wrote:
> > 
> > Having magic sections that prepend "branch." seems a bit suspect;
> > why not just be explicit:
> > 
> >   [branch.Origin]
> >       URL = ...
> >       fetch = master
> 
> Exactly because section (and key) names are normally not case sensitive.

Restore case sensitivity to config file parsing and the problem largely goes
away.  Or go the other route and remove case sensitivity from all the other 
bits (branches names etc..).

Sean
