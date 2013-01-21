From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [RFC/PATCH] add: warn when -u or -A is used without filepattern
Date: Mon, 21 Jan 2013 21:29:46 +0100 (CET)
Message-ID: <2025469478.4311560.1358800186770.JavaMail.root@dewire.com>
References: <vpqy5fmva6b.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jan 21 21:30:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxO0R-0002HF-AX
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 21:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756610Ab3AUU3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 15:29:49 -0500
Received: from zimbra.dewire.com ([83.140.172.131]:49316 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771Ab3AUU3s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 15:29:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 22B7E826E1;
	Mon, 21 Jan 2013 21:29:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id asOfI07SL+Se; Mon, 21 Jan 2013 21:29:46 +0100 (CET)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id CCE6A8262E;
	Mon, 21 Jan 2013 21:29:46 +0100 (CET)
In-Reply-To: <vpqy5fmva6b.fsf@grenoble-inp.fr>
X-Originating-IP: [213.67.12.15]
X-Mailer: Zimbra 7.2.0_GA_2681 (ZimbraWebClient - FF3.0 (Mac)/7.2.0_GA_2681)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214163>



----- Ursprungligt meddelande -----

> > git diff
> > #looks good
> > git add -u
> 
> That's indeed the kind of mistake I'd like to avoid. In your example,
> "git diff" is tree-wide, and "git add -u" is limited to ., so in
> general
> "git add -u" won't stage the same thing as "git diff" just showed.

Good point. I rarely cd to anything but the top of the tree, but that
might be just me. OTOH, git diff after -u would remind me. It would bad if -u 
was tree wide and diff wasn't, but fortunately that's not the case.

The -A is a bit worse since it adds all the crap files lying around.

-- robin
