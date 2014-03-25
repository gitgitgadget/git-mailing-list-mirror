From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow --pretty to be passed to git-describe.
Date: Mon, 24 Mar 2014 22:04:37 -0700
Message-ID: <7vy4zyoom2.fsf@alter.siamese.dyndns.org>
References: <1395709444-11220-1-git-send-email-tipecaml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Cyril Roelandt <tipecaml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 06:03:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSJWK-0008M7-AZ
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 06:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbaCYFDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 01:03:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52760 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876AbaCYFDW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 01:03:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 271EE67D2F;
	Tue, 25 Mar 2014 01:03:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AJtjj6KPIraeJkOcWi1tuAFy+ug=; b=VnSLhu
	YSjc0gyks0jCUu8XK1w4LzNnEq7diYMK8J1c1ngTq+WLN/pWQJNcjn08UhA6TbZh
	I44ibGvpbrkui2ZVVOUJWqVeg4KEqLLcAqTulzj8YX+KCv9MKXMce5iublQPorzj
	wc2Vtjh2LfmX88p67SThtOR0FPxeowIMy4tQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=orz+tatllqrTe1DaL6tC5masV8Gs1/iA
	SUHbuud0qZBXNq+rxft3MbCgVJCZORJqHbuRXncybaDKhtVOy+uqD6yLZcTQMzQ/
	owfLFjGVJNTnLfXfRXARh3DesXu+vOrS5FTSnYVRtN2h4hg1aGWo7yeu7+FwZ5hy
	eGglZyY4d7s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD1E167D2E;
	Tue, 25 Mar 2014 01:03:21 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 15D6167D29;
	Tue, 25 Mar 2014 01:03:20 -0400 (EDT)
In-Reply-To: <1395709444-11220-1-git-send-email-tipecaml@gmail.com> (Cyril
	Roelandt's message of "Tue, 25 Mar 2014 02:04:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: C931C508-B3DA-11E3-A456-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244904>

Cyril Roelandt <tipecaml@gmail.com> writes:

> In some cases, ony may want to find the the most recent tag that is reachable
> from a commit and have it pretty printed, using the formatting options available
> in git-log and git-show.

Sorry, but I do not understand the motivation I can read from these
three lines well enough to say that such a change makes any sense.

It somewhat sounds similar to adding a "--long" option to "git show"
so that "git show --long v1.9.0" will act as if it were running a
"git log v1.9.0".  Yes, you can add any option to tell a command to
do something that is usually considered to be a task for some other
command, but does it even make sense to do so in the first place?
