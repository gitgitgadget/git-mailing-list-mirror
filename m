From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Feature request: Allow extracting revisions into directories
Date: Mon, 04 Feb 2013 19:21:58 +0100
Message-ID: <m2ip689by1.fsf@igel.home>
References: <1359901085.24730.11.camel@t520>
	<510F9907.7010107@drmicha.warpmail.net>
	<1359980045.24730.32.camel@t520>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Robert Clausecker <fuzxxl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 19:22:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2QgV-0004xe-Oh
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 19:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754359Ab3BDSWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 13:22:04 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:43325 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab3BDSWD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 13:22:03 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Z0HLv4Y4lz3hhky;
	Mon,  4 Feb 2013 19:21:59 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3Z0HLv1CZJzbbhf;
	Mon,  4 Feb 2013 19:21:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id CrE-afutsBay; Mon,  4 Feb 2013 19:20:53 +0100 (CET)
X-Auth-Info: 3kiXAovYsE2rGQ9lNZXWTH49PuBeLpLGa1ctJ1peETc=
Received: from igel.home (ppp-93-104-147-7.dynamic.mnet-online.de [93.104.147.7])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon,  4 Feb 2013 19:21:58 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 3AB7ECA2A1; Mon,  4 Feb 2013 19:21:58 +0100 (CET)
X-Yow: I've gotta GO, now!!  I wanta tell you you're a GREAT bunch of guys
 but you ought to CHANGE your UNDERWEAR more often!!
In-Reply-To: <1359980045.24730.32.camel@t520> (Robert Clausecker's message of
	"Mon, 04 Feb 2013 13:14:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215404>

Robert Clausecker <fuzxxl@gmail.com> writes:

> I have a server that hosts a bare git repository. This git repository
> contains a branch production. Whenever somebody pushes to production a
> hook automatically puts a copy of the current production branch
> into /var/www/foo. I could of course use pull for that but it just does
> not feels right. Why should I have a repository twice on the server? 

You can avoid the separate repo copy by using git new-workdir.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
