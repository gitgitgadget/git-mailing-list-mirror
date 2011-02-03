From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [FEATURE REQUEST] - extend git request-pull to send email
Date: Thu, 03 Feb 2011 15:06:53 -0800
Message-ID: <7vlj1wzpiq.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=kXJF_rYGMyh1gj49J7fh-ZxD7Bo8o_ELHb-2M@mail.gmail.com>
 <7vpqr8zpux.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 04 00:07:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl8Ga-0002u5-PB
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 00:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075Ab1BCXHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 18:07:01 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34759 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab1BCXHA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 18:07:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5EC8A414C;
	Thu,  3 Feb 2011 18:07:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=owiM5+1+QXSJat7Y3P4fJ0X+EOw=; b=CfrPbO
	O5kxOOyweU/oJ6rfZ708zJpnQ0UU9klSvt7UuDOvR9mzm7IjeoqIzavfxK7leqmF
	R58mwiTxZ4m5C7eeRuNbyIZTCYZTj4iuoQ2GiF8LE1sksrfErzbyFgEaFy4ZTdwc
	fVDOArIu5sUQQz6Py7y8gHHakVyd2UNv7IQ/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=utI5fPvB7KfN4F/2/1YVGCSn4qDaBcdq
	3v/wiWwwB8g0C2V0omMKU8jIS9VnyecBItyRi9tuwTcgheQG2/+5XSIRZVjfq4WI
	neMBtAWYwtKGkS0MQ3sXHN1fjGatZ1WSSbmB52NcyZ1qgCz4P9HUaF82XVhiFyjQ
	kXXU0hSrvws=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3C474414B;
	Thu,  3 Feb 2011 18:07:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 599C9414A; Thu,  3 Feb 2011
 18:07:50 -0500 (EST)
In-Reply-To: <7vpqr8zpux.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 03 Feb 2011 14\:59\:34 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6DC957DE-2FEA-11E0-92A4-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166007>

Junio C Hamano <gitster@pobox.com> writes:

>> What do you think?
>
> Horrible ;-).

Just a quick note.

Please take this with a huge grain of salt, considering that the comment
is coming from somebody who thinks --compose and format-patch integration
to git-send-email was also a bad idea.
