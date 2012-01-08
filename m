From: Clemens Buchacher <drizzd@aon.at>
Subject: enable push --quiet
Date: Sun,  8 Jan 2012 22:06:18 +0100
Message-ID: <1326056781-17456-1-git-send-email-drizzd@aon.at>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 22:15:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rk054-0007Mg-Ir
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 22:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754512Ab2AHVOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 16:14:39 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:46040 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754492Ab2AHVOj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 16:14:39 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id A5C9FCDF87;
	Sun,  8 Jan 2012 22:15:34 +0100 (CET)
X-Mailer: git-send-email 1.7.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188138>

Hi Junio,

This is a resend of the push --quiet bugfix "series".

[PATCH 1/3] server_supports(): parse feature list more carefully
[PATCH 2/3] fix push --quiet: add 'quiet' capability to receive-pack
[PATCH 3/3] t5541: avoid TAP test miscounting

I think it was looking good except for the TAP issue that you reported in this
email [1], which Michael "fixes" in PATCH 3/3, but which I could not reproduce
and which was never really understood.

The series is also available as branch cb/push-quiet at
http://github.com/drizzd/git .

Clemens

[1] http://mid.gmane.org/7v62l7crpg.fsf@alter.siamese.dyndns.org
