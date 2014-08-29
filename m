From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] git-compat-util.h: Add missing semicolon after struct itimerval
Date: Fri, 29 Aug 2014 12:07:49 -0700
Message-ID: <xmqqlhq75d2y.fsf@gitster.dls.corp.google.com>
References: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com>
	<1409330916.18778.17.camel@jekeller-desk1.amr.corp.intel.com>
	<5400CC7C.4010706@Maxsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	"Keller\, Jacob E" <jacob.e.keller@intel.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jonas 'Sortie' Termansen <Sortie@Maxsi.org>
X-From: git-owner@vger.kernel.org Fri Aug 29 21:08:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNRWn-000872-Bk
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 21:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194AbaH2TIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 15:08:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63397 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753115AbaH2TH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 15:07:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4F2C534CB9;
	Fri, 29 Aug 2014 15:07:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iazoKVS4EoA3i4i+t8/Wipjhvcg=; b=Axagxy
	aHCORdRNnRq/B9INzwdKm65hdAM9GfLrc3me62NHkdG8LyFU7910SFgIUn1l7xcH
	3HOhfjGLybXzRfKW9ao+o8OXOiXY7VTCC8wVLRD/aZeEFHP7ZNZUiqnAIxlXc1jH
	5aUScu+2WpZqzpdVfiYII2A0ZoIevbNzJS+ZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QBBaOd2y3GoJRajJ4xi0y0REjlCYrnRp
	P2i9sFLb4C5U79PGWuQywJbktegSI2F0c57tZkzqruvANNebw+E1+JdIvuElPZCd
	uqO1O90w9wPafnK9AIRfcAQfqohzobwTDzufP3xdJJTAurVAvYXjFrwioMhwu4ij
	lcezH+qr4gU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 44C8834CB8;
	Fri, 29 Aug 2014 15:07:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D66F734CB0;
	Fri, 29 Aug 2014 15:07:50 -0400 (EDT)
In-Reply-To: <5400CC7C.4010706@Maxsi.org> (Jonas Termansen's message of "Fri,
	29 Aug 2014 20:54:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C599D0CE-2FAF-11E4-887D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256182>

Jonas 'Sortie' Termansen <Sortie@Maxsi.org> writes:

> Jake's modified patch set breaks the case where timer_settimer exists and
> is broken. As far as I know, that's only OpenBSD among the noticeable free
> software world, but could be more systems, perhaps in the future.

That is easy to fix, isn't it?

Where you said "If you have timer_settimer(), set this makefile
variable", you start the sentence with "If you have a working
timer_settimer()" instead.
