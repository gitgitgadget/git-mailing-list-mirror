From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2011, #01; Tue, 4)
Date: Wed, 05 Oct 2011 09:32:57 -0700
Message-ID: <7vty7n8kli.fsf@alter.siamese.dyndns.org>
References: <7vvcs49ofl.fsf@alter.siamese.dyndns.org>
 <4E8BFF26.5050504@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 05 18:33:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBUP5-0003Jp-Ay
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 18:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934931Ab1JEQdC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 12:33:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59551 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934476Ab1JEQdA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 12:33:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB7145C91;
	Wed,  5 Oct 2011 12:32:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xJbZQVvC066kpc8ZAKGwBE2VVFU=; b=hPmjqP
	+BRpFLHrqnRkwYv+CGDWJF9TmXznThbSXPPngHRAn7knb+1Ogcdgecu94v7dE9uz
	6TDQVBzOFmLvQclPYLFA0v9iTcuF1AQpFUimvKPGvrxJV7BppUJ38cxW7DDHb+hk
	egB1rJ/6vu8cTquDAyrR3pSXqFODP7nd0Veyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IVjo4RDvg1TQzpFAguf2t/GEDkNlSihv
	F5Jzq7GHxFnt1XFP4qZUQ0b6yXpxDW6Xqf5oowsy61HAwbbv1r4QFIkLLLa+vVBT
	L9g/1rQxzfH06tfq0Bv1mGVdNoQg9EY8XS1H8YywZwBFwb+n33x9MLzw3F7q79yr
	WXekv+cUY7g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B06DE5C90;
	Wed,  5 Oct 2011 12:32:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3073F5C8E; Wed,  5 Oct 2011
 12:32:59 -0400 (EDT)
In-Reply-To: <4E8BFF26.5050504@viscovery.net> (Johannes Sixt's message of
 "Wed, 05 Oct 2011 08:54:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AFDE01B6-EF6F-11E0-8EB9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182858>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 10/5/2011 4:12, schrieb Junio C Hamano:
>> * il/archive-err-signal (2011-10-03) 1 commit
>>  - transport: do not allow to push over git:// protocol
>
> Kindly fix up the commit message (delete the cruft) before you merge to next.

Thanks for noticing.
