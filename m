From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 16:53:13 -0400
Message-ID: <BAYC1-PASMTP07D0D16EAA6ABADDAD39B1AE020@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>
	<45357411.20500@utoronto.ca>
	<200610180246.18758.jnareb@gmail.com>
	<45357CC3.4040507@utoronto.ca>
	<Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	<4536EC93.9050305@utoronto.ca>
	<87lkncev90.wl%cworth@cworth.org>
	<453792A8.1010700@utoronto.ca>
	<878xjc2qeb.wl%cworth@cworth.org>
	<453803E6.2060309@utoronto.ca>
	<87ods727pn.wl%cworth@cworth.org>
	<45382120.9060702@utoronto.ca>
	<87irie1wvv.wl%cworth@cworth.org>
	<453A7D7E.8060105@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Carl Worth <cworth@cworth.org>, Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 22:53:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbNqI-00009L-VE
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 22:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbWJUUxQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 16:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWJUUxQ
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 16:53:16 -0400
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:41761 "EHLO
	BAYC1-PASMTP07.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1751751AbWJUUxP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 16:53:15 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP07.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 21 Oct 2006 13:59:04 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GbMu9-0002OO-F1; Sat, 21 Oct 2006 15:53:13 -0400
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Message-Id: <20061021165313.dba67497.seanlkml@sympatico.ca>
In-Reply-To: <453A7D7E.8060105@utoronto.ca>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 21 Oct 2006 20:59:05.0046 (UTC) FILETIME=[BE4D3760:01C6F553]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 21 Oct 2006 16:05:18 -0400
Aaron Bentley <aaron.bentley@utoronto.ca> wrote:

> Our experience really is that it does work.

Of course it works as long as you accept the implicit requirements of
supporting them and ignore the cases where they change out from
underneath the user.  But as soon as users want to embrace distributive
models where there isn't a central shared repo, at best revno's are
unhelpful and at worst they are counterproductive.  The proof of this
is that if revno's were sufficient bzr wouldn't need revid's.

Since the utility provided by revno's seems so minimal even in the
case where they do work, Git simply doesn't bother with them.  And
"our" experience is that Git really does work well without them.

Sean
