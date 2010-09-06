From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] merge-recursive: Small code cleanup
Date: Mon, 06 Sep 2010 16:49:33 -0700
Message-ID: <7vy6besa9e.fsf@alter.siamese.dyndns.org>
References: <AANLkTimz8qSwefp137-D+vEbsf6soG51u0im9EC911_O@mail.gmail.com>
 <1283806070-22027-3-git-send-email-newren@gmail.com>
 <AANLkTiky3JL6rpo2x79dqQKKndUMa58Se_4CLpSFdj4+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, oinksocket@letterboxes.org,
	ken.schalk@intel.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 01:49:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OslRh-0004cI-Iw
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 01:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943Ab0IFXtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 19:49:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab0IFXts (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 19:49:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 96785D3572;
	Mon,  6 Sep 2010 19:49:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0utZmZDdx4fw7MycrTOelQ+3ah0=; b=RKQwtU
	4psI5MWYEaz/hqkiOM+a8eToKEhhutTMkaaOTzQy9ODiJUZYwvfxoHEhSxYM+n6Q
	EWpGQ3wlXlcQ/UyaUi0SjwWQ8yAUSRSn3Q3U7z9gztt54ErJ0SLpkH6nQ1JkICjn
	GOXf+sF8HxxmOVfQrzV1Yb6wHivm3bPng9Qus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p5oeiCNchlstUbPtAtq0pVAN3o1GVrtl
	rhrLwf31V0X4APswQDY+1jXITJ21UVpbY9vLQ0U2nTJpZgGamRSfS4paPxayBmbT
	+5PhIzKckSPtcgMFj4PygaSM01YxJi/rLz69A+3IZWwyd0Ia3d2vQoHnnXxh4UsK
	MYlzm3OpkEU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 55415D356C;
	Mon,  6 Sep 2010 19:49:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F47ED356B; Mon,  6 Sep
 2010 19:49:35 -0400 (EDT)
In-Reply-To: <AANLkTiky3JL6rpo2x79dqQKKndUMa58Se_4CLpSFdj4+@mail.gmail.com>
 (Elijah Newren's message of "Mon\, 6 Sep 2010 15\:25\:17 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6AC9934A-BA11-11DF-998A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155644>

Elijah Newren <newren@gmail.com> writes:

> Hmmm...should I have split this off from the rest of the series (its
> only relation is that it cleans up code that made it harder for me to
> find the real fix)?  If I did that, I could rebase the rest of the
> series on maint...

Good thinking.

The real polishing of this series will happen after 1.7.3 anyway, so for
now a series forking from ks/recursive-rename-add-identical (which I
expect to be in 1.7.3) is fine.

Thanks.
