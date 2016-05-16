From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/17] Port branch.c to use ref-filter's printing options
Date: Mon, 16 May 2016 15:12:25 -0700
Message-ID: <xmqq4m9x1wl2.fsf@gitster.mtv.corp.google.com>
References: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 17 00:12:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Qkc-0003oh-1z
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 00:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbcEPWMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 18:12:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59660 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751456AbcEPWM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 18:12:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DB111CCDE;
	Mon, 16 May 2016 18:12:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Euu1BQqddoZ9QcHJjn9gq5t+D0k=; b=SAO84c
	8+3JLgG6dSdgLb5BSPNuHqWLfAlRWbZ232T+x3RXGh8kabWlFZtpsFT6ukduzghp
	cfcZwnv50SSnzcWQnXYG15K0FummwIKlOGgUTNIq67pNmOM868obgpy+FugoFX1b
	jj7kHAU1nNeIKdkx0vgESVVX8KHB1ABWHtJcM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hj3mGqailQRNA+zzNrhTdMaQrTLn+76q
	WRNsm/cfhEhtSuQK+ffDfjvgd1eggDvRH+9Lptce2baJ+Sqbh3WR662tPLjscDAj
	aIYBnz1R0fnu97mPN75CjujSA3i91Wsho08Y5zAj1yMiF3iXxzCnwwEK3fRdupJy
	EeFsUcQ5pd4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 85ED31CCDD;
	Mon, 16 May 2016 18:12:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 07F8D1CCDC;
	Mon, 16 May 2016 18:12:27 -0400 (EDT)
In-Reply-To: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sun, 15 May 2016 16:15:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 46B0FDC2-1BB3-11E6-8A8C-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294806>

Karthik Nayak <karthik.188@gmail.com> writes:

> This is part of unification of the commands 'git tag -l, git branch -l
> and git for-each-ref'. This ports over branch.c to use ref-filter's
> printing options.
>
> Initially posted here: $(gmane/279226). It was decided that this series
> would follow up after refactoring ref-filter parsing mechanism, which
> is now merged into master (9606218b32344c5c756f7c29349d3845ef60b80c).

9606218b?

> Changes in this version:
>
> 1. Rebased on top of f307218 (t6302: simplify non-gpg cases).

Huh?

  $ git checkout f307218
  $ git am 0001-ref-filter-implement-if.txt
  Applying: ref-filter: implement %(if), %(then), and %(else) atoms
  error: patch failed: Documentation/git-for-each-ref.txt:181
  error: Documentation/git-for-each-ref.txt: patch does not apply
  Patch failed at 0001 ref-filter: implement %(if), %(then), and %(else) atoms
  The copy of the patch that failed is found in: .git/rebase-apply/patch
  When you have resolved this problem, run "git am --continue".
  If you prefer to skip this patch, run "git am --skip" instead.
  To restore the original branch and stop patching, run "git am --abort".
