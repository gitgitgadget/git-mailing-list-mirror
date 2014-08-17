From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.1.0
Date: Sun, 17 Aug 2014 12:25:42 -0700
Message-ID: <xmqqy4umyl3d.fsf@gitster.dls.corp.google.com>
References: <xmqqd2c1z7zu.fsf@gitster.dls.corp.google.com>
	<53F0B7DD.7000605@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Aug 17 21:26:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJ66O-0001wg-Og
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 21:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbaHQTZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 15:25:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58081 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368AbaHQTZw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 15:25:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 88F5B30AC0;
	Sun, 17 Aug 2014 15:25:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fdZboo+XjJGoI7vPsLUdZqdxCZA=; b=bTjHHc
	hi4Za9cFF7HU1chEsQYb3uhWPKOoT0+5xlnKYyR1PmCl+H8dpmUAmMEl8rZj2Yea
	oYm7pqGoeTQw+89eV8U6mq+VrksYP/5sdheC35L4si6+jXSX1SyTDjWixUUyjA6J
	yf0EdS1AOqsx2213Y6pgC6rZ6EhFkfCEzK+zM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mDhwFZLsDQWFfMDQ3u0dssMmOW1mwg6I
	oZnbXg+H7eGLLIrXpjRTbFz7h0CUtaQW3OscbFI7g5ju3eE2fecy/2JwWfjzuX93
	LVO/S+ngKiqVoKCgxxZV2K4JT950VEM1K1D283hFqiHurC4pLRw7bojXGgFMNEav
	Jg+K6wtEcTk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 806A230ABF;
	Sun, 17 Aug 2014 15:25:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3D94C30AA9;
	Sun, 17 Aug 2014 15:25:44 -0400 (EDT)
In-Reply-To: <53F0B7DD.7000605@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Sun, 17 Aug 2014 15:10:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 486BE534-2644-11E4-9AE7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255374>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Are you going to tag and push v2.1.0 to the documentation repos?

I forgot to do the documentation build (which used to be triggered
from post-receive hook at k.org and never had the risk of anybody
forgetting, but it is all manual now---progress X-<) yesterday.  It
is pushed out now.

Thanks.

This is a tangent, but I probahbly should start talking with k.org
folks about arranging to keep the preformatted individual manual
pages (not the tarball that your messages is about) up-to-date.  The
last time I checked, their file-upload procedure these days are
geared towards the use case to upload a handful of tarballs and I
haven't found a way that is not too cumbersome to update a directory
tree with hundreds of individual files.

For now, https://git-htmldocs.googlecode.com/git/git.html would do,
but I'd prefer to have at least two sites to publish to, and k.org
is the natural "other" candidate.
