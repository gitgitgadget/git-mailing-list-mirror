From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] git-add--interactive.perl: Remove two unused variables
Date: Mon, 25 Jun 2012 11:12:14 +0200
Message-ID: <87txxzu55d.fsf@thomas.inf.ethz.ch>
References: <4FE7889E.2020009@gmail.com>
	<7vfw9khrrt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "Thomas \"Enki\" Badie" <thomas.badie@gmail.com>,
	<git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 11:12:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj5LK-0001KQ-OT
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 11:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760Ab2FYJMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 05:12:18 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:27214 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752136Ab2FYJMR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 05:12:17 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 25 Jun
 2012 11:12:14 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 25 Jun
 2012 11:12:14 +0200
In-Reply-To: <7vfw9khrrt.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 24 Jun 2012 22:41:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200561>

Junio C Hamano <gitster@pobox.com> writes:

> "Thomas \"Enki\" Badie" <thomas.badie@gmail.com> writes:
>
>> The patch 8f0bef6 refactors this script and leaves the `$fh' variable
>> unused in `diff_applies' and `patch_update_file'.
[...]
>  (2) the author of the problematic commit should have been Cc'ed
>      (especially when he is still an active participant on the list)
>      to give him a chance to Ack it (I'm adding Thomas for this).

Indeed, my bad.  It's easy to verify from 'git show 8f0bef6' that this
was an oversight in my patch.

Acked-by: Thomas Rast <trast@student.ethz.ch>

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
