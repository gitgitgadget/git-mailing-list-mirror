From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: use 'read -r' to avoid backslash acting as an
 escape character
Date: Tue, 06 Jul 2010 22:25:43 -0700
Message-ID: <7vpqyz278o.fsf@alter.siamese.dyndns.org>
References: <20100706225522.GA31048@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jul 07 07:25:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWN8v-0007P6-BD
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 07:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743Ab0GGFZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 01:25:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39168 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271Ab0GGFZw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 01:25:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F06DFC23E5;
	Wed,  7 Jul 2010 01:25:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ynmGV8WFSAh5HmrqCBGR7kkZs6s=; b=g5efsO
	OlheAGwkG7XR7qkiB6JkoAVeXWCmG7dgJncaORxs4N/us9sN362oiARqBz9Yx4Kq
	ts9RJWD+fIkQZjAM6WowbdaEUqLfz/w7VDcO1M7XN7v7BbKNEQZ+dw/GfThVFPwn
	/k8fH/o2OBhNm4lmhmVeziTyqOsgUappgxzz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VKQPFKw//1ldIVlNL+SjyDtUug7f8e8Y
	LkxS7W1JJqUvQgCvJN/pbIYFRgPjgrnh3LnMlPoMDGOweDNou1Mpxrb1UEqrjg2u
	BCQD8ShfRs3W/Xe9SthnWOOkSJC4kV6KCb67HfAN6hVDPkyRtdYNBYz9oNT2Xdej
	fAh+iwxz5NE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CED6BC23E4;
	Wed,  7 Jul 2010 01:25:47 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38768C23E0; Wed,  7 Jul
 2010 01:25:45 -0400 (EDT)
In-Reply-To: <20100706225522.GA31048@genesis.frugalware.org> (Miklos Vajna's
 message of "Wed\, 7 Jul 2010 00\:55\:22 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1958AEB0-8988-11DF-A953-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150445>

Why do I feel a deja-vu for this patch?
