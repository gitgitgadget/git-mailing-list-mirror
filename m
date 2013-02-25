From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util.h: Provide missing netdb.h definitions
Date: Mon, 25 Feb 2013 12:16:21 -0800
Message-ID: <7vwqtww3my.fsf@alter.siamese.dyndns.org>
References: <CAEvUa7n_EsKnKQNuyvSiZW8s_rZv4oQrFNDX9wa_JSr_REj89w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: David Michael <fedora.dm0@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 21:17:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA4Tp-0000ua-D3
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 21:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758190Ab3BYUQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 15:16:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42314 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010Ab3BYUQY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 15:16:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7513EA292;
	Mon, 25 Feb 2013 15:16:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=EMFI05
	icLxZCh7VeLqkqo9CFx/D7Zh1WmtqErtlgvm4sEEl/8ny3fjZs28s7uopTy5QDxt
	rnF+i65M4GQ/Urb9UibHQQV6nZqAC6lFi7uPy5a0NVvzQ7lZyD86jXTKyxVrM0o/
	GczjEEGu7Ui4i4JHThviBfIxGg9+lv8eBw/rw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XjMD0m2vmdlCHwqSELMG8eaum74+S0Aw
	l79k7TXGjnQxxHtZ4EKzhaCOwd0bb33j7bwybheQiKMHetbjmjqLq2TSc6WbTKUj
	9BRQs1jXuJxzZUhQtk3KebQy0+/3orS2nQoQS4Kr00RBkyb6Pz+YYGBnt6l2cdI2
	PNM/QH1ttwQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66930A291;
	Mon, 25 Feb 2013 15:16:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DED23A28F; Mon, 25 Feb 2013
 15:16:22 -0500 (EST)
In-Reply-To: <CAEvUa7n_EsKnKQNuyvSiZW8s_rZv4oQrFNDX9wa_JSr_REj89w@mail.gmail.com> (David
 Michael's message of "Mon, 25 Feb 2013 14:30:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 395CF0C4-7F88-11E2-8DA0-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217101>

Thanks.
