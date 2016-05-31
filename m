From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/6] worktree: add "unlock" command
Date: Tue, 31 May 2016 11:35:48 -0700
Message-ID: <xmqqinxu3wjf.fsf@gitster.mtv.corp.google.com>
References: <20160522104341.656-1-pclouds@gmail.com>
	<20160530104939.28407-1-pclouds@gmail.com>
	<20160530104939.28407-7-pclouds@gmail.com>
	<xmqqmvn63wra.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	rethab.ch@gmail.com, rappazzo@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 31 20:35:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7oWD-0000R9-KI
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 20:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbcEaSfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 14:35:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750997AbcEaSfw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 14:35:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 838E31FBA5;
	Tue, 31 May 2016 14:35:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3ZQiLAJN0KDXubPFWpxVD+3vIMo=; b=NfkM8b
	7fCvmPpKsOFSa12ogrsHy/5M+QgqHGkI9Im8rS5+yQamH5ORsYHcUilP+c133JVW
	3nkGO6lzF1L215JJMVbwTpj62wsme9rByS+ZaAM+giA0AR9lBhqSs3TnGXXtc3e4
	+ol3HW8IwjMDbbDW0hQo8E9v9V+aPRlhJ7NZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yUy6U0bMVvtt3A3mTAIHrw2uPjMOcPsR
	7v3TcpmI22CpEEdMkoQwlxMJkTFsNQbrPoumoUv8LxHIi+VQQkJCMaFfaNBXGNOh
	13alxPFeTp9f7b7X2KqoMwQ3fKC1YmvyKz0Q8q0rRs6KMhKIw5YzQGGg8IQ+IEyj
	034Qf0Khsgs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B3221FBA4;
	Tue, 31 May 2016 14:35:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF5DA1FBA3;
	Tue, 31 May 2016 14:35:50 -0400 (EDT)
In-Reply-To: <xmqqmvn63wra.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 31 May 2016 11:31:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 800987A4-275E-11E6-B285-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296008>

Junio C Hamano <gitster@pobox.com> writes:

> Again, this seems to be built on an unseen version.  I think I fixed
> these up (and also the "missing second colon in the doc"), but please
> double check what I push out later today.

Ah, this comes on top of 0409e0b6 (worktree: simplify prefixing
paths, 2016-05-22).  I do not necessarily agree with 7b722d9 (I
think "add, list, prune followed by lock, unlock" would be a more
sensible order), but I'll leave them as-is.

Thanks.  Queued.
