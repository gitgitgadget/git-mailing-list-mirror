From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2012, #10; Wed, 28)
Date: Thu, 29 Mar 2012 18:41:46 -0700
Message-ID: <7vobreq2zp.fsf@alter.siamese.dyndns.org>
References: <7vsjgss6ua.fsf@alter.siamese.dyndns.org>
 <m3fwcrarwo.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 03:42:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDQrA-0007ce-IB
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 03:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759600Ab2C3Blu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Mar 2012 21:41:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34861 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758487Ab2C3Blt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Mar 2012 21:41:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 458AF6D82;
	Thu, 29 Mar 2012 21:41:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8AuZWllC7/vm
	Jg07csJG81GdfG0=; b=v11ZSIez1eyogeTNEWGz0QXgV/wNywSlVufn/ceYDkSW
	+K4HCwAGmhLSAfBcRPyP9AsOE1KGGscn3Z1FUPV2JSw3Ui2Y+Dqxa47nytWa22/7
	pUZuXbWTjxS2IKghBthy5M53ukz2V7Ae+jYtoT8pai+2bE4NqYi+AQH1oaD66z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pZkeIY
	xcVlCNhWKDeycAWElA5Rq4qpkGfP7JHSN7JGS/Hu/WBLvOMGwnWzeLTnYjiZ2Geu
	HM1NSUcj76fwwRBFVHnGt7dHB5Yvu1AOAe1uHDwmnU0TRU2+xijzFY/97kVL6S7a
	PfDp3FCQcKuyT699GYO8hv5tEIWNPVD1yC6OE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C7A06D81;
	Thu, 29 Mar 2012 21:41:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B01366D7F; Thu, 29 Mar 2012
 21:41:47 -0400 (EDT)
In-Reply-To: <m3fwcrarwo.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Thu, 29 Mar 2012 16:51:01 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 837FF9CE-7A09-11E1-BBFA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194309>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> --------------------------------------------------
>> [Cooking]
>
>> * wk/gitweb-snapshot-use-if-modified-since (2012-03-26) 3 commits
>>  - gitweb: add If-Modified-Since handling to git_snapshot().
>>  - gitweb: refactor If-Modified-Since handling
>>  - gitweb: add `status` headers to git_feed() responses.
>>=20
>> Makes 'snapshot' request to "gitweb" honor If-Modified-Since: header=
,
>> based on the commit date.
>
> What about "[PATCH v2 0/8] gitweb: Highlight interesting parts of dif=
f"
> series by Micha=C5=82 Kiedrowicz:
>
>   Message-ID: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gm=
ail.com>
>   http://thread.gmane.org/gmane.comp.version-control.git/193804

I was waiting for the review cycle to come to a resolution.

> I have copy of them in 'gitweb/diff-hl' branch:

Thanks for collecting them. I wasn't paying much attention to the list
discussion.

Do you mean "I collected them for you to review, I do not yet vouch for
them"?  I see one of them has your Ack, but otherwise there is no Sign-=
off
by you on any of the commit, so it is unclear if your "What about" was
your way of saying "I think this round is ready, go ahead and pull." wi=
th
a rhetorical question, or a pure question "What is your opinion on this
series?"


> -- >8 --
> The following changes since commit 455cf268dbaf227bdbd5e9fbf96525452b=
cfe44f:
>
>   Git 1.7.10-rc3 (2012-03-28 11:18:42 -0700)
>
> are available in the git repository at:
>
>   git://repo.or.cz/git/jnareb-git.git gitweb/diff-hl
>
> for you to fetch changes up to 60b06478f0349729dc9a4ddeb1abf5e28986fb=
7e:
>
>   gitweb: Refinement highlightning in combined diffs (2012-03-29 21:2=
6:36 +0200)
>
> ----------------------------------------------------------------
> Micha=C5=82 Kiedrowicz (8):
>       gitweb: esc_html_hl_regions(): Don't create empty <span> elemen=
ts
>       gitweb: Pass esc_html_hl_regions() options to esc_html()
>       gitweb: Extract print_sidebyside_diff_lines()
>       gitweb: Use print_diff_chunk() for both side-by-side and inline=
 diffs
>       gitweb: Move HTML-formatting diff line back to process_diff_lin=
e()
>       gitweb: Push formatting diff lines to print_diff_chunk()
>       gitweb: Highlight interesting parts of diff
>       gitweb: Refinement highlightning in combined diffs
>
>  gitweb/gitweb.perl       |  299 +++++++++++++++++++++++++++++++++---=
----------
>  gitweb/static/gitweb.css |    8 ++
>  2 files changed, 225 insertions(+), 82 deletions(-)
