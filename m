From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] merge-recursive: options to ignore whitespace
 changes
Date: Thu, 26 Aug 2010 09:39:41 -0700
Message-ID: <7viq2xmipe.fsf@alter.siamese.dyndns.org>
References: <20100823205915.GA4484@ns1.cockos.com>
 <20100826054158.GB9708@burratino> <20100826055147.GG9708@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Justin Frankel <justin@cockos.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	eyvind.bernhardsen@gmail.com, Avery Pennarun <apenwarr@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 18:40:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OofUk-0006do-UL
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 18:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477Ab0HZQj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 12:39:57 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36762 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754444Ab0HZQj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 12:39:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A1786D02E2;
	Thu, 26 Aug 2010 12:39:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=M9uHgx7bg6URv6QUgriE5tchlE8=; b=MkxzwnnJM0tPV51ukHaqF4e
	uJRBZez9bJ1oi7/zeS/aRxKpsGRle8uX1rj9nmPa2hILDjVvwlbLdQrYWxvzsEKh
	6eTuFv7y8Eiog9LMKAXJkX/BR9MbyAtqwTj0NQHvNTBcS+CeZKxUdH97x4DQ+ieY
	98GwhIHtGOwKMiFn4ckg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=EETvYHwWizyZSNYTKWn9DZ1dUDLfdCfVBYXXfGWlWsa73V0ad
	XdfvpLa/V4uQ95rDdk8iCnI4qZkKaiEu/9NyNX2LNAWGXUXtpcpsgM9hK+3wt08I
	Mmx4fi2GmQ9kL+R0mWpZmgduk9bLbM+ma6rNNOdTd2MONSDxvfVjxsUuyU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EF7CCD02D9;
	Thu, 26 Aug 2010 12:39:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA61BD02CE; Thu, 26 Aug
 2010 12:39:42 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8B63CE48-B130-11DF-B0A6-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154544>

Jonathan Nieder <jrnieder@gmail.com> writes:

> From: Justin Frankel <justin@cockos.com>
>
> Add support for merging with ignoring line endings (specifically
> --ignore-space-at-eol) when using recursive merging.  This is
> as a strategy-option, so that you can do:

"This is as a strategy-option"?  s/is/& done/ perhaps?

Otherwise looks good to me.
