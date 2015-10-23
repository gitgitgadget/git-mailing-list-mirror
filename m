From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make
Date: Thu, 22 Oct 2015 19:05:24 -0700
Message-ID: <xmqq37x2qqzf.fsf@gitster.mtv.corp.google.com>
References: <loom.20151016T001449-848@post.gmane.org>
	<xmqq7fmnhg4x.fsf@gitster.mtv.corp.google.com>
	<loom.20151023T013752-72@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Kannan Goundan <kannan@cakoose.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 04:05:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpRjY-0006BZ-Fh
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 04:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbbJWCF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 22:05:28 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53910 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751719AbbJWCF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 22:05:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5246825A02;
	Thu, 22 Oct 2015 22:05:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eKqZyVK+RPxeAMgXmpF/PHaR9AA=; b=fRToRG
	aWVB8CcT8tGJfYXY1mxyDdLYN1obmPSVPH2k34fCdH3prFYE5HnOW53FI+mUy0Lq
	PYTkZ9/BBhZvcEKFwy0uzbsBZP9FEejKCGMI8aJA2+XmTnS3P1c4pkYuPIyePRgW
	dtiaAU3ZEtHprhGAm+asxbAq4xdwrTSeLuV/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=obXO2IzGdSSzxDCOMILGsLkPJ2ATe3b+
	TmsxjottTwNs1FlO6OWKDbjnyyNFg9FapPZFJL08nq//jqWKfv6KeO00OyeE6Nuv
	4I7mpnBm5J/1uuGBPqf4bLXMfICqvSbygH1oWn59ejfLblxZAoWyaLgpMnRn7+oI
	/8hISSQJWZU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 497C825A01;
	Thu, 22 Oct 2015 22:05:26 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C8D4825A00;
	Thu, 22 Oct 2015 22:05:25 -0400 (EDT)
In-Reply-To: <loom.20151023T013752-72@post.gmane.org> (Kannan Goundan's
	message of "Thu, 22 Oct 2015 23:46:28 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 86983D0A-792A-11E5-A29C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280081>

Kannan Goundan <kannan@cakoose.com> writes:

> Thanks for the explanation.  I didn't realize some projects don't want to
> initialize all their submodules, but the explicit opt-in idea you described
> sounds nice.
>
> I've seen cases where people will financially "sponsor" feature development
> in open source projects.  Is there any precedent for this in the Git
> project?  Is it ok to use this mailing list to ask about such things?

We are unfortunately not set up to handle money well.  For a
background explanation, please go read [*1*], which I wrote my take
on "money" some time ago.  Note that it is an explanation and not a
justification.  It explains why we are not set up to handle money
well and what the issues around money that are troublesome for the
project are.  It does not mean to say that it is a good thing that
it is hard to buy feature with money from our project [*2*].

I do not see (and back then in the discussion I do not think anybody
saw) how we can make "We, a sponsoring company, pay this money to
the project to fund effort Y." work well.  But that of course does
not mean it is impossible to make it work--somebody with a fresh
perspective may come up a way to do so, and that would be a very
welcome development.


[Footnote/Reference]

*1* http://thread.gmane.org/gmane.comp.version-control.git/264993/focus=265215

*2* Just like my message that you are responding to was an
    explanation of the reason why we do not recurse and and
    initialize all submodules by default.
