From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 18:00:51 -0400
Message-ID: <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<45349162.90001@op5.se>
	<453536AE.6060601@utoronto.ca>
	<200610172301.27101.jnareb@gmail.com>
	<45354AD0.1020107@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Andreas Ericsson <ae@op5.se>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 00:01:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZx04-0005dH-7i
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 00:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWJQWAz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 18:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWJQWAz
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 18:00:55 -0400
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:38526 "EHLO
	BAYC1-PASMTP07.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1750769AbWJQWAy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 18:00:54 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP07.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 17 Oct 2006 15:06:39 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GZw3Q-0007L3-5s; Tue, 17 Oct 2006 17:00:52 -0400
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Message-Id: <20061017180051.5453ba90.seanlkml@sympatico.ca>
In-Reply-To: <45354AD0.1020107@utoronto.ca>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Oct 2006 22:06:39.0671 (UTC) FILETIME=[8564E470:01C6F238]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 17 Oct 2006 17:27:44 -0400
Aaron Bentley <aaron.bentley@utoronto.ca> wrote:

> Bzr has plugin autoloading, Protocol plugins, Repository format plugins,
> and more.  Because Python supports monkey-patching, a plugin can change
> absolutely anything.

But really why does any of that matter?  This is the open source world.
We don't need plugins to extend features, we just add the feature to
the source.  The example I asked about earlier is a case in point. 
Apparently in bzr "bisect" was implemented as a plugin, yet in Git it
was implemented as a command without any issue at all, no plugins
needed, and its compiled and runs at machine speed.

Sean
