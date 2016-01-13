From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] pull: allow interactive rebase with --rebase=interactive
Date: Wed, 13 Jan 2016 09:36:50 -0800
Message-ID: <xmqqd1t5pej1.fsf@gitster.mtv.corp.google.com>
References: <cover.1452612112.git.johannes.schindelin@gmx.de>
	<cover.1452668201.git.johannes.schindelin@gmx.de>
	<2ebf99214ba600b63a39c58bcb9abb7941a7619d.1452668201.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 18:36:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJPLu-0006DN-2l
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 18:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755380AbcAMRgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 12:36:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62722 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754658AbcAMRgx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 12:36:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 522903AC90;
	Wed, 13 Jan 2016 12:36:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mRpwwyQ7RqZ12pcKkOqEpmyWtDs=; b=w6NE17
	8tmuqGd8ThIA9x2xdt0I5ud0ThDYV05SvasCDl+9RrCsWRk0AXk9/dNBQRAA/4dD
	BKgM44ACvWp0nmeOfSL4s8VRGLINvpteD1++sopdjU6F8Wb10zDa9ByfTBgJHDlp
	PLXhqYUo2qbfkzYJkehJFd42ukZL2GZFSYgs0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MyaCDyG3ydyFkw3zfqLHxk86nyLGQSyV
	tKFiRsMMyNdSul7FFUCeef/RTeyfhFRxJDFyJaFLb2UEim+niiFNU90UXAr8DJMP
	DBynaD4flfNRfYxbwkFiHlGRy+GcBLVxny09gpJAWFAoo9bo8qJUmlDzRD50fNBz
	18IzQCskqWA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4A78D3AC8F;
	Wed, 13 Jan 2016 12:36:52 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BF9973AC8E;
	Wed, 13 Jan 2016 12:36:51 -0500 (EST)
In-Reply-To: <2ebf99214ba600b63a39c58bcb9abb7941a7619d.1452668201.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 13 Jan 2016 07:57:50 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3B1845EA-BA1C-11E5-9ADA-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283952>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The way builtin pull works, this change also supports the value
> 'interactive' for the 'branch.<name>.rebase' config variable, which
> is a neat thing because users can now configure given branches for
> interactively-rebasing pulls without having to type out the complete
> `--rebase=interactive` option every time they pull.

Surely this is a better description about the "config also works and
it is a good thing" part.  What I was alluding to was actually this
you wrote in 0/3:

    A couple of years ago, I found the need to collaborate on topic
    branches that were rebased all the time, and I really needed to
    see what I was rebasing when pulling, so I introduced an
    interactively-rebasing pull.

that justifies why allowing 'pull' to invoke interactive rebase is a
good thing, which should go before all of the above five lines.

I see you have v3 already (and I read Paul's "you missed these"),
which I haven't read yet, but I expect the actual changes are good
and no longer need rerolling, so I may just insert these four lines
at the beginning of the log message while queuing, or something.

Thanks, both.
