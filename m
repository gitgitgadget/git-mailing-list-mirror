From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Warning about conflict markers - undocumented 'diff --check' feature & suggestion
Date: Tue, 29 Mar 2016 11:23:42 -0700
Message-ID: <xmqqvb45xhw1.fsf@gitster.mtv.corp.google.com>
References: <CALgdb5JuoYpHAPxTY2cHdbkcPUjKtsWQ_DY5rBrw-YKCwj2yvw@mail.gmail.com>
	<xmqqd1qe1a2i.fsf@gitster.mtv.corp.google.com>
	<CALgdb5+E7_CT2e9WFBd9GhiFuc_B7+bpC9tjDfR+-QiTGeoP+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ori Avtalion <ori@avtalion.name>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:23:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akyJ0-0002M5-On
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 20:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757484AbcC2SXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 14:23:52 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59836 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757460AbcC2SXu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 14:23:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B90AD50F27;
	Tue, 29 Mar 2016 14:23:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UrlFdMwME6MBKgwKNQOPwJxWfdw=; b=tmpfx1
	b1JLATP3RQ7mDXRjLzZRddkp2z7ayL0yhVWnKa0mBBaQIHPCVkT/zHxCC99oi5Bc
	Sdr0hVute27m9V8ng0amc65lB7WxvgPsPseMClbFKRjwYEowcPN+ChTj9rLk0MML
	Fp0tggwyjqSUcs3ERH2c+7b3WZIiCndlP+xU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GkmspKEnIjzQ2lgO1Cv8GQei3ZOiHFPs
	VeWG6gxNeseXjJJA7ta/ObM6VWc45jnbRxCuf5Pz0PKGfSKyzc+IOB+sHEdNncRh
	Aqk/0Zt/qYWy9JqSdnps0wY0FnRi26uwFxiNPCbCMRTj72OTyURR1ZHjEmz7BZMo
	a7cS8cc2D4U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B0BEA50F26;
	Tue, 29 Mar 2016 14:23:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2E10650F25;
	Tue, 29 Mar 2016 14:23:44 -0400 (EDT)
In-Reply-To: <CALgdb5+E7_CT2e9WFBd9GhiFuc_B7+bpC9tjDfR+-QiTGeoP+A@mail.gmail.com>
	(Ori Avtalion's message of "Tue, 29 Mar 2016 14:19:47 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5ED04578-F5DB-11E5-A801-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290155>

Ori Avtalion <ori@avtalion.name> writes:

> If my change introduces a few words that exceed asciidoc's ~72-char line width,
> should I reformat the entire paragraph? (thus making it had to identify what
> changed exactly)

You should try to minimize the damage, but shouldn't go overboard ;-)

> Any thoughts on adding similar functionality to "git add"?

I am not sure what "similar functionality" you are imagining.

"git add" does not show any changes, it just does what it was told
to do.  If the user is unsure, s/he should make it the habit to
check what s/he is doing with "git diff".
