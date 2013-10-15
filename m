From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] build: add default aliases
Date: Tue, 15 Oct 2013 15:34:18 -0700
Message-ID: <xmqqy55ub1ud.fsf@gitster.dls.corp.google.com>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
	<20130924045325.GD2766@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 16 00:34:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWDC6-0003bp-CT
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 00:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933626Ab3JOWeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 18:34:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55790 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933522Ab3JOWeV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 18:34:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CF6F4A273;
	Tue, 15 Oct 2013 22:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f7JW94ZRu8rVkOOr9Jb5ZWl1z6c=; b=U/HgOb
	iqtlYkI8OzAXUY7W+QSKKVxEZAOIWzczYQqECnUybAnUfEbieyGepzurP0e0Gaf1
	PPVV4b3B62d5YN18KH9/5VlG89/aeacF7B9Q4WJ1CC006fvBK6EgWGI6FGxF+aoh
	wVcxDsEJD4hHI+9aI9Kv6b7fKMsytB52Aa/44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a4+XllQDr6zE+1sDGyCaxTK5OzVZzDQd
	i9N3ictf4BLyScMBo72XhlKIARhO1fs6JDoyqjNoUVnpcFhWHR+klCjobLqMYqXW
	GEaXes4ZNkEsbXor0EjtvVYyYC6Qo4CM528eeR7OxNq3ugUogWUAzeEoWjR4epBP
	lm7ZhfxqSKE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E3FB4A272;
	Tue, 15 Oct 2013 22:34:21 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F40C4A270;
	Tue, 15 Oct 2013 22:34:20 +0000 (UTC)
In-Reply-To: <20130924045325.GD2766@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 24 Sep 2013 00:53:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EEFFD262-35E9-11E3-AC7D-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236207>

Jeff King <peff@peff.net> writes:

> It seems[1] that some
> people define "ci" as "commit -a", and some people define "st" as
> "status -s" or even "status -sb".

These option variants aside.

Just like thinking that committing must be the same as publishing,
it is a cvs/svn induced braindamage to think that "checking in" must
be the same as "committing".  The former is a sign of not
understanding the "distributed", the latter "the index".

In a world with both check-in and commit as two words usable to
denote possibly different concepts, it may make sense to say "you
check-in the current status of the working tree files into the
index, in order to make commits out of it later".
