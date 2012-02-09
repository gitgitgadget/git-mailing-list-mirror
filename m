From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix build problems related to profile-directed
 optimization
Date: Wed, 08 Feb 2012 20:03:29 -0800
Message-ID: <7vty30y7ou.fsf@alter.siamese.dyndns.org>
References: <20120206055750.GA6615@thunk.org>
 <1328508017-7277-1-git-send-email-tytso@mit.edu>
 <20120208185319.GB9397@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 09 05:03:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvLEd-0004Ug-MX
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 05:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758023Ab2BIEDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 23:03:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33562 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757839Ab2BIEDb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 23:03:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BA677094;
	Wed,  8 Feb 2012 23:03:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YSWVqGkslw5kSCsQDNE8n9tl/1A=; b=CiK3uk
	+o5iApTE653BkJTm+/kS2vewIxa6j8Lph9I9WkozNjfm8lfOpF0B9Ak6hhCgBPNj
	NoGzHqi/QCnX1jjd1akdzTPRTHXb262QhjCZ8TBVyiifq4oZIOU+5MdRj7XY39tj
	K8vjSB5tYmvvcF2eqAZuD/5HvsxrQ8ZcKbty4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=me1QxdHpdHKKtehll/V/RgPbUENzfcQg
	IuQ9ZIVYXHNPHibF/y9lOd/T/IuJVmilujlzfqZWdFd53zee2IJ7vpWaf9KzCftS
	n6Ma9R1d4XS4WGWSDsqmE2ayiwsP/V4JXMMxE/o+JvxyFJkPnMxjayCOL9Q/JpXq
	f4Yq9Np3uRA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1302D7093;
	Wed,  8 Feb 2012 23:03:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8831E7092; Wed,  8 Feb 2012
 23:03:30 -0500 (EST)
In-Reply-To: <20120208185319.GB9397@thunk.org> (Ted Ts'o's message of "Wed, 8
 Feb 2012 13:53:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06EE521E-52D3-11E1-A6A5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190269>

Ted Ts'o <tytso@mit.edu> writes:

> Junio, any comments on my most recent spin of this patch?  Any changes
> you'd like to see?

Nothing from me; all looked good.

Let's cook it in 'next' for a few days to give developers a chance to play
with it and merge down to 'master'.

Thanks.
