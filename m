From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] hash-object: support --stdin-paths with --no-filters
Date: Thu, 04 Mar 2010 10:11:10 -0800
Message-ID: <7vmxyo6jpd.fsf@alter.siamese.dyndns.org>
References: <1267647023-2604-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, normalperson@yhbt.net, dpotapov@gmail.com
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 19:11:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnFWG-00058R-86
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 19:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539Ab0CDSL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 13:11:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38939 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267Ab0CDSL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 13:11:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E69979F5E0;
	Thu,  4 Mar 2010 13:11:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G4e7MUGjtUjRsBO+SHyLPw+VsrA=; b=t0COFR
	xsezyudN9xRWBUOu6b+r5fMh7At+bz+9zwh0gPO39m/WBAiTFisez6W4HfuLYBVu
	gFo3YEh4NI6F/5ffmfJzSQTEu6iOAfyFQEJ/pEVICxJr5ygoelmaXlcSUNeyA6yw
	97G6yulRsyqKtNNCDpJXxNI9Oq8yPSNSODuLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fKV9liUtCdKiu195EuiVRL+M/dQgxEeq
	Xg1Z5ujY0ny/lh+voBvsMlsBAmlVpCbZ0gJ/X9JX7QPr9F2BoghXp4UP7UP+uw9f
	R0OGtXFYGTnhzEU0Ypv3awqijN3mDkusbUuWQM0MqbjMkXat7KEV7TvElTlJUNHh
	ZRA940bAADA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A2DE59F5DE;
	Thu,  4 Mar 2010 13:11:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DA659F5D1; Thu,  4 Mar
 2010 13:11:11 -0500 (EST)
In-Reply-To: <1267647023-2604-1-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Wed\,  3 Mar 2010 21\:10\:21 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5403E092-27B9-11DF-A2BE-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141537>

Erik Faye-Lund <kusmabite@googlemail.com> writes:

> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>

This looks good to me.  I could queue this myself and ask Eric to Ack the
other two and queue them on top of it, but it probably is easier for Eric
if I said

    Acked-by: Junio C Hamano <gitster@pobox.com>

now, and ask him to queue the three-patch series including this one in his
tree, and then tell me to pull the finished result from his tree when he
is satisfied.  That way it would be easier for Eric to test and/or polish
if needed.

Eric, are you Ok with that plan?
