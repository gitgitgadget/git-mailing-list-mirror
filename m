From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH/RFC] Fix the result of "git grep -l -C <num>"
Date: Mon, 23 Jan 2012 17:08:23 +0100
Message-ID: <8762g2ieq0.fsf@thomas.inf.ethz.ch>
References: <1327334484-35196-1-git-send-email-surfingalbert@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, <rene.scharfe@lsrfire.ath.cx>
To: Albert Yale <surfingalbert@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 23 17:08:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpMRf-0004Vn-DM
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 17:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877Ab2AWQIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 11:08:31 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:34099 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824Ab2AWQIa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 11:08:30 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 23 Jan
 2012 17:08:27 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (195.176.121.47) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 23 Jan
 2012 17:08:27 +0100
In-Reply-To: <1327334484-35196-1-git-send-email-surfingalbert@gmail.com>
	(Albert Yale's message of "Mon, 23 Jan 2012 11:01:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [195.176.121.47]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188996>

Albert Yale <surfingalbert@gmail.com> writes:

> When combining "git grep -l" with "-C <num>",
> the first result is omitted.
[...]
> For example, if the following command should output a list of 3
> different files (a.txt, b.txt, c.txt):
>
> $ git grep -l -C 1 albert_yale
> b.txt
> c.txt

Nice catch.  Can you add a test?

Is -l the only option affected?  Why isn't, for example, -L?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
