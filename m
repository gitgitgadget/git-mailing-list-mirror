From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v2 1/3] Move the user-facing test library to test-lib-functions.sh
Date: Fri, 17 Feb 2012 10:00:07 +0100
Message-ID: <8762f5rg14.fsf@thomas.inf.ethz.ch>
References: <cover.1329428159.git.trast@student.ethz.ch>
	<d5127b0051d354fc0c02666b972b853d1736d09c.1329428159.git.trast@student.ethz.ch>
	<7v7gzmxw78.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 10:00:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyJfx-00007C-SC
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 10:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174Ab2BQJAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 04:00:15 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:27181 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150Ab2BQJAO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 04:00:14 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 17 Feb
 2012 10:00:09 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 17 Feb
 2012 10:00:08 +0100
In-Reply-To: <7v7gzmxw78.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 16 Feb 2012 14:14:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190941>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> This just moves all the user-facing functions to a separate file and
>> sources that instead.
>>
>> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
>> ---
>>  t/test-lib-functions.sh |  835 +++++++++++++++++++++++++++++++++++++++++++++++
>>  t/test-lib.sh           |  552 +-------------------------------
>>  2 files changed, 840 insertions(+), 547 deletions(-)
>>  create mode 100644 t/test-lib-functions.sh
>
> I would have expected from the log description that the number of deleted
> lines would be about the same as the number of added lines, and the
> difference would primarily come from the addition of "include" aka "dot"
> ". ./test-lib-functions.sh" that becomes necessary in t/test-lib.sh, some
> boilerplate material at the beginning of the new file e.g. "#!/bin/sh",
> and copying (not moving) the same Copyright block to the new file.
>
> But 835-552 = 283 feels way way more than that.  What else is going on?

Hum, you're right.  I checked with blame -C -C that I introduced no new
lines, but I must accidentally have duplicated parts of it during
conflict resolution.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
