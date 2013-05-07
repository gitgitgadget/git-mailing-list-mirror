From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] t7900: Demonstrate failure to expand "$remote/$branch" according to refspecs
Date: Mon, 06 May 2013 18:30:08 -0700
Message-ID: <7v61yvpof3.fsf@alter.siamese.dyndns.org>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<1367711749-8812-4-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue May 07 03:30:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZWjT-0000ea-2X
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 03:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759Ab3EGBaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 21:30:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60254 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932461Ab3EGBaL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 21:30:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1BEF124ED;
	Tue,  7 May 2013 01:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GQxILKALDC2lBpf+IGQzag6WWi4=; b=Yy1zMw
	laNE4tQGT1/zlcvojAs4AJcni4LgnZJIGtWsyxdtGyRt5j6culrZMWToBJQ7zfuU
	aFMghEuVytLZHhyGBfoS+qavJ0TylNPX31zcArZ1q7vRqUdFGkTmwkwFuLZC2ayu
	8ivSe4xC2O6cCgDrYsIT+f7RuIqywkAGENcYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H/9VCgdi9nmTvjkQP9I6zMRkVCLA0lSu
	x4fCUzTjgrBggRNk1YqEHkz/oI4juu0SejuCb+LVrl4bRU9m/HIlFae6RvQ/Zoq1
	rczHUBV7v47oVclobfRB6WfqmJQwN/ktOCeqBz88uki0Wh0B+dIwx5d2/T/l30qS
	uGH+5iwBFws=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C69F9124EC;
	Tue,  7 May 2013 01:30:10 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40DF1124E9;
	Tue,  7 May 2013 01:30:10 +0000 (UTC)
In-Reply-To: <1367711749-8812-4-git-send-email-johan@herland.net> (Johan
	Herland's message of "Sun, 5 May 2013 01:55:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A8416AC4-B6B5-11E2-A854-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223517>

Johan Herland <johan@herland.net> writes:

> This test verifies that the following expressions all evaluate to the
> full refname "refs/remotes/origin/heads/master":

As I've aleady said, I am not convinced that local refname
resolution should pay attention to refspec mapping, so I won't look
at this step.
