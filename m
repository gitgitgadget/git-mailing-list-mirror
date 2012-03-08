From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [ANNOUNCE] Git 1.7.10-rc0
Date: Thu, 8 Mar 2012 11:17:50 +0100
Message-ID: <87y5rbpfap.fsf@thomas.inf.ethz.ch>
References: <7v7gyvkh84.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 11:18:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5aQ1-0001uf-32
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 11:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085Ab2CHKRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 05:17:52 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:54893 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795Ab2CHKRw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 05:17:52 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 8 Mar
 2012 11:17:50 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 8 Mar
 2012 11:17:50 +0100
In-Reply-To: <7v7gyvkh84.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 07 Mar 2012 17:35:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192550>

Junio C Hamano <gitster@pobox.com> writes:

>  * Parallel to the test suite, there is a beginning of performance
>    benchmarking framework.

I just noticed that this does not work on OS X; its 'time' does not
support the -f option.  For now I think I'm happy; it can compare
several versions of Git on Linux to detect performance improvements or
regressions.  Comparability across systems or platforms was never a main
goal.

In the long run we'll have to change it to either use 'time -p'
everywhere and parse that into shape -- at least GNU and OS X agree on
what POSIX specifies ;-) -- or just supply a small helper utility that
does the timings for us in a ready-to-use format.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
