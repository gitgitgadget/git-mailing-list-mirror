From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-push: Accept -n as a synonym for --dry-run.
Date: Sat, 12 Sep 2009 23:10:10 -0700
Message-ID: <7veiqb1ikd.fsf@alter.siamese.dyndns.org>
References: <1252800302-26560-1-git-send-email-nelhage@mit.edu>
 <7vfxar5zsi.fsf@alter.siamese.dyndns.org> <20090913034031.GO4275@mit.edu>
 <20090913035421.GP4275@mit.edu> <7vd45v2za4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nelson Elhage <nelhage@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Sep 13 08:10:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmiIF-0004WG-TZ
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 08:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbZIMGKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 02:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753459AbZIMGKU
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 02:10:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbZIMGKU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 02:10:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D9A6B4EFB5;
	Sun, 13 Sep 2009 02:10:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v3eryji9RGroBHb4+5z5n0aKuj8=; b=v8QoG5
	zTpnZhQokLLY2n9cbs/mw1mSe2xtVXN4GoiJOMmlfFiWO+tUey9uip2WWyARMfbC
	gv360j/mK+w/XUufzBu917HlmLlAZSBmM7g93nUQR/xUeBrGrldWjeTBdSb30Ln/
	7MgU4Xj0B9A8nIKDAjcTgqmIO9k/+OAjECdZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WOI+1zrZShtIkHRURlseoCjgsGbbO7RO
	IB+ScjVFpHwjMFlVxcwzq0PpcClPl0ELMs82CQWE3bw+fQsx0dxLzMDABomaWlNB
	bAXuljUTBrScJYZjFGe2tt9t36nA2utlmA+JjxKORfFqGTDEF0UqFKXJqWVfwO/u
	1+fClXjp0Bs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B9A144EFB3;
	Sun, 13 Sep 2009 02:10:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 08E114EFB2; Sun, 13 Sep 2009
 02:10:11 -0400 (EDT)
In-Reply-To: <7vd45v2za4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat\, 12 Sep 2009 22\:23\:47 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1CA2864A-A02C-11DE-AA8A-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128339>

Junio C Hamano <gitster@pobox.com> writes:

> ..., so you are not arguing against
> me at all.
> ... it is likely that we would try very
> hard to find a name that does not begin with 'n' to avoid the issue.

So what's my objection, in short?

It is just the wording "_the_ standard" that implies that anything that
uses -n to mean something other than --dry-run is _wrong_.

I didn't want to see anybody arguing against "commit -n".  It is used to
defeat pre-commit hook and has been there with us for a long time.
