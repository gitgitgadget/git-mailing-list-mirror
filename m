From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: rename work-tree tests to *work-tree*
Date: Sat, 20 Feb 2016 13:42:38 -0800
Message-ID: <xmqqfuwn9hyp.fsf@gitster.mtv.corp.google.com>
References: <2e74b7a8e3dd27ccd225b5278500f8a3e029d245.1455985042.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Feb 20 22:42:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXFIc-0003UK-6f
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 22:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759491AbcBTVmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 16:42:42 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54832 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752643AbcBTVml (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 16:42:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4F0B943384;
	Sat, 20 Feb 2016 16:42:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P1ltL0URWKN3tpGGjZE0Hy5XZ3Q=; b=aTfuSc
	5LLEmQgroTscJN3ZR+c35Fts4/NtIbxBuRC5Ke4NWtTGPuQ2wObEXJDqEsZyJr2o
	aEm/FNkZ7MLLST/w7bPbdcd9PvrbxWqRR1Qr5K9KkzPS1iLlDw2J8Br6Qjl4As7/
	Mrl0u7YurG6WNeNR8hzxArYV9EHhLIRRyzyYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vdZBkFZ3Mcug60qAquU8rV643WtJubOq
	AOPkrUkx3cEa7KZpw/aRq3G324GDifxeiN8tcjSpz7sjMpKBVvhgJWabK4m7GjRI
	qtNMq6FEuWJ+ssBLt8kDTvv4r7TTh96C1cyOGxVyrhjp0zFYmsTC1gFg7YlwGP6E
	cS+RpTVhQKg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 478E143383;
	Sat, 20 Feb 2016 16:42:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 839AE43380;
	Sat, 20 Feb 2016 16:42:40 -0500 (EST)
In-Reply-To: <2e74b7a8e3dd27ccd225b5278500f8a3e029d245.1455985042.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Sat, 20 Feb 2016 17:18:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DDBC4852-D81A-11E5-9A1F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286790>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> "Work tree" or "working tree" is the name of a checked out tree,
> "worktree" the name of the command which manages several working trees.
> The naming of tests mixes these two, currently:
>
> $ls t/*worktree*
> ...
> Rename t1501, t1509 and t7409 to make it clear on first glance that they
> test work tree related behavior, rather than the worktree command.
>
> t2104, t7011 and t7012 are about the "skip-worktree" flag so that their
> name should remain unchanged.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> Just some housekeeping. Not super necessary, but should make it easier to find
> the right test to amend, for example.

That is rather unfortunate.  Most of them predate the "worktree"
subcommand, I think, and having to rename them merely because a
subcommand with a confusing name appeared sound somewhat backwards.
