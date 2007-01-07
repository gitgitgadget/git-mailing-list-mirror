From: Nicolas Vilz <niv@iaglans.de>
Subject: Re: problem with Documentation/hooks.txt
Date: Sun, 7 Jan 2007 16:28:53 +0100
Message-ID: <20070107152852.GB10777@hermes.lan.home.vilz.de>
References: <200701071113.51597.alan@chandlerfamily.org.uk> <20070107123408.GD6115@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alan Chandler <alan@chandlerfamily.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 16:29:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3Zxe-0007zH-4u
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 16:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbXAGP3U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 10:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbXAGP3U
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 10:29:20 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:1279 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932572AbXAGP3T (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jan 2007 10:29:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id C6C273ED7;
	Sun,  7 Jan 2007 16:29:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at vsectoor.geht-ab-wie-schnitzel.de
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lB9bp-mrnsRK; Sun,  7 Jan 2007 16:28:51 +0100 (CET)
Received: from localhost (hermes.lan.home.vilz.de [192.168.100.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 821783E9F;
	Sun,  7 Jan 2007 16:28:49 +0100 (CET)
To: Martin Waitz <tali@admingilde.org>
Content-Disposition: inline
In-Reply-To: <20070107123408.GD6115@admingilde.org>
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36174>

On Sun, Jan 07, 2007 at 01:34:08PM +0100, Martin Waitz wrote:
> hoi :)
> 
> On Sun, Jan 07, 2007 at 11:13:51AM +0000, Alan Chandler wrote:
> > I was just looking at the documentation of the post-commit hook in order 
> > to fix a problem on one of my repositories and I came across this:-
> > 
> > "The default 'post-commit' hook, when enabled, demonstrates how to
> > send out a commit notification e-mail."
> 
> Have a look at the 'update' hook instead.
> Where have you found this hint? We should change the documentation here.

May I repeat my ignored request to check the update-hook-example in
Documentation/howto/ for working correctly? It doesn't. 

I am no bash guru, but as far as i understand the code, the size of an
argument is checked with matchlen. That is imho bad for regexp. 

I built the scenario described there and i couldn't commit to the tmp/*
branches. I also couldn't commit to the bw/ topics and i couldn't tag
anything as the specific role proposed in this example.

as long as the length of the refs-string from the commit matches the one
in allowed-users, all is ok. But if it doesn't, which is imho obviously
the case if you use regexp in the allowed-users file, it doesn't work.

Unfortunatelly i can't fix that myself, but it would be good to correct
that example, if it really doesn't work... or at least please tell me,
what i am doing wrong :)

Nicolas Vilz
