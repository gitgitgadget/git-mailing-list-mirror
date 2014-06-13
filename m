From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] submodule config lookup API
Date: Fri, 13 Jun 2014 10:50:14 -0700
Message-ID: <xmqqlht03dih.fsf@gitster.dls.corp.google.com>
References: <20140605060425.GA23874@sandbox-ub>
	<xmqqtx7p4wee.fsf@gitster.dls.corp.google.com>
	<539AA493.5030106@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 13 19:50:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvVcQ-0004vu-92
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 19:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007AbaFMRuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 13:50:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60484 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753734AbaFMRuV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 13:50:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 839A41E44C;
	Fri, 13 Jun 2014 13:50:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bk9RC9DIwwear34RsOkgHRCR8Qg=; b=SJdM9h
	kjoqz/rRf0bWplLtKKgFSBOfWNJPx7EGiUf+3v1wmd6y63RcIpUcv5TvVhEcBUvX
	ohquWWruYERCh/pvNAdgHDAJbpdqkik+BAOhvmSJ+RAbizxwZSt2HX5g38MJEi9l
	/3dn9slflBRP0fEUohVSWgvaAUi8CPIyqAdy8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s+75Mb+S5clBKPohCqDMIMZemjYAEYwI
	cS1BXJDrOqH+b2uZbYRDJcZ2N2MrYAwV+nfFiJJ6IVaSSCJy9GSjRBuiONGznVK0
	Rv2AGboRx/AaySX2bgk2cpfxY18euMtPolCokALyg6bO3wcvfbMV5HJ5Xmzphsfl
	aC+A58shsGM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7747F1E44B;
	Fri, 13 Jun 2014 13:50:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 559601E448;
	Fri, 13 Jun 2014 13:50:16 -0400 (EDT)
In-Reply-To: <539AA493.5030106@web.de> (Jens Lehmann's message of "Fri, 13 Jun
	2014 09:13:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2D84DB26-F323-11E3-9C91-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251623>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 13.06.2014 00:04, schrieb Junio C Hamano:
>> Hmph, this seems to conflict in a meaningful (and painful) way with
>> Jens's "jl/submodule-recursive-checkout".
>
> Then you might wanna drop my series for now, I need to rebase it
> above Heiko's series myself to make new submodules work anyway.

Thanks, that makes my pile smaller by one topic ;-)
