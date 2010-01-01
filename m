From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/6] run-command: optimize out useless shell calls
Date: Fri, 01 Jan 2010 11:08:22 +0100
Message-ID: <4B3DC996.1060801@kdbg.org>
References: <20091230095634.GA16349@coredump.intra.peff.net> <4B3CD74D.7020605@kdbg.org> <20091231214134.GA31399@coredump.intra.peff.net> <200912312316.47925.j6t@kdbg.org> <20100101045017.GA20769@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 01 11:15:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQeY2-0001hq-O0
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 11:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100Ab0AAKIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2010 05:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885Ab0AAKIa
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jan 2010 05:08:30 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:17481 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750802Ab0AAKI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2010 05:08:29 -0500
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 8E865CDF8D;
	Fri,  1 Jan 2010 11:08:24 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20100101045017.GA20769@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136007>

Jeff King schrieb:
> How should we proceed, then? The "DWIM with spaces" magic seems like
> something that can come later, so I am tempted to recommend taking my
> series now, fixing up msysgit as mentioned earlier (or just dropping the
> pager.c portion of my 2/6), and then implementing DWIM once Ilari's
> topic matures.

I think this procedure is fine. msysgit can resolve the conflict in 
pager.c as suggested earlier.

> We might want to hold my 5/6 and 6/6 back from master until the DWIM
> (which would make both totally safe, I think).

Would make sense, too.

-- Hannes
