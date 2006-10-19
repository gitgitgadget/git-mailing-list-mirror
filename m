From: Sean <seanlkml@sympatico.ca>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Thu, 19 Oct 2006 06:40:49 -0400
Message-ID: <BAYC1-PASMTP061F10D0B5AF9F6608134CAE0C0@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610172351.17377.jnareb@gmail.com>
	<4535590C.4000004@utoronto.ca>
	<200610180057.25411.jnareb@gmail.com>
	<Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>
	<20061018053647.GA3507@coredump.intra.peff.net>
	<Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
	<20061018185225.GU20017@pasky.or.cz>
	<eh76np$trg$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Thu Oct 19 12:40:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaVKb-0004Fk-Ri
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 12:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161402AbWJSKkw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 06:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161404AbWJSKkw
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 06:40:52 -0400
Received: from bayc1-pasmtp06.bayc1.hotmail.com ([65.54.191.166]:8745 "EHLO
	BAYC1-PASMTP06.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1161402AbWJSKkv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 06:40:51 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP06.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 19 Oct 2006 03:44:01 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GaUOP-0004Af-Kt; Thu, 19 Oct 2006 05:40:49 -0400
To: Alexander Belchenko <bialix@ukr.net>
Message-Id: <20061019064049.bec89582.seanlkml@sympatico.ca>
In-Reply-To: <eh76np$trg$1@sea.gmane.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 19 Oct 2006 10:44:01.0828 (UTC) FILETIME=[7D718640:01C6F36B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 19 Oct 2006 09:46:32 +0300
Alexander Belchenko <bialix@ukr.net> wrote:

> You probably miss main idea of bzr bundles. It's not just the way to
> send via e-mail or other appropriate transport the part of repository.
> It primarily was designed to be human readable as usual diff (i.e.
> patch). It was designed to solve 2 thing simultaneously:
> 
> - be informative for human as usual patch
> - be consistent for machine.

Petr already mentioned that the data currently shown in the email
text isn't really useful.  But it's simple to make it an attachment
and show a combined diff instead.

Although that might just make the email bigger for not a lot of
gain.  It's easy to use the git command line and gui tools to inspect
the bundle after importing it into your repository.  And just as
easy to expunge the bundle afterward if it isn't up to grade.

Sean
