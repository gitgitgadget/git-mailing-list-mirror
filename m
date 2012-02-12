From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf: move strbuf_readline_fd() from bundle.c to
 strbuf.{c,h}
Date: Sun, 12 Feb 2012 09:07:48 -0800
Message-ID: <7v39agkmjf.fsf@alter.siamese.dyndns.org>
References: <CAMocUqRutwERQ64a=9t36Za6Lm8KxpseS0NYbdGKWbixbsXeyw@mail.gmail.com>
 <CAMocUqSefruci_ueWHUH6rqz8VFcakHErq8QV_bvghWMyHKVJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Git =?utf-8?B?6YKu5Lu25YiX6KGo?= <git@vger.kernel.org>
To: =?iso-2022-jp?B?GyRCPXltbBsoQg==?= <xudifsd@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 12 18:08:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rwcu7-0004ZJ-25
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 18:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755522Ab2BLRHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 12:07:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39950 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755509Ab2BLRHx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 12:07:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A3637D8F;
	Sun, 12 Feb 2012 12:07:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HbKef7JuEihknXYL98bE5Ld/Lp8=; b=kkjC+Z
	IuubeGK5SxSUBKx0RiWOYJBRjMnEFwjhT2rQCsB8309SvdLYqVCyYf2pGFIiMoi+
	/WfpVpZeF8dAlMOt82gPmjbULYWajOZCKq6HlHf+WdsWleSNZ04ZZtB/m9WyPiay
	XoItHuxtbPAdTPaRtd+mOUIwAihP3yvbltebU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PUHZIvP6hxt6dpB5hAO7H++NgI6He9Z6
	oAZkDz8BbBTzPcCFtb7a+v9ygXVK6h4tMruFbnv+sqr58HQvuUGX0rJulxqzQjFt
	9mUT8uR4L+2VuXcEiAa2s7b4R2L2lW+gKqBumeH4ndKeATx8ETNk0bMvxlfZryej
	qhqYUpBCcPA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40FD47D8E;
	Sun, 12 Feb 2012 12:07:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C950F7D8C; Sun, 12 Feb 2012
 12:07:51 -0500 (EST)
In-Reply-To: <CAMocUqSefruci_ueWHUH6rqz8VFcakHErq8QV_bvghWMyHKVJg@mail.gmail.com>
 (=?iso-2022-jp?B?IhskQj15bWwbKEIiJ3M=?= message of "Sun, 12 Feb 2012 20:25:15
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 18DEF5CA-559C-11E1-BF78-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190581>

徐迪 <xudifsd@gmail.com> writes:

> Shouldn't I supposed to receive any information about this patch?

Not necessarily X-<.

Things can get lost in the noise, and sending a reminder message like you
just did, after waiting for a few to several days, is considered a good
practice.

> Has it accepted or not?

Anything and everything being considered for inclusion is reachable from
the tip of the 'next' branch; other patches that might turn out to be of
value, or ones that at least deserve more sets of eyeballs, are only in
the 'pu' branch.

> If not what wrong with this patch?

That is not a valid question to ask.

We do not apply a patch merely because it is _not wrong_.  It must be
clear why it is a good thing for the project to apply the patch.

Your patch in question is barely a day old and I didn't have a chance to
look at it, and I do not think other volunteer reviewers did, either, so
I don't know if it is wrong or it has merit yet.
