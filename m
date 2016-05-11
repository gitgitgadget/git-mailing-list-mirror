From: Junio C Hamano <gitster@pobox.com>
Subject: Re: wishlist; unify behavior while cloning non-bare repos over http to be in line with ssh/local
Date: Wed, 11 May 2016 14:27:32 -0700
Message-ID: <xmqqk2j0jnej.fsf@gitster.mtv.corp.google.com>
References: <xmqqfutpoepz.fsf@gitster.mtv.corp.google.com>
	<20160510221032.GV23764@onerussian.com>
	<xmqq8tzhmuiz.fsf@gitster.mtv.corp.google.com>
	<20160511004931.GX23764@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Gurus hangout <git@vger.kernel.org>,
	Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Michael Hanke <michael.hanke@gmail.com>
To: Yaroslav Halchenko <yoh@onerussian.com>
X-From: git-owner@vger.kernel.org Wed May 11 23:27:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0bfQ-0005EU-JI
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 23:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbcEKV1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 17:27:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64579 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751669AbcEKV1f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 17:27:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8788119547;
	Wed, 11 May 2016 17:27:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YGjK/h5arJOzldrI6PD5Sbh2nl4=; b=rmyrHv
	syA4x8nsTfUCpJg2b9KiwfMake0g3G3QMZxCbKtDm1fkgHRRBIDxeXQgt+9rVbse
	X8E+eEZOmwzqLJMEFvUp8YX5WAQq06rfucEjcetHrXk3ONR3C/yXjO3vm6H9IYSm
	5werXG9chk7C46mXDnjuFBo+GhDvmWxLKtOtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CLQpoX/4wG26VWIcBGKvxmoVIJ9maV0m
	mxKShtKZVJ6S+vy7PN6hp42TS+NjIME3p/rj0jhtVqmUemXk5R8WpAdbFc84v7UU
	+PCgyO6KS36HKS9xdyQdLf+tjjtw/4dCPdVBq15SDxObJ7StLlQI25XXSchl8a+f
	478xWvkLnyE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F84619546;
	Wed, 11 May 2016 17:27:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A04E19545;
	Wed, 11 May 2016 17:27:34 -0400 (EDT)
In-Reply-To: <20160511004931.GX23764@onerussian.com> (Yaroslav Halchenko's
	message of "Tue, 10 May 2016 20:49:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2CEB3BF2-17BF-11E6-9F0E-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294366>

Yaroslav Halchenko <yoh@onerussian.com> writes:

> On Tue, 10 May 2016, Junio C Hamano wrote:
>> >> The necessary update to the client might be as simple as using
>> >> $GIVEN_URL/.git/ and attempting the request again after seeing the
>> >> probe for $GIVEN_URL/info/refs fails.
>
>> > Sure -- workarounds are possible,...
>
>> Just so that there is no misunderstanding, the above was not a
>> workaround but is an outline of an implementation of updated http
>> client shipped with Git.
>
> ah, sorry, I have indeed might have misread it.  So we are on the same
> page -- that is I saw also as the tentative implementation ;)

Good.  Now somebody who is interested in seeing that happen (when I
said "shipped with Git" above, I meant "shipped with possible future
Git") needs to find (or be) somebody to code that change ;-)

Thanks.
