From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Use 'First Paragraph' instead of 'First
 Line'.
Date: Thu, 13 Sep 2012 14:30:48 -0700
Message-ID: <7vmx0t625z.fsf@alter.siamese.dyndns.org>
References: <5051D4A0.4060608@codeweavers.com>
 <7vehm593v8.fsf@alter.siamese.dyndns.org> <505248C3.7000803@codeweavers.com>
 <7vwqzx62vv.fsf@alter.siamese.dyndns.org> <50524E23.2040507@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeremy White <jwhite@codeweavers.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 23:31:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCH00-000817-Rc
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 23:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245Ab2IMVaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 17:30:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42327 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752264Ab2IMVav (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 17:30:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EE368939;
	Thu, 13 Sep 2012 17:30:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TQt/uhJVKf437GjXOaFayDDSVUc=; b=BhZ9HG
	1mzjyi0WRuisEMxDCS2enJQVSzndIYBIzw3dYGj7RaXhV3AyDbtLNItttTHRPrE4
	IBVHsxyhaMHBsF2GLjMe0Iw5LIcNgp04Em5t0MLJDYZPQTBJJcEggXco3TxnbXgm
	rc5/jNUekjIxo3vF/7djHWpOM0E6P4IXgEMS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QWklX+7K5/J8DFGZ22mYiJv2oOEnSjOI
	Dop3lBgE8AGmnFvIfqlyS6mqJA32VY/XGvDAyHUOx31Nq8YAJCToKf4V1Zyi9sRq
	bQkePCMfWRxf+2Gzl5XKcLkXdhIFWnu1eSAygojjI0FhY84yhtbHDexZ6BTCik0v
	ti29o1PpcLY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C75F8938;
	Thu, 13 Sep 2012 17:30:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C85AE8936; Thu, 13 Sep 2012
 17:30:49 -0400 (EDT)
In-Reply-To: <50524E23.2040507@codeweavers.com> (Jeremy White's message of
 "Thu, 13 Sep 2012 16:20:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 49B024F2-FDEA-11E1-BBB2-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205432>

Jeremy White <jwhite@codeweavers.com> writes:

>>> I did not substantially alter this. The emphasis of this section
>>> is on the broader show-branch output, and belaboring the subject would
>>> be distracting and unnecessary imho.
>> 
>> Yeah, but if that is the focus of this part of the documentation,
>> wouldn't a patch to update "the first line" with something more
>> generic like "title of the commit" be more appropriate?
>
> See my patch; I went with 'first part'.  That, I think, does not
> mislead (the goal of my change), but also does not distract from
> the main point of the section (detailing the various bits of
> git show-branch).

For that kind of casual wording, we have used "title" on this list
for quite a long time, I think.  So I'd rather see a change that
just says "title" (if we are making such a change to the
documentation, that is).  This is not a very strong preference,
though.
