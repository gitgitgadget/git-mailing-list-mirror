From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/7] git-remote-mediawiki: Introduction of Git::Mediawiki.pm
Date: Tue, 02 Jul 2013 15:59:59 -0700
Message-ID: <7vobakin4g.fsf@alter.siamese.dyndns.org>
References: <1372804789-12732-1-git-send-email-benoit.person@ensimag.fr>
	<1372804789-12732-2-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Wed Jul 03 01:00:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu9YU-0000oc-BB
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 01:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755143Ab3GBXAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 19:00:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37500 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754571Ab3GBXAI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 19:00:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AD1D2D59E;
	Tue,  2 Jul 2013 23:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mDFbBWTPA9P++NgYuVLoHy8qtjs=; b=kXq7x1
	4u99OBd4lj0XjBAcXuF5ce/jrB0sNSwLsfxIRBbE/vYz+lylk1oWvjrPV90fnH9V
	j0bCPQtzhnei8IYUKVKsZy2a5uMe9KGR8kD0htFArtzr3ZkekdtYA3FpkAHTp4X+
	ROJGO3ynj8bfPp5+vwemYOyn4smEBfK0rPmkg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L5+YDhxmJjKn07u6xobOwtOZSn9AyCto
	Su4lAfg074veEFDcHscBfZn78B9AHEY9HlLR3U8RAqy+50f7affspZRrDgUG4epi
	SutzKc4gCKx1LFyle+44ie1yE8nKeqQI8aaOQTe2B4m9Lf3k0KpCFlatfDyt91c3
	wsL5v+YKfdY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8194B2D59C;
	Tue,  2 Jul 2013 23:00:06 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD07B2D591;
	Tue,  2 Jul 2013 23:00:05 +0000 (UTC)
In-Reply-To: <1372804789-12732-2-git-send-email-benoit.person@ensimag.fr>
	(benoit person's message of "Wed, 3 Jul 2013 00:39:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 22C9B9D6-E36B-11E2-8CCF-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229445>

benoit.person@ensimag.fr writes:

> From: Benoit Person <benoit.person@ensimag.fr>
>
> Currently, the mw-to-git project contains only a remote helper
> (git-remote-mediawiki.perl). To improve the user experience while
> working with mediawiki remotes, new tools, designed for such cases,
> should be created.

The above is too vague to be meaningful justification behind "should
be created".  It is unclear what "new tools" are being built, what
the success criteria to judge such "new tools" to see if they are
well "designed for such cases", etc.

Perhaps you meant something like "we would want to allow the user
to preview what he has edited locally before pushing it out".

> To achieve this goal, the project needs a way to
> share code between several scripts (remote helper, commands, ... ).

That is sensible, no matter what new things you are building, you
would want to build them on a solid foundation.
