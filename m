From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/3] Merge renormalization, config renamed
Date: Fri, 02 Jul 2010 15:46:21 -0700
Message-ID: <7vk4pdzema.fsf@alter.siamese.dyndns.org>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 03 00:46:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUp0P-0003ir-Ii
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 00:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957Ab0GBWqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 18:46:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104Ab0GBWqf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 18:46:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B4DADC1E72;
	Fri,  2 Jul 2010 18:46:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OrzNZzpbBjailG096oYUT0ESG14=; b=SXjKzs
	f1LXBmxePBg2k+ztC0GuS5ptNh0cX3Eed7ZaZYJmyH4bI6H3Kr3V/rtN09U27S2Y
	Hgbu4ISsbRJhB0PbYw3oBXHGE1dSSvND51cmewKf3y8GXxt45zbnZatYTNAJH1X/
	2hX2qxEGKy6WXxePc0X/QNUHkhTmPzKIUbkyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uzkl751zaR0ByJ9tgcCOQ1793quPYdfw
	19xbdAqkaR/Ce8VAQIQmVhcLjjQ9jV+h/6FmvLoTDYSP/hR45IqWKRB24S7DZxjD
	c49uvsaSuSq+r9hBx6wR6jUqErjGJvJoY6DHHrOZG2eGa1jaGFU6ZCUYCp0lDHYt
	vfxqPmazB4c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 73118C1E71;
	Fri,  2 Jul 2010 18:46:28 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2B71C1E70; Fri,  2 Jul
 2010 18:46:23 -0400 (EDT)
In-Reply-To: <cover.1278093311.git.eyvind.bernhardsen@gmail.com> (Eyvind
 Bernhardsen's message of "Fri\,  2 Jul 2010 21\:20\:46 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A6CAE39A-862B-11DF-8692-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150173>

Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> writes:

> Here's a new version of the merge normalization series that renames the
> configuration variable.  Since "merge.renormalize" got the best
> response, I went with that.
>
> Junio, I hope you don't mind that I squashed your patch to introduce the
> config variable into the first patch.  It seemed a bit out-of-place as a
> separate commit.

It was meant to be squashed into the first one.  Thanks.
