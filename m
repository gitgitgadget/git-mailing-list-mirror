From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] sha1_file: typofix
Date: Sun, 15 May 2011 12:16:03 -0700
Message-ID: <7vsjsfpyfg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 21:16:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLgnW-0006FU-Cy
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 21:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584Ab1EOTQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 15:16:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53324 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418Ab1EOTQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 15:16:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E5BA04A57;
	Sun, 15 May 2011 15:18:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=2
	IPdU0X39wO+bJ1KrothjhvjDyY=; b=dTRrq0qR66opIt2SBXVFoe/E4Ym4lXZeo
	F2C901z2ntU7C/78x0KhGExc+2pLAPLjCwsJVp3hN+F1Dl6wmZCKLMZmSILkoEiI
	KVdN9JaBH3Z1rX3ZlxgwAlgWqGElrbtchZLta7H+1fIG3ZK6vpTjT9K93TWVDH1M
	1D2c64t48Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Y4m
	pMWxKWKr7MpjQEDpw4l+n0pNTuZV59Yx/HQ0VXD7EGJbi1TTKkfZGZ5WYQkAzK5+
	JlCkj7qOti5y2o0c7Sk6hAUn2yeg+MHwxzum6HT5pwhSCrrRMJ5twLhZ8PxH5HhU
	kliJOgQiQlrYHJqSLgj5EWYLEjj+oM0F2EDzYOHU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D04DD4A56;
	Sun, 15 May 2011 15:18:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0D4054A55; Sun, 15 May 2011
 15:18:10 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13B39F88-7F28-11E0-9927-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173646>

The number zero is spelled "zero", not "zer0".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 889fe71..ee06d99 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1308,7 +1308,7 @@ static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size
 		/*
 		 * The above condition must be (bytes <= size), not
 		 * (bytes < size).  In other words, even though we
-		 * expect no more output and set avail_out to zer0,
+		 * expect no more output and set avail_out to zero,
 		 * the input zlib stream may have bytes that express
 		 * "this concludes the stream", and we *do* want to
 		 * eat that input.
-- 
1.7.5.1.334.gdfd07
