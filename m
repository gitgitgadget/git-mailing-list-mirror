From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH 0/6] fix blame -L regression; add tests
Date: Thu, 18 Jul 2013 14:04:15 +0200
Message-ID: <87zjtk6pmo.fsf@linux-k42r.v.cablecom.net>
References: <1374096332-7891-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 14:04:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzmwl-0005YC-Nk
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 14:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758772Ab3GRMEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 08:04:31 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:60507 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757635Ab3GRMEb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 08:04:31 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jul 2013 08:04:30 EDT
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 092834D6588;
	Thu, 18 Jul 2013 14:04:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id iD-LrCmLQncp; Thu, 18 Jul 2013 14:04:15 +0200 (CEST)
Received: from linux-k42r.v.cablecom.net.ethz.ch (pctrast.inf.ethz.ch [129.132.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 9EDD94D6507;
	Thu, 18 Jul 2013 14:04:15 +0200 (CEST)
In-Reply-To: <1374096332-7891-1-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Wed, 17 Jul 2013 17:25:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230683>

Eric Sunshine <sunshine@sunshineco.com> writes:

> This series fixes a regression in "blame -L X,-N", adds blame -L tests,
> and makes minor documentation adjustments. The tests, in particular,
> were motivated by the desire to revisit and continue working on [1]
> which extends git-blame to accept multiple -L's. That topic will need to
> extend blame -L tests, of which there were essentially none.
>
> Patches [2/6] (modernize style) and [3/6] (add blame -L tests) are
> intentionally independent of the "git log -L" topic (from earlier this
> year) to which the other patches are related.  This independence should
> allow these two patches to graduate at their own pace without being tied
> to "git log -L".
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/229755/
>
> Eric Sunshine (6):
>   line-range: fix "blame -L X,-N" regression
>   t8001/t8002 (blame): modernize style
>   t8001/t8002 (blame): add blame -L tests
>   t8001/t8002 (blame): add blame -L :funcname tests
>   blame-options.txt: place each -L option variation on its own line
>   blame-options.txt: explain that -L <start> and <end> are optional

Thanks, and except for the comment I just sent out,
Acked-by: Thomas Rast <trast@inf.ethz.ch>

In case it wasn't obvious to anyone else: the tests do actually verify
that the right lines were picked, by counting how often each author is
blamed.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
