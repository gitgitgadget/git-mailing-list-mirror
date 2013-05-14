From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-bzr: update old organization
Date: Tue, 14 May 2013 14:18:04 -0700
Message-ID: <7v4ne5i7lf.fsf@alter.siamese.dyndns.org>
References: <1368505227-16661-1-git-send-email-felipe.contreras@gmail.com>
	<7v1u99lb8w.fsf@alter.siamese.dyndns.org>
	<CAMP44s1rZmo3cQecGmYVMZ7KSq=z3_mfVnAK+so4QL_JfEe_uw@mail.gmail.com>
	<7v8v3hi9ix.fsf@alter.siamese.dyndns.org>
	<CAMP44s2B3bFWXZe0aL_GMXe_56MbhSZXf-65rT364nY3shYwUA@mail.gmail.com>
	<CAMP44s16VD+Rm5J=TXxQB+pKhpzHqoxBXSSwDvi0CVW2u2J=5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 23:18:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcMbu-0000fC-4d
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 23:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758555Ab3ENVSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 17:18:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42129 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758395Ab3ENVSH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 17:18:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB9B21F6C8;
	Tue, 14 May 2013 21:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7JfLH6vc9CcOd9YJl/q0YkmU91M=; b=qLMQir
	dbwQvyFPwPOq3vciZkcm11Ib+7qg3weWgSe6fBdsQ7s9AB5tD/6XmZXH/8qLMjtC
	arn0i6VDix4+jwFZMu4bTBqSsLq04tnAd8Boxlu+mrOTvoIFz1jCOOqNJJce5cgJ
	mY43X5hy4iEhpU/QqzH7VQsHUCUtrsP3g3GW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mlNga7Ep/u50wkVxWCUM0XKysboAvu5r
	9YrZqom8ONmnNPqtc+GxgWcx26aso+nvcF6sbg2A8STCNGFdv5Uh9K596xjvAd/r
	41Qa7sYlok6fppVaqRn2b4Tn81+5GDN2WO6nOfZm9mhxrbKxMt94NuIGQIVQGY3/
	FI0ALN4zZmE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B29E81F6C7;
	Tue, 14 May 2013 21:18:06 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 382B91F6C6;
	Tue, 14 May 2013 21:18:06 +0000 (UTC)
In-Reply-To: <CAMP44s16VD+Rm5J=TXxQB+pKhpzHqoxBXSSwDvi0CVW2u2J=5g@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 14 May 2013 15:57:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C4EF3EE0-BCDB-11E2-A381-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224349>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> I forgot to mention the main objective of the shared repo feature:
>
> + first/
> * first/second/foo
> * first/third/foo
> * first/fourth/foo
> * first/fifth/foo
> * first/sixth/foo
>
> Since in bazaar branches are repositories, we want to make it possible
> for remote-bzr users to create a single remote per branch as easily as
> possible (without having to duplicate huge clones).
>
> But as I said, without this patch, they wouldn't be able to use that
> feature if they cloned with v1.8.2.

So we nuke that and have them clone from scratch?  I am not saying
that is bad.  I just want us to be honest about the implications
when including it in the ReleaseNotes.
