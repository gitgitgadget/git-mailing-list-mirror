From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2016, #04; Tue, 14)
Date: Wed, 15 Jun 2016 11:45:44 -0700
Message-ID: <xmqq4m8u70kn.fsf@gitster.mtv.corp.google.com>
References: <xmqqtwgv77az.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BqDYrjzvaYJC1sBcqLw+5NAONE0Txo24BVS1Gz+ZmFjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 20:45:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDFp2-0001iO-Tg
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 20:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbcFOSpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 14:45:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752631AbcFOSps (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 14:45:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 11811253C6;
	Wed, 15 Jun 2016 14:45:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5hUuluSQvlIw6o3ui9yYt2gMUlE=; b=rW4Yr/
	aZY5DLJrxk+z4UwYeCIFjhklpNvTedXG3Z1lnemI5m9PfE4nUPyOnthIGiTJLCtu
	lACRMcGw0RczY1bbEZegCCwILZ5zW5YgktEWqnYk7vytshGt30HBYUZY79ITfMlG
	lyk/uUoqmq8RESSojmi7BJvfEkaGtkwqWYNz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m7LvfA9dWrMh/oS3fiAppAUJ1NnX5PjX
	OHm1VBI2Gu6lp7YZtl2bbrxwgHLhLqC+RSMfBtXDmahC/2M2CbwepOuHkH/BjDQG
	3FkvuavYlYqRNLQobNzW5JqE5DRDrVMQPto715oj8bQxuFC6G0z43kUO1aRHHpgk
	5RlkH1lKKyg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0990F253C5;
	Wed, 15 Jun 2016 14:45:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 856FF253C3;
	Wed, 15 Jun 2016 14:45:46 -0400 (EDT)
In-Reply-To: <CACsJy8BqDYrjzvaYJC1sBcqLw+5NAONE0Txo24BVS1Gz+ZmFjw@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 15 Jun 2016 17:12:41 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5F386AC8-3329-11E6-B54D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297390>

Duy Nguyen <pclouds@gmail.com> writes:

>> * nd/worktree-cleanup-post-head-protection (2016-05-24) 6 commits
>>  - worktree: simplify prefixing paths
>>  - worktree: avoid 0{40}, too many zeroes, hard to read
>>  - worktree.c: use is_dot_or_dotdot()
>>  - git-worktree.txt: keep subcommand listing in alphabetical order
>>  - worktree.c: rewrite mark_current_worktree() to avoid strbuf
>>  - completion: support git-worktree
>>  (this branch is used by nd/worktree-lock.)
>>
>>  Further preparatory clean-up for "worktree" feature.
>>
>>  Expecting a reroll.
>>  ($gmane/294136, etc.)
>
> Hmm.. I think what's in 'pu' (which is v2, $gmane/295260) is ok now.

Yes, thanks for spotting.  I should have updated the status text
when I picked up the reroll.
