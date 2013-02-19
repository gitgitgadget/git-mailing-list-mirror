From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] Documentation/git-commit.txt: rework the
 --cleanup section
Date: Tue, 19 Feb 2013 12:35:40 -0800
Message-ID: <7vsj4s3uub.fsf@alter.siamese.dyndns.org>
References: <7va9r06we2.fsf@alter.siamese.dyndns.org>
 <1361298570-19738-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, <jrnieder@gmail.com>,
	<ralf.thielow@gmail.com>, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 21:36:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7tv9-00017M-8V
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 21:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934106Ab3BSUfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 15:35:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47909 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933616Ab3BSUfo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 15:35:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 269E3B93B;
	Tue, 19 Feb 2013 15:35:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cVYKXotohsD692i83EDqY8ryWr0=; b=Cxp9zG
	sxyXpU1Q1oc45qxzwubbohZ8sQGab6A4UcHJKyJiEoIoO/SUrGRR3ivi1VVigfh+
	+HF0UZfUYzgtqOEyUvlstyXcSEGgfQ1VWIYPPKygVF7wcil2gut/qrc+auVL3gf2
	LHvgYqDpphD0VVs8Jky7+hm6rGwT22Lf+ZV4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LNUOP9pAgafCPm0KB1kUNZj2oRQXhiz4
	18BufcWr9qMyXURy7kDoiAlkOH1XAp9uzE9mElufW7QWcvRsyTcyj984nqIUhOm7
	62HM7sTN93K4F5c7kkRRGlFgYGm7oeeJynLeafpMY8r6T11rx5pp2CZCgWLtmMVS
	jL5bIJ+a9fA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBC04B934;
	Tue, 19 Feb 2013 15:35:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0050B924; Tue, 19 Feb 2013
 15:35:42 -0500 (EST)
In-Reply-To: <1361298570-19738-1-git-send-email-bcasey@nvidia.com> (Brandon
 Casey's message of "Tue, 19 Feb 2013 10:29:30 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE60897C-7AD3-11E2-9B20-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216659>

Brandon Casey <bcasey@nvidia.com> writes:

> From: Brandon Casey <drafnel@gmail.com>
>
> Signed-off-by: Brandon Casey <drafnel@gmail.com>
> ---
>
>
> [RESEND] I originally specified Junio's address as gitster@pobox.org.
> [RESEND] Sorry, now with the correct address.
>
> Ok, here's the updated text.  I am not set up to build the documentation,
> so I hope someone will test, but looks right to me.

Thanks for marking this as unverified.

Jonathan, thanks for the fixup.
