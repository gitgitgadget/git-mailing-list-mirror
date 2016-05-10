From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/33] Yet more preparation for reference backends
Date: Tue, 10 May 2016 14:32:27 -0700
Message-ID: <xmqqlh3hmwes.fsf@gitster.mtv.corp.google.com>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 10 23:32:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0FGc-0004p5-LQ
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 23:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116AbcEJVcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 17:32:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51901 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753101AbcEJVcb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 17:32:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F0891A34D;
	Tue, 10 May 2016 17:32:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=leHtzhhn2N5HyoWDyyV4LyHw/5s=; b=GPvK9r
	o1RkyEnABMQutcRx+QejBB3JE4N3bh4wjjbl7T8BjtEBg9b30djDzsUOwVfI/uW1
	zTUriGSerZHS7q/+RJt8omYhvyBCedMlvm5wUY6loToTWCNUmh/nGX1FAPhTJZQs
	95Pp7pS5TB6FPGs+pCMCeXnEq14WaAldSsbCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UwKDw7H3iBXVviX/DlsxZyCBiN0hB5N1
	DUw+o8ylTogEzLdF0F09CGPg04yIzx4N+YgLdAnT9icsGfLNxmKBv9zPNYvqLsdr
	TylnLnHsv6STwPywWlhIZJ5ib8koZpRpYaXaj/MTAOXp5Kp5ZtTTNBBH41Qrjupw
	iiJCnmgLFSY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 06A211A34C;
	Tue, 10 May 2016 17:32:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8028B1A34A;
	Tue, 10 May 2016 17:32:29 -0400 (EDT)
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu> (Michael Haggerty's
	message of "Fri, 6 May 2016 18:13:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B2993462-16F6-11E6-8B7A-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294198>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> ... I think I have addressed all of the points that were
> brought up. Plus I fixed a pre-existing bug that I noticed myself
> while adding some more tests; see the first bullet point below for
> more information.
>
> Changes between v1 and v2:
>
> * Prefixed the patch series with three new patches that demonstrate
>   and fix some bugs in reference resolution that I noticed while
>   inspecting this series:

I'd propose to wait for further comments a few more days and merge
this to 'next' by the end of the week.
