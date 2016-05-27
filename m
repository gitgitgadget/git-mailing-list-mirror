From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: add --chmod=+x / --chmod=-x options
Date: Thu, 26 May 2016 23:36:05 -0700
Message-ID: <xmqqoa7sroru.fsf@gitster.mtv.corp.google.com>
References: <20160525020609.GA20123@zoidberg>
	<xmqqh9dm37xk.fsf@gitster.mtv.corp.google.com>
	<20160527044112.GA31742@zoidberg>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Edward Thomson <ethomson@edwardthomson.com>
X-From: git-owner@vger.kernel.org Fri May 27 08:36:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6BNW-0002R2-MV
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 08:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796AbcE0GgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 02:36:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754397AbcE0GgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 02:36:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BFFDC1BA88;
	Fri, 27 May 2016 02:36:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5oCdNUDN2C02oTI2FKY8akMCTG0=; b=XLNqcL
	m5zqz9LMLalxeYBQGeVee221qe6D9Yukh8QnDyEgDvV39J9I7i1T8Ddh9jYZv73k
	qirV+Jvs3x3g159orhkDncIOx8G6+09YKQnSDyN8lFZwqA6emqtR4apbKK55N+PX
	XqbAYXtwj0Us5f7Dz0JBGPYDazQkenEAOslhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yb7nqu15vPEDhrzbmdO4ao9FZUZSZFsR
	rPyVDXNwIW3B2/1X2JUPXqCq/6RFq44d2pfiCcN7IIOtjqscwGTOq1sOiARTGukV
	MPpI4We0hS2K4uDuC1XoFa3RNC3R+FwnveTw+REppgkLXT+FrD+blHXVnAv/f4L/
	+B0SqprLjXg=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B8A121BA87;
	Fri, 27 May 2016 02:36:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 412431BA85;
	Fri, 27 May 2016 02:36:07 -0400 (EDT)
In-Reply-To: <20160527044112.GA31742@zoidberg> (Edward Thomson's message of
	"Thu, 26 May 2016 23:41:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4AE36572-23D5-11E6-80C9-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295738>

Edward Thomson <ethomson@edwardthomson.com> writes:

> However I do not think that this is a common enough action that it needs
> to be made automatic such that when I `git add foo.rb` it is
> automatically made executable.  I think that the reduced complexity of
> having a single mechanism to control executability (that being the
> execute mode in the index or a tree) is preferable to a gitattributes
> based mechanism, at least until somebody else makes a cogent argument
> that the gitattributes approach would be helpful for them.  :)

It wasn't a "having to specify it every time sucks; you must do this
way instead" at all.  I was just gauging if it would be a viable idea
for a follow-up series to complement your patch.

Thanks.
