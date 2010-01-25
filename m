From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Makefile: add missing header dependency rules
Date: Sun, 24 Jan 2010 20:44:00 -0800
Message-ID: <7v3a1u6bfz.fsf@alter.siamese.dyndns.org>
References: <20100123144201.GA11903@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 05:44:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZGoB-00068o-Fx
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 05:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777Ab0AYEoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 23:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611Ab0AYEoK
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 23:44:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46820 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632Ab0AYEoI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 23:44:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 98A0F94615;
	Sun, 24 Jan 2010 23:44:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wYYWkgKvHSrU9Y8IsCEdkkq7jqs=; b=ngRpYL
	RkqYbVolg1xZ+03pb2nl+DUUDd04bHHHoJBN+QOZEoH4NsXNJwBkZmyoFiwi/cIR
	3o3GCGjgkPjTM1lhU4OvC5O44wS94xTE363Q/h0Az42uTUx8MzQyE7Vo4qES1KDb
	EhkbYLvpam/aKSt3uWbYkrPrCuBsMWCTGuXhY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ihxmjRLkcl3u1LfvzYn8Y28MREAoCc4n
	RoF3e5bmaFfsALutDcz4VKCz33xQPMqNctcPC0UQ/78NVXoifPyt3lejLnTD/OAz
	uFKbQHsVuvvNz0NJ4M/+1GlfKk/Ztzo/Dqn2rW7QJ4a7AgCokBUri9ByWSR9bWQS
	trIy2o4CKco=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E6B694614;
	Sun, 24 Jan 2010 23:44:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE1E594613; Sun, 24 Jan
 2010 23:44:01 -0500 (EST)
In-Reply-To: <20100123144201.GA11903@progeny.tock> (Jonathan Nieder's message
 of "Sat\, 23 Jan 2010 08\:42\:01 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4477DE5A-096C-11DF-BBBA-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137937>

Jonathan Nieder <jrnieder@gmail.com> writes:
> These patches are independent of the jn/makefile topic.  I sent them
> before, but I screwed up the sender so nobody received them.  Anyway,
> perhaps they could be useful.

I found all of them sensible but it seems to be based on version that is a
bit behind...
