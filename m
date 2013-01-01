From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Update SubmittingPatches
Date: Tue,  1 Jan 2013 15:24:52 -0800
Message-ID: <1357082695-29713-1-git-send-email-gitster@pobox.com>
Cc: Jason Holden <jason.k.holden.swdev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 02 00:25:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqBCw-0001U8-P6
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 00:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab3AAXZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 18:25:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63629 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261Ab3AAXY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 18:24:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B330DA4F4;
	Tue,  1 Jan 2013 18:24:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=VPx+ach8W4WlBgxWcQ775gwK/rc
	=; b=XklIcckgecUX+Ta7+QRfiEZWmAQfmwOd1v0CVqzFsL9LRwvV6zA6Y9heOad
	2tg5CU3qmgNht/mmlDZGfxEEdN2qMw/3Eab62lDmUEf5gCTwtxLeBHRBcRlF1QOj
	U8Lk+RYKKJKKOizl4qrdG8UKxMA5NhgHj4QCUn5C79ba/Ylo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=E60FVfp91FfDaH4vfZpOP
	tdiWnFJyFNU1e3V/9RjtGsLSP28ZlGeVi4H1ZBJ4VAakWzWWS4w3dswKe4BKAOxB
	TZ9u9qrax+Ga3CS48+wyeFA2tcED0owViQilu1opoIKgR6sKXWXbGWVb6WRG3GP0
	1COM23f89eJDCpeJT/piRI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A384DA4F3;
	Tue,  1 Jan 2013 18:24:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36055A4F1; Tue,  1 Jan 2013
 18:24:57 -0500 (EST)
X-Mailer: git-send-email 1.8.1.209.gc32ab23
X-Pobox-Relay-ID: 747F1072-546A-11E2-8425-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212470>

The main thing this series wants to do is the second one, but I
wanted to reduce the clutter in this document while at it.

Junio C Hamano (3):
  SubmittingPatches: who am I and who cares?
  SubmittingPatches: mention subsystems with dedicated repositories
  SubmittingPatches: remove overlong checklist

 Documentation/SubmittingPatches | 160 ++++++++++++++++++++--------------------
 1 file changed, 79 insertions(+), 81 deletions(-)

-- 
1.8.1.209.gc32ab23
