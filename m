From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation: Update 'linux-2.6.git' -> 'linux.git'
Date: Wed, 19 Jun 2013 14:37:47 -0700
Message-ID: <7vppvhye6s.fsf@alter.siamese.dyndns.org>
References: <7vtxku112r.fsf@alter.siamese.dyndns.org>
	<20130619194709.GQ15550@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Wed Jun 19 23:38:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpQ4t-0000wf-3Q
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 23:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860Ab3FSViA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 17:38:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61406 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964790Ab3FSVhu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 17:37:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E15129244;
	Wed, 19 Jun 2013 21:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bY4hEoPI5+aWRL3CKWUSshr43Xo=; b=vr/VWi
	X0dUDK0CG9eNySdJbI5jMK0Ws8sqV1WwYxVzUO11tGJ0EmHBnZPjhkXfr06nv1DZ
	iVlySqWS+G/7fDS8Qi+oozDIJGHK8nmsxt5cvVc8DGaD2CW4Jqlp3dsJiAoQhXQP
	9UR0ZRjyf+nVWoChd5qo/PQtTmlnktfhB9qYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MCWjGWNkg8uCSCNXJFz11Q1Bzf4oFzGm
	rfKX+QwnhDQhQX1CRURgPKyRF8Ts5qorIQ8JXyltYWJplNhO+T/JvnxovqsrENE3
	fUyukp2rocDh/gnwIdSrhNz9c1fL/m3nTLWYzoqZRRms0Rb+DuK6gh6txujAjE5f
	wVrmbSAjMic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84C8C29243;
	Wed, 19 Jun 2013 21:37:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F219129242;
	Wed, 19 Jun 2013 21:37:48 +0000 (UTC)
In-Reply-To: <20130619194709.GQ15550@odin.tremily.us> (W. Trevor King's
	message of "Wed, 19 Jun 2013 15:47:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7CC8ED6E-D928-11E2-8E17-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228425>

"W. Trevor King" <wking@tremily.us> writes:

> I think any doc rewrites should be outside the scope of this patch,
> which should just replace references to linux-2.6.git with linux.git
> (as it does).  

OK.

> Should the size updates from 2/2 (user-manual: Update download size
> for Git and the kernel) go into the reroll, or have they been picked
> up in a separate branch?

I think 2/2 is fine.  Here is what I'll queue.

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index e831cc2..1cbf5af 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -57,10 +57,10 @@ download a copy of an existing repository.  If you don't already have a
 project in mind, here are some interesting examples:
 
 ------------------------------------------------
-	# Git itself (approx. 10MB download):
+	# Git itself (approx. 40MB download):
 $ git clone git://git.kernel.org/pub/scm/git/git.git
-	# the Linux kernel (approx. 150MB download):
-$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
+	# the Linux kernel (approx. 640MB download):
+$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 ------------------------------------------------
 
 The initial clone may be time-consuming for a large project, but you
