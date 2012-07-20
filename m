From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Fri, 20 Jul 2012 18:32:38 +0200
Message-ID: <50098826.4010409@kdbg.org>
References: <20120719213225.GA20311@sigill.intra.peff.net> <20120719213311.GA20385@sigill.intra.peff.net> <50092993.6010203@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Alexey Muranov <alexey.muranov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jul 20 18:32:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsG8H-0001Mf-5w
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 18:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216Ab2GTQco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 12:32:44 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:60918 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750925Ab2GTQcn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 12:32:43 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7C5F6130047;
	Fri, 20 Jul 2012 18:32:39 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 8B3F719F614;
	Fri, 20 Jul 2012 18:32:38 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120601 Thunderbird/13.0
In-Reply-To: <50092993.6010203@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201786>

Am 20.07.2012 11:49, schrieb Michael Haggerty:
> Other possibilities (according to git-check-ref-format(1)):
> 
>     refs/.heads/.a/.b/c
>     refs/heads./a./b./c (problematic on some Windows filesystems?)

Yes. Probably all filesystems.

>     refs/heads../a../b../c

Same here.

>     refs/heads~dir/a~dir/b~dir/c (or some other suffix)
>     refs/heads..a..b..c (not recommended because it flattens directory
> hierarchy)

-- Hannes
