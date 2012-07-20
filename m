From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Fri, 20 Jul 2012 18:37:02 +0200
Message-ID: <5009892E.9010808@kdbg.org>
References: <20120719213225.GA20311@sigill.intra.peff.net> <20120719213311.GA20385@sigill.intra.peff.net> <50092993.6010203@alum.mit.edu> <20120720154403.GB2862@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Alexey Muranov <alexey.muranov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 20 18:37:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsGCX-0007v6-8s
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 18:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256Ab2GTQhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 12:37:06 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:2256 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751328Ab2GTQhF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 12:37:05 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 30AA62C4007;
	Fri, 20 Jul 2012 18:37:02 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B103419F614;
	Fri, 20 Jul 2012 18:37:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120601 Thunderbird/13.0
In-Reply-To: <20120720154403.GB2862@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201787>

Am 20.07.2012 17:44, schrieb Jeff King:
> So I think a suffix like ":d" is probably the least horrible.

Not so. It does not work on Windows :-( in the expected way. Trying to
open a file with a colon-separated suffix either opens a resource fork
on NTFS or fails with "invalid path".

-- Hannes
