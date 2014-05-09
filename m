From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 1/2] Remove 'git archimport'
Date: Fri, 09 May 2014 10:44:11 -0700
Message-ID: <xmqqlhuazw2c.fsf@gitster.dls.corp.google.com>
References: <1399599203-13991-1-git-send-email-felipe.contreras@gmail.com>
	<1399599203-13991-2-git-send-email-felipe.contreras@gmail.com>
	<20140509055024.GB30674@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Martin Langhoff <martin@laptop.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri May 09 19:44:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WioqK-0004IP-Sk
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 19:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbaEIRoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 13:44:16 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61331 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750775AbaEIRoP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 13:44:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4E0AE1598C;
	Fri,  9 May 2014 13:44:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TbZ/KXQQjd85MuJwe9PoAutlndc=; b=mYoRpg
	LQejE8I3qr88nFoNYLV/BBJGRZX8jJOc6Bg3gGFillhgvUeFlhlrtomjKqFwQxRH
	ms19c6J52C2SIDRAM2ZPwphxEdY9aEryEXlfLE+tv33mvFYsN3b19jj/4O4VMUOd
	TlPVatcGXEJ+YrfsUOGoORiVIiUFsz8oIyxeo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m6w2JYinWsU6mlbLjyzaTDH6tcwxgagh
	4isaz77ez3P8FV1GZyt/XD09ZluvfvvYgr6mX4MMitIxQfcVK2w6wh7z5KAJxVmA
	nKMiljFXDB9/Wae1dAy7MIO5u0isluuyWLK/5sBdbybkj+IcqM+5K8VjyNlez4xX
	01AIXdDV8BI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 42F3E1598A;
	Fri,  9 May 2014 13:44:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D887415989;
	Fri,  9 May 2014 13:44:12 -0400 (EDT)
In-Reply-To: <20140509055024.GB30674@dcvr.yhbt.net> (Eric Wong's message of
	"Fri, 9 May 2014 05:50:24 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8860AC0C-D7A1-11E3-B51B-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248596>

Eric Wong <normalperson@yhbt.net> writes:

> Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> No updates since 2010, and no tests.
>
> Who benefits from this removal?  Is this causing a maintenance
> burden for Junio?

No.  See http://thread.gmane.org/gmane.comp.version-control.git/248587

>> Plus, foreign SCM tools should live out-of-tree anyway.
>
> Even if so, there ought to be a transitionary period in case there are
> any users.  We would need to warn potential users of its impending
> removal in the documentation and at runtime.

Yes.
