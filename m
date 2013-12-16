From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Subtree: My Status
Date: Mon, 16 Dec 2013 11:18:14 -0800
Message-ID: <xmqq4n68ppu1.fsf@gitster.dls.corp.google.com>
References: <87d2tp9j7b.fsf@waller.obbligato.org>
	<567618909.1800335.1366615126779.JavaMail.root@openwide.fr>
	<20131212182439.GM18340@gmail.com>
	<xmqq61qtuaz7.fsf@gitster.dls.corp.google.com>
	<20131214153351.GB31739@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremy Rosen <jeremy.rosen@openwide.fr>,
	David Greene <greened@obbligato.org>, git@vger.kernel.org
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Mon Dec 16 20:18:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsdgT-0007EZ-P7
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 20:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189Ab3LPTSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 14:18:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43778 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754704Ab3LPTSS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 14:18:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39A945B6BD;
	Mon, 16 Dec 2013 14:18:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z322WgTjq/2//NM2MoYbmvV6ceQ=; b=dMS8gM
	clnEPc8PZ8WvXqfyZsBfYJfsCfwFSR96soGigdWdAb8WlMGMKBc+cKCEAjLG9bSu
	xXx7eTNlySprdHqZrqB4iDheP2DEvyvsr2lbrOrmk7ICURkrYRB7uY/+P3iLiaKt
	3f/HLKsEuFTPQX9P/nfQ6WlbfZhACgRQYv/As=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SSLjsdKv9TrybrYjgYdI5B08SRl9XxGk
	IMrzmy6jwoW+dGSebHVTdXvMYWWydpW0fbFmhtch7hXyRsgUrVg3+kdbPuMSmVEQ
	7Pmz16Kcz9iA7q3BXM64s9GzKLoQl6+do0VkPUQhn3d+0goJR2mqYEAXUvqja0Z4
	danjmCD4aJk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 276D55B6BC;
	Mon, 16 Dec 2013 14:18:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B6C25B6BB;
	Mon, 16 Dec 2013 14:18:17 -0500 (EST)
In-Reply-To: <20131214153351.GB31739@pacific.linksys.moosehall> (Adam Spiers's
	message of "Sat, 14 Dec 2013 15:33:51 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D1449604-6686-11E3-B368-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239348>

Adam Spiers <git@adamspiers.org> writes:

>> Somebody take the ownership of the area, if David Green who earlier
>> volunteered to do so and worked on it needs help reviewing, helping
>> polishing and giving thumbs-up on the patches, perhaps?
>
> I *may* be able to help a bit in the coming weeks, given that it's
> reasonably likely I'll be using git-subtree for professional reasons.
>
> However I'm not clear from the above whether you're suggesting that
> someone should take over ownership from David, or merely help him?

I'll leave that between you and David, and possibly other people who
are interested in advancing "git subtree" who may volunteer.

> And in either case, what would be your criteria and process for
> accepting patches, given that ultimately you're still in control of
> the repository?

I'd imagine for the first few rounds of patchsets I'll be picky
about styles and design, but once whoever eventually becomes the
volunteer subarea maintainer (perhaps you) demonsrates that s/he has
good enough motivation and taste to keep the codebase clean and user
experience consistent, I'd delegate more and more decision what to
include and reject to that subarea maintainer, just like any
material in the contrib/ area.
