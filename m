From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH for-maint] apply: gitdiff_verify_name(): accept "/dev/null\r"
Date: Wed, 24 Sep 2014 10:55:05 -0700
Message-ID: <xmqqfvfghpja.fsf@gitster.dls.corp.google.com>
References: <1411434583-27692-1-git-send-email-lersek@redhat.com>
	<xmqq1tr2jhg2.fsf@gitster.dls.corp.google.com>
	<5421CAA6.3040107@redhat.com>
	<xmqqsijihzrb.fsf@gitster.dls.corp.google.com>
	<5421D8C4.2080009@redhat.com>
	<xmqqfvfihy7i.fsf@gitster.dls.corp.google.com>
	<5421DCE3.9090500@redhat.com>
	<xmqqoau6gguz.fsf@gitster.dls.corp.google.com>
	<5422BF6E.60603@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jordan.l.justen@intel.com,
	matt.fleming@intel.com
To: Laszlo Ersek <lersek@redhat.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 19:55:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWqmc-00076b-6S
	for gcvg-git-2@plane.gmane.org; Wed, 24 Sep 2014 19:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbaIXRzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2014 13:55:11 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53609 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716AbaIXRzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2014 13:55:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AEA253BA35;
	Wed, 24 Sep 2014 13:55:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GR7B6oWC+dUuosFKOIjhurS3k4U=; b=ZEznyM
	TJ0fX2WSvWy3xC28v7BcVC/d7pgqGwhmt11nsE1eITsYb3Hg+2o533ygCTn4ShZP
	Wmc/EHZNmk2I/tLz/VcnOd44pw3XICiheYzBpv42r2nVu6osurpSITue90Yua31Y
	Xhl1g0a4BN21VUn/tGzMknC1krfedAZ94lrpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ttQ0x5zhx0OfRQhcyR8X5gVcSLiP4N0h
	mDzN4CxVZiRLRnrGCPTdAFBtgbz+NQ1QQLX7Ida18ic95OUV9GSGqqGFVtUHTRS3
	cb6z57qYzpX21afaXNG5y2wQ+r2Wji5vFKtdZZXk+HH/SAK4VIb0MUYhAk7H63Ee
	n1ICgVf3OBo=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 92C6D3BA32;
	Wed, 24 Sep 2014 13:55:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 53C8C3BA31;
	Wed, 24 Sep 2014 13:55:07 -0400 (EDT)
In-Reply-To: <5422BF6E.60603@redhat.com> (Laszlo Ersek's message of "Wed, 24
	Sep 2014 14:56:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EB78AB08-4413-11E4-904F-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257462>

Laszlo Ersek <lersek@redhat.com> writes:

> Thank you for taking the time to describe this. It does look like the
> by-the-book solution.
>
> Obviously, I can't implement it myself -- first, I have no experience
> with the git codebase, ...

Oh, I wasn't expecting that anyway ;-).

The reason I outlined a possible approach was to ask you to sanity
check the envisioned outcome (i.e. "if somebody made effort to
implement it, would the end result help your workflow?") and to give
hints to contributors who are looking for things to work on ;-)

> If someone finds the time to implement and document this feature, a
> small part of the community will be very grateful. (Not much of a
> compensation for a corner case like this, admittedly.)

Thanks.
