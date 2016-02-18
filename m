From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2016, #05; Wed, 17)
Date: Thu, 18 Feb 2016 09:51:42 -0800
Message-ID: <xmqqegc9hpox.fsf@gitster.mtv.corp.google.com>
References: <xmqqio1nge5b.fsf@gitster.mtv.corp.google.com>
	<20160217232556.GA26077@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 18 18:51:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWSk6-0003rX-SV
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 18:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426632AbcBRRvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 12:51:51 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52566 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423633AbcBRRvu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 12:51:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B1B045567;
	Thu, 18 Feb 2016 12:51:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EI3eJYwoh668d4IXZZ0uDWD1eus=; b=xtD+tB
	DsgYZKLDwxs9mS70A+rID6RmyukTm8VOzD2ojqb25GEtLTBOgmlc5CKthTNBxWOR
	GQdxwTB/D5s9a0v+uqyjhxoQ62klgXnWbGyvKRgy7AEJdPoY8k5hUDgxGYIzXKar
	1324WHqEp0C0SOcIQjyf2ONApqNdO9urgiXQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ka3snRlzEa3vqWvJh2vMps7/MXr93rF4
	i4UVtY9JLc35jy7q/4Lxa485+xldCH9+RPO/VvBNdgpE6d9boN93WhzkDfqljuSE
	FPopIdIXKJv4mEN7Oim6DXo0Rn49fb02hQkhFSVoioqHSi+t7eUiu5UUTzlItJoy
	Nl4fFMnWZ0Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 11D0145566;
	Thu, 18 Feb 2016 12:51:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8747A45565;
	Thu, 18 Feb 2016 12:51:43 -0500 (EST)
In-Reply-To: <20160217232556.GA26077@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 17 Feb 2016 18:25:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 458145DC-D668-11E5-A4C8-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286611>

Jeff King <peff@peff.net> writes:

> On Wed, Feb 17, 2016 at 02:34:08PM -0800, Junio C Hamano wrote:
>
>> * jk/tighten-alloc (2016-02-15) 18 commits
>> ...
> Please hold off a bit; I have a re-roll coming for this one.
>
>> * nd/dwim-wildcards-as-pathspecs (2016-02-10) 3 commits
>> ...
> Even if we drop it, I think the first two patches are an improvement.

Thanks.
