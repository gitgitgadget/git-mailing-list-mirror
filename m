From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 09/18] remote-curl.c: mark file-local function static
Date: Mon, 11 Jan 2010 23:52:52 -0800
Message-ID: <1263282781-25596-10-git-send-email-gitster@pobox.com>
References: <1263282781-25596-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 08:53:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUbZS-0004h8-PH
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 08:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446Ab0ALHx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 02:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753413Ab0ALHx2
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 02:53:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41093 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303Ab0ALHx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 02:53:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D4848E898
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=JGNy
	NsO5a4S7IHLwE3//RbuKMu0=; b=sCzaIQ3gsS5jRzlPpELv4Kdx8ENU69x0B954
	uwN6f2Iro3r3GuhCk5Ot2fOIdFemNjGEo6OkEJ5AXPfmrWc/UUadnx8rrK98pk8N
	9OaUrtKvI/NQx9Wd7lvY08mpc/beE2104DA9ZIiFySTMUiE67NlMdEnJg3MyIu0m
	QMkP4Lg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=DnZTj9
	OTgME0new/l3APNCCBWRCthzmPY4DmA8TfXY7/UOnT0cf5bLDhpxjGBlo9wWxghL
	HFF3e47Qwrg9UiZrXzysMmp+TCJkGYEEpO/z3LbJgcHuAEMliYYZqD0AfUL9wsaQ
	G2O6bYUpw5RvED7qTApu2WcOrxzuYkaF/jSaU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 685478E897
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F226C8E896 for
 <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:25 -0500 (EST)
X-Mailer: git-send-email 1.6.6.280.ge295b7.dirty
In-Reply-To: <1263282781-25596-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 90C48208-FF4F-11DE-A07A-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136688>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote-curl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 28b2a31..b76dcb2 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -317,7 +317,7 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 }
 
 #ifndef NO_CURL_IOCTL
-curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
+static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
 {
 	struct rpc_state *rpc = clientp;
 
-- 
1.6.6.280.ge295b7.dirty
