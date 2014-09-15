From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff-tree --root
Date: Mon, 15 Sep 2014 10:04:10 -0700
Message-ID: <xmqqr3zc95o5.fsf@gitster.dls.corp.google.com>
References: <20140912130607.GX4075@isis.sigpipe.cz>
	<xmqq61gsbv9p.fsf@gitster.dls.corp.google.com>
	<20140913085735.GA4075@isis.sigpipe.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Roman Neuhauser <neuhauser@sigpipe.cz>
X-From: git-owner@vger.kernel.org Mon Sep 15 19:04:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTZhR-0000y4-A6
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 19:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987AbaIOREU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 13:04:20 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50758 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752896AbaIOREU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 13:04:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7346A39A9F;
	Mon, 15 Sep 2014 13:04:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3PT6Hth3U40c/lITLm4OD8HgbVk=; b=R/NwzP
	OGXULDMQWFTgBMHj+0hw6I/61nY6ADYV3WdCXz2wgzSKCVcsavj97JHHYOD/OG8T
	MuDKjH8j2ImPtBQCqFa5y2rpSdgP9Uu4vmqnYhudjB7tMUgCnxgnCtN3FbQJUdry
	uXKHVxCA5cb7uEb4HJNvWxPc2BLbAWRzH+4+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KEjI3h9uIw6OLF2BvTJ1lY50JefTUOm0
	W1oom1RQBbOtkzBcVi6L8mCc3qmY3dpZJUbwt7CiLV7lybG3abiqWtorKpEcl4kH
	61dJ4UAuH5ZHpZvVAJN15OKGH8CCpK+AKzBw2B3qjtmnHmOiIWjil2n6FNSLSm/j
	n/9YZ7Y2Jl0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6847439A9D;
	Mon, 15 Sep 2014 13:04:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DF5A739A9C;
	Mon, 15 Sep 2014 13:04:12 -0400 (EDT)
In-Reply-To: <20140913085735.GA4075@isis.sigpipe.cz> (Roman Neuhauser's
	message of "Sat, 13 Sep 2014 10:57:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 512B8DCE-3CFA-11E4-A174-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257055>

Roman Neuhauser <neuhauser@sigpipe.cz> writes:

> ... I like
> my scripts as simple as possible, so I'd like to use --root *always*.

With "--root", the command does not do anything different without
for commits that are not root commits, and it shows "everything
created from nothing" for root commits.  The option was invented to
help those who want that behaviour, so if you'd like to use it
always, then you are welcome to do so ;-)
