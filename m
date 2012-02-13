From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 0/5] verify refs early
Date: Mon, 13 Feb 2012 21:17:10 +0100
Message-ID: <1329164235-29955-1-git-send-email-drizzd@aon.at>
References: <7vhazobto3.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 21:26:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx2Tf-0002oB-LR
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 21:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757998Ab2BMUZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 15:25:41 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:36733 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757923Ab2BMUZk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 15:25:40 -0500
Received: from localhost (p5B22E0DA.dip.t-dialin.net [91.34.224.218])
	by bsmtp.bon.at (Postfix) with ESMTP id 5478F130053;
	Mon, 13 Feb 2012 21:25:37 +0100 (CET)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <7vhazobto3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190661>

Hi Junio,

This series centers around "[PATCH 3/5] git push: verify refs early",
which implements your suggestions in reply to my "[PATCH] optionally
deny all pushes". I am not pursuing the deny config option further,
because as you noted, it is of course made redundant by a simple
pre-receive hook.

[PATCH 1/5] git rev-list: fix invalid typecast

I consider this one a fairly important bugfix. Although I was unable to
determine under which circumstances the bug takes effect, rev-list
probably takes a performance hit when it does.

[PATCH 2/5] do not override receive-pack errors
[PATCH 3/5] git push: verify refs early

Note that [PATCH 3/5] makes an extension to the transfer protocol.

[PATCH 4/5] t5541: use configured port number

A mostly unrelated bugfix.

[PATCH 5/5] push/fetch/clone --no-progress suppresses progress

A totally unrelated change. However, this conflicts textually
(lexically?) with [PATCH 3/5], and therefore I am including it here.

Clemens
