From: Kalle Olavi Niemitalo <kon@iki.fi>
Subject: Re: [PATCH v2] Change octal literals to be XEmacs friendly
Date: Sat, 24 Jan 2009 03:46:11 +0200
Message-ID: <874ozp79y4.fsf@Astalo.kon.iki.fi>
References: <Pine.LNX.4.64.0901240219530.19590@linmac.oyster.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 24 02:56:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQXkt-0002Hz-28
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 02:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716AbZAXByv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 20:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753852AbZAXByu
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 20:54:50 -0500
Received: from smtp4.dnainternet.fi ([87.94.96.72]:62225 "EHLO
	smtp4.dnainternet.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654AbZAXByu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 20:54:50 -0500
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Jan 2009 20:54:50 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp4.dnainternet.fi (Postfix) with ESMTP id 0214ACC0016
	for <git@vger.kernel.org>; Sat, 24 Jan 2009 03:46:13 +0200 (EET)
X-Virus-Scanned: DNA Postiturva at dnainternet.net
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=0 tagged_above=-100 required=7 tests=[RDNS_DYNAMIC=0]
Received: from Astalo.kon.iki.fi (85-23-32-64-Rajakyla-TR1.suomi.net [85.23.32.64])
	by smtp4.dnainternet.fi (Postfix) with ESMTP
	for <git@vger.kernel.org>; Sat, 24 Jan 2009 03:46:11 +0200 (EET)
Received: from Kalle by Astalo.kon.iki.fi with local (Exim 4.52)
	id 1LQXb9-0001pi-Ep; Sat, 24 Jan 2009 03:46:11 +0200
In-Reply-To: <Pine.LNX.4.64.0901240219530.19590@linmac.oyster.ru> (Vassili
	Karpov's message of "Sat, 24 Jan 2009 02:20:52 +0300 (MSK)")
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.51 (gnu/linux)
X-Accept-Language: fi;q=1.0, en;q=0.9, sv;q=0.5, de;q=0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106945>

Vassili Karpov <av1474@comtv.ru> writes:

> #ooctal syntax on the other hand produces integers everywhere.

GNU Emacs 20.7 doesn't support #o, but neither does it include
the ewoc and log-edit libraries required by the current git.el.

It would be nice to have a comment in git.el saying which
versions of Emacs and XEmacs it is supposed to support, but I
guess people wouldn't bother testing those on every commit.
