From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re: Teach mailinfo to ignore everything before -- >8 --
 mark
Date: Sun, 23 Aug 2009 23:58:51 -0700
Message-ID: <7v7hwtofys.fsf@alter.siamese.dyndns.org>
References: <1250999357-10827-3-git-send-email-git@tbfowler.name>
 <7vvdkfx8rl.fsf@alter.siamese.dyndns.org>
 <20090823171819.6117@nanako3.lavabit.com>
 <7v1vn2yklo.fsf@alter.siamese.dyndns.org>
 <20090824060708.6117@nanako3.lavabit.com>
 <alpine.DEB.2.00.0908231705200.29625@GWPortableVCS>
 <7v7hwurwmu.fsf@alter.siamese.dyndns.org> <20090824041608.GC3526@vidovic>
 <7vk50tq0g5.fsf@alter.siamese.dyndns.org>
 <7vmy5pojsg.fsf@alter.siamese.dyndns.org> <20090824062141.GD3526@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thell Fowler <git@tbfowler.name>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Mon Aug 24 08:59:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfTWQ-0001oc-S1
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 08:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbZHXG7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 02:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbZHXG7G
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 02:59:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37699 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbZHXG7F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 02:59:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C17F8169DE;
	Mon, 24 Aug 2009 02:59:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O6djGihPvc484pn6Gqg2swAjV18=; b=vO0Siq
	yGqHv3uigdNNcOPcxhMDUG2Z4DuAY7aAF8UNUBEn1AtlJVUm7JapjP/7prHb/wd5
	5RqnaeLFGK1ezonrE/NUPD0ckJpptnrthS31NfE3qRuociRg1//fkJjHCnQ+4VCy
	feYW8bP6HwWyi45x9dObXgkuGAXnab7b3lFPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I0xoCtzmvNRjXOqeYXW8wRRa+oBDgAGD
	2WW+C8i46/AnN+SxprulE6lSKUMCSYJEJ52Y4YV+oqSacBZY5eMnYupZtHgujpr/
	ZOeSZRVH4SJaHnkRqKWfcopZedXylhJ8+tKd1++BYKHbBBSyuqenAaaWDmQOCTg0
	jtM2O+8ITpU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 767A7169DC;
	Mon, 24 Aug 2009 02:59:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C6C9169DB; Mon, 24 Aug
 2009 02:58:53 -0400 (EDT)
In-Reply-To: <20090824062141.GD3526@vidovic> (Nicolas Sebrecht's message of
 "Mon\, 24 Aug 2009 08\:21\:41 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 99DED3F4-907B-11DE-9611-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126911>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

>> Does anybody remember what these s_hdr (vs p_hdr) buffers stand for, by
>> the way?
>
> Has been added by 87ab799234639c .

That much I know ;-), thanks anyway.

The commit does not _explain_ what they are for, what they mean, and what
these mysteriously named variables do.
