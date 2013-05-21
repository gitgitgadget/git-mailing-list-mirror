From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Fix invalid revision error messages for 1.8.3
Date: Tue, 21 May 2013 10:57:32 -0700
Message-ID: <7vk3msnrlf.fsf@alter.siamese.dyndns.org>
References: <1369132915-25657-1-git-send-email-artagnon@gmail.com>
	<7vy5b8p9wm.fsf@alter.siamese.dyndns.org>
	<CALkWK0nXbncV4bjHLSQCu21w36vQP5E9irNhBbyXoEZ4-oqfcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 19:57:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ueqof-0001c3-4L
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 19:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237Ab3EUR5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 13:57:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43800 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755000Ab3EUR5f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 13:57:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD04D20794;
	Tue, 21 May 2013 17:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=usl9F0b17/Nz0A/vL94iSjWygQw=; b=Q/sEfp
	h0it4r0GdE+mpad4TWuIyoqX5te9NYeuRZL6o5H41KZ3ZSB42qaF3sZg1pJ/n9vP
	twxqFvjJM+zYujQPUfhDK/zSfWuMevCFMmd7KQoX0dP1hIFiLdZ2M6YB7qOfNhdP
	LwW5nM3OhsGoLueqm0P4jN8kgZ7l44dOGaLOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FwmeaLHDX8viRvnHSBO7LSFnUvVcj1Jj
	iXU4HjYKntO8vRrW7rkvG4kRhQpXNFgAS9flD5M48ZgmW4PVMmlIZZUW06HJKuV4
	wZmd6hHqAgjUmsFkSVF7qwkg+03yQU6L1FPEDG6cNp2K9rmNEEkcdXxf6UnzDNnD
	sB9OXNCdCEA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4B9220793;
	Tue, 21 May 2013 17:57:34 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 268D720790;
	Tue, 21 May 2013 17:57:34 +0000 (UTC)
In-Reply-To: <CALkWK0nXbncV4bjHLSQCu21w36vQP5E9irNhBbyXoEZ4-oqfcQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 21 May 2013 23:20:48 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA269DCA-C23F-11E2-9217-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225054>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> So, is it
> because that version was too long ago that we don't consider it a
> regression (do we backport fixes)?

The "regression fixes" pre-release -rc period is for is to make sure
to avoid unwanted/unintended behaviour changes between releases.

People have _already_ seen and lived with these issues in released
versions.  Changing it may or may not be getting it back to the
state to that of an even older release, but at that point the
differences do not matter.  It is a "fix", too late for the kind of
regression fixes we focus during _this_ -rc period, which is about
regressions between v1.8.2 and 'master'.
