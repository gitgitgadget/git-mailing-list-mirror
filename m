From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2014, #01; Tue, 6)
Date: Tue, 06 May 2014 16:48:24 -0700
Message-ID: <xmqqha52cvuf.fsf@gitster.dls.corp.google.com>
References: <xmqqlhuecz1b.fsf@gitster.dls.corp.google.com>
	<53696d8aa12d2_747f15213089@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 01:48:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whp6E-000846-Bs
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 01:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbaEFXse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 19:48:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54683 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068AbaEFXsd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 19:48:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 43B0F15F8C;
	Tue,  6 May 2014 19:48:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lgJqhFY5DiOd/KIJLcaIzETFauY=; b=qZFdcU
	YMKmOcY/YowpHquK9cIaZ5H+5kvb3mvDzIkossRlp/3m2vuv/bFfGo3l8jvXQB6q
	2z+H6PGlq5cZqWtVM3CDWMsdQ3MBW73eepy7/4Ek3CQueDGuDw4+z2LYJLR2z/VF
	bjU/+9OpeCtnXECMS1eSCyY211N8Yv7+Dzqjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BkgowNEdeZimLUoe0TQuRn/CcpyaxmHo
	MN0c2C2/D+re5CUSUics3RLcRUuiAjQFVxgclk4sUv+Qmo3VsltTdUpxQxOGAeOZ
	aGd+RdTHUYJOodVBTkYJrakb0ZLkFFvr285GB4RVCnjqyQMKUCB9VYB0Tpd9FM8N
	ojpnSjF2HNk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3851315F8B;
	Tue,  6 May 2014 19:48:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E88F415F88;
	Tue,  6 May 2014 19:48:25 -0400 (EDT)
In-Reply-To: <53696d8aa12d2_747f15213089@nysa.notmuch> (Felipe Contreras's
	message of "Tue, 06 May 2014 18:17:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EA94370C-D578-11E3-B482-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248270>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Therefore the release notes are still lying to the users:
>
>  * "git push" via transport-helper interface (e.g. remote-hg) has
>    been updated to allow ref deletion in a way similar to the natively
>    supported transports.
>
> That is not true.

Hmph, you are right.  I somehow mislabeled the series that ends at
a7cb1276cc263446b19b43d3a7784cbc72f84e28 dealing with delete, when
the series actually is about forcing.  Will update.

> Plus this one which has been completely ignored:
>
>    completion: move out of contrib

It is not about "ignored".  It is about running out of time before
concluding the day's integration.

I can hopefully queue it on 'pu' tomorrow, and depending on the
reviews or lack of reviews, it may advance on its own pace from
there.
