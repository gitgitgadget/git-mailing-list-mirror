From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] all: new command used for multi-repo operations
Date: Tue, 22 Jan 2013 16:13:59 -0800
Message-ID: <7vk3r4lprs.fsf@alter.siamese.dyndns.org>
References: <1358889019-4554-1-git-send-email-hjemli@gmail.com>
 <7vmww0nahd.fsf@alter.siamese.dyndns.org>
 <CAFXTnz62H24G9Zp5EgG47MyNdDz0KddX2n34G_1-RV_yP-ELkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 01:14:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txnz0-0000dq-4X
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 01:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301Ab3AWAOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 19:14:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59203 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013Ab3AWAOC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 19:14:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94F6DB368;
	Tue, 22 Jan 2013 19:14:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PEkK4s4KH3gG8VIe7O1sj7ThFVo=; b=JPNcxV
	rIox+XfJ9PTsO6/p9I8ori7G5YhxtkiauGtkGvZzlbn+zzcWFeFDsjW9Xr9MvJUw
	P8tdjxg+cIOhJXPQ9pxkesfRLe9XWusbnjuKCkFF2pZsRveueVKzde7nCByREZ9T
	Lpig3pcQEiSepNFZE5xWip5AIcyiRlTpcMnhs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FgE+OHEl2HD4JGCzH+FsoRuNGjogRtCp
	KePU4GeXwyBEGnzzf7sHsJkvJF7gvQ3nn7Bj8ntG6RfC2/egebWL1i0T4LGi3geX
	4NUVxStIL9blfuZ2kEpRVKaWeO/1kNpe7WKo9Kb2LMUzv5cmJSBP7THNzpbaROuj
	HE9z7ABd8vA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89A2EB367;
	Tue, 22 Jan 2013 19:14:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C31BB366; Tue, 22 Jan 2013
 19:14:00 -0500 (EST)
In-Reply-To: <CAFXTnz62H24G9Zp5EgG47MyNdDz0KddX2n34G_1-RV_yP-ELkA@mail.gmail.com> (Lars
 Hjemli's message of "Wed, 23 Jan 2013 00:35:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C9D47EF8-64F1-11E2-B852-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214265>

Lars Hjemli <hjemli@gmail.com> writes:

> In principle I agree with your reasoning on this, but in practice I
> fail to see what other kind of things `git all` could naturally refer
> to.

For example, the designers of 'for-each-ref' could have called it
"git all", as it is to iterate over all refs.
