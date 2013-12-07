From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v3 13/21] pack-objects: implement bitmap writing
Date: Sat, 07 Dec 2013 17:32:43 +0100
Message-ID: <87d2l8k4es.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
References: <20131114124157.GA23784@sigill.intra.peff.net>
	<20131114124544.GM10757@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Vicent =?utf-8?Q?Mart=C3=AD?= <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 07 17:33:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpKoP-0000bG-Qs
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 17:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755264Ab3LGQc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 11:32:58 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:52241 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755193Ab3LGQc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 11:32:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id A35524D6510;
	Sat,  7 Dec 2013 17:32:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0_YN_jX96R6s; Sat,  7 Dec 2013 17:32:44 +0100 (CET)
Received: from linux-1gf2.Speedport_W723_V_Typ_A_1_00_098.thomasrast.ch (84-73-190-173.dclient.hispeed.ch [84.73.190.173])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 561894D64C4;
	Sat,  7 Dec 2013 17:32:44 +0100 (CET)
In-Reply-To: <20131114124544.GM10757@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Nov 2013 07:45:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238999>

Reviewed-by: Thomas Rast <tr@thomasrast.ch>

You could fix this:

> +pack.writebitmaps::
> +	When true, git will write a bitmap index when packing all
> +	objects to disk (e.g., as when `git repack -a` is run).  This
                               ^^

Doesn't sound right in my ears.  Remove the "as"?

> +	index can speed up the "counting objects" phase of subsequent
> +	packs created for clones and fetches, at the cost of some disk
> +	space and extra time spent on the initial repack.  Defaults to
> +	false.

-- 
Thomas Rast
tr@thomasrast.ch
