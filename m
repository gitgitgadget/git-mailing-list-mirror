From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Config for git-blame flags -w, -M, and -C?
Date: Sun, 08 May 2016 11:23:21 -0700
Message-ID: <xmqqk2j4z9wm.fsf@gitster.mtv.corp.google.com>
References: <CAJzkHHf-B0FK=Ow=B49GjSWyHJ6+fdnSvyGphDrEdkCGy1TOAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Joe Lencioni <joe.lencioni@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 20:23:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azTMW-0002A7-QX
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 20:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbcEHSXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 14:23:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56372 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750872AbcEHSXY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 14:23:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 24D2817C85;
	Sun,  8 May 2016 14:23:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w8Q8lh4GmJcjdmQ/gFfbzopW5/o=; b=OjGOi7
	B862m+MZu8bmaITyAd8pW0nwn7nDkvWLu+P8Ynr3+ID40IFpZvnbciusL0kGLhNu
	TMWHLFSbk7h7M6YYLKb4fxeNR5zxNmWnlx6lXoDfQLk0N8cCkTsjNtryo/SWwO/8
	oWFiOmjwkhXVmfYdXQo8v8x5Xq4RlttiQpnG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wmBVDC5mwYqYWz8z+YCaiOXfok/ercc4
	swgOWAf1PLXv1oYvMwW5mR3fQnSUQbS0bCgZ5CRfLK0KbaOqUnSxzK6qOu3wqNGD
	i8ZQUbRa84wKKrr4MoQl+eojdGGU04P++J6B/BuIk93gY3J/dWbG2LRyYYsqjBI/
	VFViG1oWyEU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C3D417C84;
	Sun,  8 May 2016 14:23:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9BB1F17C83;
	Sun,  8 May 2016 14:23:22 -0400 (EDT)
In-Reply-To: <CAJzkHHf-B0FK=Ow=B49GjSWyHJ6+fdnSvyGphDrEdkCGy1TOAg@mail.gmail.com>
	(Joe Lencioni's message of "Sat, 7 May 2016 10:03:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F27E21C2-1549-11E6-A854-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293972>

Joe Lencioni <joe.lencioni@gmail.com> writes:

> Thoughts?

For end-user facing commands that are expected to be used by human
typing on the keyboard, I'd recommend

	git config alias.bl "blame -w -M -C"

instead.
