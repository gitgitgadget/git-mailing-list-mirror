From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 06:01:12 -0400
Message-ID: <BAYC1-PASMTP07B8250B054F5CFF48C8C0AE0E0@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<egr3ud$nqm$1@sea.gmane.org>
	<45340713.6000707@utoronto.ca>
	<200610170119.09066.jnareb@gmail.com>
	<1161077866.9020.69.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 12:01:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZll8-0003Xv-1j
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 12:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbWJQKBP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 06:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbWJQKBP
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 06:01:15 -0400
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:26100 "EHLO
	BAYC1-PASMTP07.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1161020AbWJQKBO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 06:01:14 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP07.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 17 Oct 2006 03:06:59 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GZkoz-0005Ft-2i; Tue, 17 Oct 2006 05:01:13 -0400
To: Robert Collins <robertc@robertcollins.net>
Message-Id: <20061017060112.2d036f96.seanlkml@sympatico.ca>
In-Reply-To: <1161077866.9020.69.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Oct 2006 10:06:59.0843 (UTC) FILETIME=[FC360530:01C6F1D3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 17 Oct 2006 19:37:45 +1000
Robert Collins <robertc@robertcollins.net> wrote:

> Precisely how does this rebase operate in git ? 
> Does it preserve revision ids for the existing work, or do they all
> change?
> 
> bzr has a graft plugin which walks one branch applying all its changes
> to another preserving the users metadata but changing the uuids for
> revisions. 

git rebase does exactly the same as you describe, including changing
the sha1 for each commit it moves.

Sean
