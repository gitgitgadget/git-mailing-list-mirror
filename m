From: Thomas Neumann <tneumann@users.sourceforge.net>
Subject: Re: wishlist: git info
Date: Tue, 13 Nov 2007 12:32:19 +0100
Message-ID: <47398B43.30408@users.sourceforge.net>
References: <fhad5q$iia$1@ger.gmane.org> <20071112222106.GE2918@steel.home> <4738D8AA.1030604@users.sourceforge.net> <fhaol0$p5r$1@ger.gmane.org> <fhbn50$uqu$1@ger.gmane.org> <Pine.LNX.4.64.0711131111220.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 13 12:32:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iru0D-0000WG-A1
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 12:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554AbXKMLcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 06:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753536AbXKMLcE
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 06:32:04 -0500
Received: from tneu02.synserver.de ([217.119.58.222]:1528 "EHLO
	tneu02.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbXKMLcD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 06:32:03 -0500
Received: from [139.19.64.161] (guest-161.mpi-sb.mpg.de [139.19.64.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by tneu02.synserver.de (Postfix) with ESMTP id E4DD4680BA;
	Tue, 13 Nov 2007 12:32:01 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <Pine.LNX.4.64.0711131111220.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64791>

> Is slightly troubles me that you put so much emphasis on what I would call 
> "remote information".  I understand that in svn, your working directory 
> without the server is not very useful.  But we do not have that problem.
that is true. My usage pattern probably stems from the fact that I am a
long term svn user :) And I use git for work now, where there is indeed
some kind of central repository just as in a Subversion setting.
In a fully decentralized setting the remote information is probably not
as important, although you might still want to know what happens if you
issue "git pull".


> FWIW I think a much better idea is to have that bash prompt that was 
> posted some months ago; there's not even a need to run a program manually 
> then!
a bash prompt is nice too, of course. But there is only so much
information you can reasonably encode in the prompt.
When you know the remote url (ok, this assumes a "centralized" model),
branch, head commit and date of the head commit (this is just for
humans), you know very precisely what you are looking at. For the more
decentralized users some other information might be relevant, I don't know.

While the head commit hash is enough to identify a point in the revision
history, the other information allows a human to identify the point in
the revision history easily. So I can see what is checked out, how old
the checkout is etc.

> His name is "Riesen", just like in the German translation of the famous 
> Newton statement.
sorry for the typo, I noticed it just the moment I had pressed send...
Sometimes I really wish I could edit mails after sending them.

Thomas
