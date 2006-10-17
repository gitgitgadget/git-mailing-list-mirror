From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 18:56:22 -0400
Message-ID: <BAYC1-PASMTP01369CD694D75CB61ACCC7AE0E0@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<45349162.90001@op5.se>
	<453536AE.6060601@utoronto.ca>
	<200610172301.27101.jnareb@gmail.com>
	<45354AD0.1020107@utoronto.ca>
	<BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
	<45355CBB.80108@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Andreas Ericsson <ae@op5.se>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 00:56:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZxrT-0000q2-20
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 00:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWJQW40 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 18:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWJQW40
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 18:56:26 -0400
Received: from bayc1-pasmtp01.bayc1.hotmail.com ([65.54.191.161]:23335 "EHLO
	bayc1-pasmtp01.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751000AbWJQW4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 18:56:24 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by bayc1-pasmtp01.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 17 Oct 2006 15:56:24 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GZwv8-0007Tx-St; Tue, 17 Oct 2006 17:56:22 -0400
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Message-Id: <20061017185622.30fbc6c0.seanlkml@sympatico.ca>
In-Reply-To: <45355CBB.80108@utoronto.ca>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Oct 2006 22:56:24.0362 (UTC) FILETIME=[786898A0:01C6F23F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 17 Oct 2006 18:44:11 -0400
Aaron Bentley <aaron.bentley@utoronto.ca> wrote:

> That can lead to feature bloat.  Some plugins are not useful to
> everyone, e.g. Mercurial repository support.  Some plugins introduce
> additional dependencies that we don't want to have in the core (e.g. the
> rsync, baz-import and graph-ancestry commands).

Shrug, it's really not that tough to do in regular ole source code.
On Fedora for instance you have your choice of which rpms you want
to install to get the features of Git you want.

> Plugins also don't have a Bazaar's rigid release cycle, testing
> requirements and coding conventions, so they are a convenient way to try
> out an idea, before committing to the effort of getting it merged into
> the core.

Hmm.. It's pretty easy to test out Git ideas too.  People do it all
the time, and without plugins.  Junio maintains several such trees
for instance.  Dunno.. I just think plugs _sounds_ good to developers
without much real benefit to users over regular ole source code.

> The bisect plugin is just as performant as any other bzr command.  (The
> whole VCS is in Python.)  Most people don't use it, so we don't ship it
> as part of the base install, but anyone who wants it can have it.

Sure, and anyone who wants to use StGit on top of Git can download and
use it as well.

Sean
