From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/14] Add submodule test harness
Date: Mon, 14 Jul 2014 14:18:36 -0700
Message-ID: <xmqqd2d7y6z7.fsf@gitster.dls.corp.google.com>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de>
	<53B46425.3030000@web.de> <53B4F0AA.10809@web.de>
	<53B5C7AC.4040701@web.de>
	<xmqqsimddrq3.fsf@gitster.dls.corp.google.com>
	<53BAF7AF.4020901@web.de> <53BC47BD.1000705@web.de>
	<53BCDDE2.1080301@web.de> <53BD87B3.8050901@web.de>
	<xmqqmwci9vn1.fsf@gitster.dls.corp.google.com>
	<xmqqsim96ine.fsf@gitster.dls.corp.google.com> <53C17D16.80106@web.de>
	<xmqq4myk21o8.fsf@gitster.dls.corp.google.com>
	<53C41FED.5080101@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 14 23:18:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6ne6-0002FJ-GF
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 23:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757226AbaGNVSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 17:18:46 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63954 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756792AbaGNVSo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 17:18:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E6D8D28974;
	Mon, 14 Jul 2014 17:18:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qZjzR3fJ5AahaiALm51j45R3E1M=; b=wYLXPB
	+rDLS7RQN3ucsbS33iHqv+mHD8MF+rUljLL6M5jtJxg/Nq9l3Bwdw9AIRfQH4fOW
	fIFILjepGq6OSaEtTMwfO8ar/RH/M6Ba/a2uCrGC/scer5bO2g0o2m8cKWGkpV6P
	YlOpI5KokLZH2HkVOG9NA7vA3tuGqZ67+sdhU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Oh+2kGdT6emn7G9swFFtuUWzymjxIMFz
	ML15lSKKDNZO2LyhD1dWtI/C6LhW6wW1D/w0R5h1e3Lyny+Pbv3cgPqmPaU7MObz
	1/R4GEmAMKV5IiY3tx44AjA9rclWl4TRCl074H1BROkCgvTEoOqqd7P/eVbd2kN/
	yskKPtAORcE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DC86528973;
	Mon, 14 Jul 2014 17:18:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6A47D28963;
	Mon, 14 Jul 2014 17:18:20 -0400 (EDT)
In-Reply-To: <53C41FED.5080101@web.de> (Jens Lehmann's message of "Mon, 14 Jul
	2014 20:22:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 616007A4-0B9C-11E4-8AA7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253537>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> So what about adding "Currently only submodules living in the
> root directory of the superproject with the default name (same
> as the path) are supported." to the comment above the function?

OK, done, and merged to 'next'.

Thanks.
