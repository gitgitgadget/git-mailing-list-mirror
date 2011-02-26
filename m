From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 64/73] gettextize: git-describe basic messages
Date: Sat, 26 Feb 2011 02:03:15 -0800
Message-ID: <7vwrkn6rks.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <1298418152-27789-65-git-send-email-avarab@gmail.com>
 <201102261055.58539.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 26 11:03:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtGzs-00059Z-DP
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 11:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767Ab1BZKD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 05:03:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54918 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738Ab1BZKD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 05:03:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 56E5A2B0C;
	Sat, 26 Feb 2011 05:04:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wrQiX9v8j21ChS51GOuhLmj3s/o=; b=Kp79YO
	wasE47QYDY1en818gDK8PS2uhphHhBP6baMWm17p1K2Uv6DYpxlR16haRjUcZ/9e
	WqkVxQckKsdEBYLEXiGzYeYHxlHZBzJX0L4RCajlW6cHeF2CJ2CxyBAn6lCNBVyx
	N2jp7Qt9MaE2ycWvazVEVhfzZpB5/LG8XEc54=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LPJ2AdWy3Wq+Pftmo29LnerfmMDVEHuA
	SimDNKEey2LqA2OOycOd8YdlrELp3niC3yS8Zpc+9dkZpn3IbkDFfz6NZSffljbC
	5IorUDXzry4H5psGYnKdJd/BD23zpe7OVqV7GMdbaYMyw2sg53hWo8aP8l0zR4su
	9PTsrUL8spg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2570A2B0B;
	Sat, 26 Feb 2011 05:04:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DC7D62B0A; Sat, 26 Feb 2011
 05:04:33 -0500 (EST)
In-Reply-To: <201102261055.58539.jnareb@gmail.com> (Jakub Narebski's message
 of "Sat\, 26 Feb 2011 10\:55\:55 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D2A2D2DC-418F-11E0-8766-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167967>

Jakub Narebski <jnareb@gmail.com> writes:

> Don't we need to use order notation to be able to change order of those
> two parameters, i.e. use
>
>   +                       warning(_("tag '%1$s' is really '%2$s' here"), n->tag->tag, n->path);

Yes, translators to languages that want to swap orders would need to know
about the placeholder notation; the canonical C locale messages you see in
these patches do not have to have them, though.
