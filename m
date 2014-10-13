From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] "-x" tracing option for tests
Date: Mon, 13 Oct 2014 11:24:42 -0700
Message-ID: <xmqqd29v4yl1.fsf@gitster.dls.corp.google.com>
References: <20141010060636.GA15057@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 13 20:24:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdkIb-0001pF-H1
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 20:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbaJMSYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 14:24:45 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63421 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753991AbaJMSYp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 14:24:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EE6014A94;
	Mon, 13 Oct 2014 14:24:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=akYpVa/jbso2e9J/VZ8w/tdeI4Y=; b=gzPFpc
	hIX2fRLHnEDfgdUO03BzEe/sPJnU8eKLDZ73fE7uGHNmyN/d59/Lb3n3VCudZ+/O
	sQpG96oux9c62kX4HHgG9AX7LywWyx8OhqijcOcfBK/HM4vf4rpngGFupAA0uVK+
	Q6O5WduZ3qCJykltb3a0Jq3M0tIsvXucjLQH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fgaaQhR4YyHq0oSByMCx1zPZSzBOZLem
	upYKNJ+kfsFk5qXfRzX+nGzduxWkfxX70asxqH6OuzYDBUgU9NO63UoLf/xjssBc
	gPwFry59gKRLvx9s0ky2Lbkh6ZCl025xlk3GJpd6Gmqe5V8DKdwvbgvWDaiWIgfv
	kr5eZDof1ng=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6688F14A93;
	Mon, 13 Oct 2014 14:24:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6B6814A92;
	Mon, 13 Oct 2014 14:24:43 -0400 (EDT)
In-Reply-To: <20141010060636.GA15057@peff.net> (Jeff King's message of "Fri,
	10 Oct 2014 02:06:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3440E7F0-5306-11E4-850F-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> These patches are pulled out of the prune-mtime series I posted
> earlier[1]. The discussion veered off and there's no reason that the two
> topics need to be part of the same series.

These look all sensible.

Is your plan to reroll the prune-mtime stuff on top of these?  The
additional safety those patches would give us is valuable and they
are pretty straight-forward---I was hoping to have them in the 2.2
release.

Thanks.
