From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cherry-pick: better error message when the parameter is
 a non-commit
Date: Mon, 08 Apr 2013 09:45:58 -0700
Message-ID: <7v7gkdynqx.fsf@alter.siamese.dyndns.org>
References: <20130403092704.GC21520@suse.cz> <20130408122750.GB5132@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:46:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFCq-0004Iz-7W
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757636Ab3DHQqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 12:46:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43759 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374Ab3DHQqB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 12:46:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 964811318F;
	Mon,  8 Apr 2013 16:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jNko1uLzVz43ooRXmlC+LnB7iNA=; b=eBYkhU
	+YCaAABk6LY99wSILbcQlq+6TmTcBfH5H3D3OGTPodXrfzsYv63B+FKJ+0nVBFZn
	PH6Hwb9yVVVpZPcvsNJ2dpwkyX4rjvyb2o2pWc2gsmZnWQgojZBV3DxywMn0mlkh
	Aem3/WHSHZY4qRWU1c1jz5rv0UrM1OTEX6rCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pLJPvz05QFHx79viCyG6ZRt7dmu/Mztn
	rBPPctFr6JO4T76D5Qh2aRPdGGgTaJRtZEmxHEwHJkfJXHSFJXGipLqFZXgXo3mv
	jXlhyBSr48ahC9hP9HWSzSgeBjuEG3/M6aZ3IuuhQEyYf0H9HTCwd/niE8oPyXfh
	+tM+pyxuca8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C4AB1318E;
	Mon,  8 Apr 2013 16:46:00 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 005D31318D; Mon,  8 Apr
 2013 16:45:59 +0000 (UTC)
In-Reply-To: <20130408122750.GB5132@suse.cz> (Miklos Vajna's message of "Mon,
 8 Apr 2013 14:27:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CADF48B8-A06B-11E2-A6F5-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220439>

Miklos Vajna <vmiklos@suse.cz> writes:

> On Wed, Apr 03, 2013 at 11:27:04AM +0200, Miklos Vajna <vmiklos@suse.cz> wrote:
>> When copy&paste goes wrong, and the user e.g. tries to cherry-pick a
>> blob, the error message used to be:
>> 
>> 	fatal: BUG: expected exactly one commit from walk
>> 
>> Instead, now it is:
>> 
>> 	fatal: Can't cherry-pick a blob
>> 
>> Signed-off-by: Miklos Vajna <vmiklos@suse.cz>
>> ---
>>  sequencer.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> Ping, any comment on this patch?

Nothing in particular from me.
