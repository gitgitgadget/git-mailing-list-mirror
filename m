From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Wed, 17 Apr 2013 08:11:21 -0700
Message-ID: <7vhaj5gpk6.fsf@alter.siamese.dyndns.org>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
 <20130417084901.GA7632@blizzard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lukas Fleischer <git@cryptocrack.de>
X-From: git-owner@vger.kernel.org Wed Apr 17 17:11:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USU1D-0003Zz-My
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 17:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966660Ab3DQPL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 11:11:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37005 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966551Ab3DQPLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 11:11:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 912CA177F6;
	Wed, 17 Apr 2013 15:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cQm8XRlL6IPZRVl3RmoissPV+ig=; b=xbEx9X
	A2j8m+3GHGezFlB4/XHpWyGAdxC+m+V8Lx9PKqn1Z+Yv5l5oyrb0lMmmSmnIxihp
	PViLjqoqLc1FgQpP6gcUvhrbcGDE1RZqeYM2OPKZS8r6wTA/0SgUdLZ1BT1Lqckh
	tVyy+HGJO29lTRDU98skxLqF9+sdiPQfbAUtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=On6V+2nxfaZn8mLyo9L+b4wViN2H4LdG
	sKielOm9/EsjyQ5Jqv/6DvmdAcZotOy7giLNrbsCgqN4vFbVjs+YyC3j7laxr6f4
	QJPUh6l/xDAyuqY6zqqkjy/Jx7g5WHt3JbTSWW0KJi4x48oSYqGwa5FopvSuMczM
	Jfn6Y+PDEC4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88B57177F5;
	Wed, 17 Apr 2013 15:11:24 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 138A5177F4; Wed, 17 Apr
 2013 15:11:23 +0000 (UTC)
In-Reply-To: <20130417084901.GA7632@blizzard> (Lukas Fleischer's message of
 "Wed, 17 Apr 2013 10:49:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 117A291C-A771-11E2-AEB5-CC48E7F0ECB6-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221543>

Lukas Fleischer <git@cryptocrack.de> writes:

> Not sure if you care but the commit messages of these are all wrong now
> that you squashed your API fix into the first commit. They all refer to
> read_blob_data_from_index_path()...

Ouch; thanks for noticing.
