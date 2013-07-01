From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: repo.or.cz being not well???
Date: Tue, 02 Jul 2013 00:25:16 +0200
Message-ID: <87li5pncj7.fsf@igel.home>
References: <7vli5q9ba2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: admin@repo.or.cz, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 00:25:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtmXP-00083M-4t
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 00:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754901Ab3GAWZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 18:25:31 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:56722 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218Ab3GAWZa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 18:25:30 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3bkjnr6MkBz3hhZZ;
	Tue,  2 Jul 2013 00:25:17 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3bkjnn6Gn9zbbfN;
	Tue,  2 Jul 2013 00:25:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 38Kn1jEHwZTW; Tue,  2 Jul 2013 00:25:16 +0200 (CEST)
X-Auth-Info: iiSD0puxuCkKovvrBjpN43mrJ/WBq2p9R9H2LmHhG1E=
Received: from igel.home (ppp-88-217-123-246.dynamic.mnet-online.de [88.217.123.246])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Tue,  2 Jul 2013 00:25:16 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 80548E4AB9; Tue,  2 Jul 2013 00:25:16 +0200 (CEST)
X-Yow: It's the land of DONNY AND MARIE as promised in TV GUIDE!
In-Reply-To: <7vli5q9ba2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 01 Jul 2013 15:16:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229344>

Junio C Hamano <gitster@pobox.com> writes:

> Has something changed recently at repo.or.cz, accepting pushes over
> ssh, in the past few days?  I am getting this:
>
>     $ git push -n -v repo.or.cz:srv/git/alt-git.git/
>     403 forbidden
>     fatal: Could not read from remote repository.

Seems like repo is being more picky about the exact path.  Have you
tried leaving off the trailing slash?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
