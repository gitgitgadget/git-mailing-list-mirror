From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] t/README: Document the prereq functions, and 3-arg
 test_*
Date: Thu, 01 Jul 2010 09:37:36 -0700
Message-ID: <7vwrtf2m5r.fsf@alter.siamese.dyndns.org>
References: <1277997004-29504-1-git-send-email-avarab@gmail.com>
 <1277997004-29504-5-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 18:37:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUMlr-0003iD-PU
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 18:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757389Ab0GAQhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 12:37:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979Ab0GAQhp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 12:37:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0ED7AC076F;
	Thu,  1 Jul 2010 12:37:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uxv07ewKiK9n2d8+3o4wqifMNZk=; b=MpVbBC
	D2bt3kHpCa3pnIk+HHs7cYIryhx/gyvNvgkv6jfnV0lfLYtYMDjZgznzvz9T1mMf
	3bbwMW1CsMyaX7eAR0UwrT5GqjHQyLmF7jFJ7ZlUXOu0qMsml36ALXb5LuKcLfOa
	r0LzXU7rwvz86ltpXaiu+iyTocKym7smIAyok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q0wPtMV4k8pJV56kj0ERF4Gnl6OAX5uX
	NfId3MvAASeJOP682yystcEvfZjTpVwmhUw9JludJUj0AhlNgtzCgocA5sHtch7T
	Z6v2RhthSM3OqNgkWMaGXcJUauo21vvhkHLsMITf172ihUzSz2nAFrWRtaOiQFzp
	U4dkpyrLrmU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E034BC076B;
	Thu,  1 Jul 2010 12:37:40 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E2F5C0769; Thu,  1 Jul
 2010 12:37:38 -0400 (EDT)
In-Reply-To: <1277997004-29504-5-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu\,  1 Jul
 2010 15\:10\:00 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F7548D3C-852E-11DF-9EC8-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150055>

Thanks.  We should have done this one long time ago.
