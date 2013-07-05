From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 4/5] t6006: add two more tests for the case i18n.commitEncoding is not set
Date: Thu, 04 Jul 2013 23:52:54 -0700
Message-ID: <7vobaha46x.fsf@alter.siamese.dyndns.org>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com>
	<d1e6681bea4a69d4774b09e4cb776f4cd6e6dcc9.1372939482.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 08:53:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuztI-0005ux-QN
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 08:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658Ab3GEGxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 02:53:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56955 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290Ab3GEGxG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 02:53:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D24A29061;
	Fri,  5 Jul 2013 06:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fuqX0cGDIXrMf3a6jm0U8GzZ1Gk=; b=kNkT7p
	wv4cQvVQbza08R3Fx1dBK3ksFKLHHGblMr/HtyhhXS6GS5CnEAXc+8VtmRVnQWS2
	bYnD1kOsghSmGiuBShEXhxMBmz0H6ckxd6PeXCeSimlQQnu7Q1EhYufJUAW1HUAI
	hnyF0wEwfUF0LcgU3BnmcOyEAiDndy1JLonzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=spcP35XuFO4b+2NJy7LPVaw+RFqXkgWG
	8E3dacanmAll/0AQTjxtW0KlvZ8LATL5PESpaSYhdPh51INIebapYbvu5SXHqlsh
	deVQQNuRzMzZmDyN4hI2IIvMU0olwIdvi3ha67+1pnzgAQEuzuuJrjzoG+KvKV4k
	JKndCmWD5T8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FC9D29060;
	Fri,  5 Jul 2013 06:53:06 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 455792905A;
	Fri,  5 Jul 2013 06:52:55 +0000 (UTC)
In-Reply-To: <d1e6681bea4a69d4774b09e4cb776f4cd6e6dcc9.1372939482.git.Alex.Crezoff@gmail.com>
	(Alexey Shumkin's message of "Thu, 4 Jul 2013 16:45:49 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A71BC2A-E53F-11E2-B8D8-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229627>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

> In de6029a2d7734a93a9e27b9c4471862a47dd8123 'complex-subject' test was
> changed. Revert it back,...

... "because changing it was bad for such and such reasons"?
