From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] gitweb: Add a feature for adding more branch refs
Date: Tue, 03 Dec 2013 10:51:16 -0800
Message-ID: <xmqqli01ojiz.fsf@gitster.dls.corp.google.com>
References: <1386082603-8404-1-git-send-email-krzesimir@endocode.com>
	<1386082603-8404-3-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jnareb@gmail.com, sunshine@sunshineco.com
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 19:51:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnv48-0005Yz-HD
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 19:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606Ab3LCSvU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Dec 2013 13:51:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63776 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752829Ab3LCSvU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Dec 2013 13:51:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 877EF55EA3;
	Tue,  3 Dec 2013 13:51:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VfVPi4XX1U0Q
	DiL2gUQ9gKeVwcQ=; b=inU7qggN8az5WV2hvQsfAB67b2LjrzmXd6rzCRonZ409
	it1trjE/XQsE1w24rlglqbQM5zxEi2h3MtZLjN/Y+xPDeXFT4kUN9zo07cu65Zha
	XvQvfWItivfBxqE13sC57HiU+DnfSMHS73G0xd3S8VEudWJqugWPtFonxgW0E8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=h7DYiq
	++Aw0GAT5LLdPFhsqwcNy5LQjm7BjnkKJW/YiJEk3XZAQIlhE6OVvHANGy7Yh2WS
	HRQoj13rPVGjXaedUnuK5PyEb4I9waom0lj54PBtw+ooYqCnG14b98vPhmPFlWTv
	cAY426zQnvXoAzm1SHkxOzo3KwKfqBfDOcbPY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76FA955EA2;
	Tue,  3 Dec 2013 13:51:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A852455EA1;
	Tue,  3 Dec 2013 13:51:18 -0500 (EST)
In-Reply-To: <1386082603-8404-3-git-send-email-krzesimir@endocode.com>
	(Krzesimir Nowak's message of "Tue, 3 Dec 2013 15:56:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E516785E-5C4B-11E3-B441-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238713>

Krzesimir Nowak <krzesimir@endocode.com> writes:

> Allow extra-branch-refs feature to tell gitweb to show refs from
> additional hierarchies in addition to branches in the list-of-branche=
s
> view.
>
> Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
> Reviewed-by: Junio C Hamano <gitster@pobox.com>

Please do not add "Reviewed-by:" like this; I've never reviewed this
version of the patch.

These are to be added only when you re-send, for final application,
the version as exactly reviewed, or adjusted a previous version you
got reviewed in a way that match suggestions given by reviewers.

> Reviewed-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
