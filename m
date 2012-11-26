From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix typo in remote set-head usage
Date: Mon, 26 Nov 2012 13:28:10 -0800
Message-ID: <7vfw3wqck5.fsf@alter.siamese.dyndns.org>
References: <7vwqx8rzzf.fsf@alter.siamese.dyndns.org>
 <1353957714-7330-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 22:28:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td6ED-0007nA-Au
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 22:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256Ab2KZV2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 16:28:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59261 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755263Ab2KZV2R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 16:28:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E32E194B0;
	Mon, 26 Nov 2012 16:28:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=d77/PU
	KMKc5FGMa5vyh/UcQvzqmaJQFejKeLfrwFzfQ24kp7zQQGGKaREuNVZomMjbwJML
	71Tv7zP+5k3YiqvJcJCW7qvqOfGT+/5/2Q0u2kPghMVR/W4qNp7+e1WVsXewQ/5w
	etRGD0HCEvKOHR3VyNvmDn8U1zCnNdKfe2qdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XrSvlnIQLhEBmXxjU3geAZGVCjfcGfJM
	OMV1F8FhItdOmgpwrc7L+HzxRWphh0FpkH2BOPwAfL5YveqUTRdnVq9zgnT/rtAI
	GWVh/BcAm+TTROgCo3OZXW9BK2A/wnVS+ZhBINXMhwtvq2drKubwampYfqDofq4w
	8YKXGexaK+U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7246D94AC;
	Mon, 26 Nov 2012 16:28:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76B03949C; Mon, 26 Nov 2012
 16:28:12 -0500 (EST)
In-Reply-To: <1353957714-7330-1-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Mon, 26 Nov 2012 20:21:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E84E28E-3810-11E2-AE25-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210497>

Thanks.
