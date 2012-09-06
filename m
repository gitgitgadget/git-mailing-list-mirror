From: Junio C Hamano <gitster@pobox.com>
Subject: Re: splitted directory objects
Date: Wed, 05 Sep 2012 22:33:41 -0700
Message-ID: <7vzk534swa.fsf@alter.siamese.dyndns.org>
References: <9580e7f9-666a-44db-91cb-45b3465f5f9a@zcs>
 <3b47cf67-0c93-494a-8607-9cdc24a88f54@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Enrico Weigelt <enrico.weigelt@vnc.biz>
X-From: git-owner@vger.kernel.org Thu Sep 06 07:33:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9Uit-0008Rd-Ej
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 07:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264Ab2IFFdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 01:33:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55295 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097Ab2IFFdn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 01:33:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 768A6451C;
	Thu,  6 Sep 2012 01:33:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tIXYiupuHV4dWBVFqVoKzxD/OpY=; b=UceA0F
	PgifR35nok6H4ICk9Wrsn3Vf9lR7LOJZepsdPQ26MJjICoLvc+IX283c0FdIzDJf
	UWTQBC8m5E43ZVahqA6FXgNn9WjG7Uv0y3arRsaxaHLtLcXXM7J0OSnuzFhDOU0V
	+RFLh6GlrJlZShg1uEUzMBn/dWVv22M5146qw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZRKf5jKyd704IEE4U45wJXtq7sAVEHa5
	WjW3BfKsF1CRFw0bp0RXHAmpS7nXKlfdNHY5myrlw7k+Nq9Vagl6Yl5WRmJv2cUI
	LJq9Pbhw2mzrlpG3LhQNZACk2VJNeAubYzIAq6cKTsMp64dT+rC+EeRZJjgWVbjb
	rF06FNW/Z7c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63BAC451B;
	Thu,  6 Sep 2012 01:33:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6D49451A; Thu,  6 Sep 2012
 01:33:42 -0400 (EDT)
In-Reply-To: <3b47cf67-0c93-494a-8607-9cdc24a88f54@zcs> (Enrico Weigelt's
 message of "Thu, 06 Sep 2012 04:25:00 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6BAC1E32-F7E4-11E1-B39C-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204863>

Enrico Weigelt <enrico.weigelt@vnc.biz> writes:

> IIRC some people were working on splitted directory objects
> (eg. for putting subdirs into their own objects), some time ago.

Each directory maps to its own tree object, so a subdirectory is
stored in its own object.  It happened on April 7th, 2005, if not
earlier.
