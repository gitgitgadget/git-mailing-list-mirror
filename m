From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-shortlog(1): document behaviour of zero-width wrap
Date: Wed, 09 Jan 2013 14:09:19 -0800
Message-ID: <7v62363t68.fsf@alter.siamese.dyndns.org>
References: <20130109201645.GB4574@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jan 09 23:09:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt3qA-00020q-OC
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 23:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757445Ab3AIWJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 17:09:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34995 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755352Ab3AIWJW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 17:09:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8685CBA5D;
	Wed,  9 Jan 2013 17:09:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=FQKPXE
	cQLeaH8b8mK7JkU2Iz5As2qqZitoc+QsmtShCWt2mrb0I+5MIJtD8KQ7wBiB5Tqx
	miBJG3qvjK2k5qujl2XpIUL+je9WXUapsSX47jJtj6Gx5V0EWdoJes52PgrfboPZ
	+LAbE5nSSZnVAIUNLLcoDocOOQoC4GlT66aZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QbuQYJy6drzhNg7ZSq0A+YmYvvROd3or
	Yx6Kmn1l+iXURe2Jtaz5lem6wC0NlyDVwCx7xqx4qyTBTz9EzyW1DgHCPwAbXB8U
	Dysw5My+ygth0PB8WjNB0ISiWUVHnHM0Fil+6xgSbunSQAH1secDPWlX5IPXQC5g
	RA4mGw9foSM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C16FBA5C;
	Wed,  9 Jan 2013 17:09:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EBABBBA59; Wed,  9 Jan 2013
 17:09:20 -0500 (EST)
In-Reply-To: <20130109201645.GB4574@serenity.lan> (John Keeping's message of
 "Wed, 9 Jan 2013 20:16:45 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37FB630E-5AA9-11E2-9042-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213109>

Thanks.
