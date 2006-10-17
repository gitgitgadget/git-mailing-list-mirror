From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 06:35:49 -0400
Message-ID: <BAYC1-PASMTP113CCEFC514ABBD0E38D77AE0E0@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<egr3ud$nqm$1@sea.gmane.org>
	<45340713.6000707@utoronto.ca>
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca>
	<BAYC1-PASMTP08A746E5FA6B87BC65BD37AE0E0@CEZ.ICE>
	<Pine.LNX.4.63.0610171229160.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 12:35:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZmIf-0000Z8-03
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 12:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161187AbWJQKfw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 06:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161189AbWJQKfw
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 06:35:52 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:19881 "EHLO
	BAYC1-PASMTP11.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1161187AbWJQKfv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 06:35:51 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP11.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 17 Oct 2006 03:44:34 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GZlMT-0005MC-Hv; Tue, 17 Oct 2006 05:35:49 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-Id: <20061017063549.da130b5f.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.63.0610171229160.14200@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Oct 2006 10:44:34.0312 (UTC) FILETIME=[3BFAB080:01C6F1D9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 17 Oct 2006 12:30:27 +0200 (CEST)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> It would also make things slow as hell. How do you deal with something 
> like annotate in such a setup?

Some commands like annotate might not make any sense in such a set up.

But one way to get the same (perhaps even better) feature into git 
would be to support shallow clones, in which case even annotate would
continue to work even if somewhat crippled by the lack of a complete
history.

Sean
