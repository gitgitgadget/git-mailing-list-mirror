From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.0.0-rc4
Date: Wed, 21 May 2014 10:03:52 -0700
Message-ID: <xmqqegznqd1j.fsf@gitster.dls.corp.google.com>
References: <xmqqr43oq8q5.fsf@gitster.dls.corp.google.com>
	<20140521100245.GB2201@mule>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 19:04:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn9vu-0005kv-W2
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 19:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbaEURD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 13:03:59 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62267 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336AbaEURD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 13:03:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E023018A2E;
	Wed, 21 May 2014 13:03:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yT2Cq1c9jr6JGrqi7NZxKsYm5xk=; b=LbFdbY
	VFPE1R+/uekEsaIa2px7skwN5k2tSmkGo15xdcqRl70nFhksP9lEQE/+6tQWpOV6
	sO3G7UXXHbaqKBTOXyb0RYKPt2w2B0677zpYpWv6tr9L0AbOgg+NJAjsq8/6Sh/d
	1gP7BXxdO/3FIm+tYFwqcKZoGym/u4Mlm3V/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eh58AAFD9JWeSuntNRlgaP4SP+IZve51
	1U5H4b4TVq5oHLL/S+aZIQ0QMc5rhZej44dI/aNmjcJGKEq9/n/hpUn2WjwukxiI
	2P5WnfN4u4FwtANpLjdr3rGx1k6rQ1pE4m44R7DHQf9WRCeUF5+ujVS0ZG9/fYYN
	PkWNS+ywrDI=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D45A818A2D;
	Wed, 21 May 2014 13:03:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C4FD618A2B;
	Wed, 21 May 2014 13:03:53 -0400 (EDT)
In-Reply-To: <20140521100245.GB2201@mule> (Martin Erik Werner's message of
	"Wed, 21 May 2014 12:02:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E3732658-E109-11E3-BE4B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249811>

Martin Erik Werner <martinerikwerner@gmail.com> writes:

>>  * Commands that take pathspecs on the command line misbehaved when
>>    the pathspec is given as an absolute pathname (which is a
>>    practice not particularly encouraged) that points at a symbolic
>>    link in the working tree.
>>    (merge later 655ee9e mw/symlinks to maint.)
>
> In order to include the latest cleanup to this patchset:
> "setup: fix windows path buffer over-stepping"
> this should be 6127ff6 instead. Sorry if it's unneeded to note, but just
> wanted to make sure :)

Yeah, that commit is more like "fix to a not-quite-right fix" rather
than "cleanup", and is indeed sitting at the tip of mw/symlinks
topic I still hold onto, so that it can be later merged to 'maint'.
And I agree that it is necessary to merge to 6127ff6 when the topic
is merged to 'maint'.

The entries in the release notes are fed to the "ML" (stands for
"Merge Later") script found on my 'todo' branch from its standard
input to remind me of bugfix topics that need to go to 'maint', and
the process should have caught it (i.e. the topic has grown and its
tip no longer points at the named commit since the entry was
written), but somehow I missed it.

Will fix it up.  Thanks for noticing.
