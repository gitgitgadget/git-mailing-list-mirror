From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/7] repack_without_refs(): convert to string_list
Date: Wed, 26 Nov 2014 09:55:09 -0800
Message-ID: <xmqqtx1lrgn6.fsf@gitster.dls.corp.google.com>
References: <1416902555-10748-1-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kan-SetY=ZM=t69pE3JAL3PaZ9c5x0oDbq9QqU1JfPOug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 18:56:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xtgoo-0000nP-Ar
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 18:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479AbaKZRzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 12:55:16 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752819AbaKZRzL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 12:55:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 245DD20717;
	Wed, 26 Nov 2014 12:55:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2aKdoy3wH7ne1RTql+GoP700nts=; b=AJFT2L
	UIB6wTPQABKac/m8CC3MHwK3lHyv1AJELY0qV/9cOWOiN4rKduIoLO24hWtF+0vs
	iGjqfF95r087WWu0ncxSrOnT+9Dqemg/nObbTvcB5QvJkJUlAQbFCEP8Qy0UdmLe
	mJ+FWnQ+rG9EeIDFQTDfZ44Mb4gHgg458fuxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bkCV/Hbi51kpEREBRnR/DMawXzzQifKP
	wRAqpkNQ4bNs1Ny4qPTT8CBrA/6Kf/VjLNB4c2ix/uoAcTI71G+DNWZrVYZmrWrj
	oaPYI9dyCudLspG5zbLoSEP+5PxDru0ALIy/DxOQ2vJq3DbNDHMJQmBgqHhhqutT
	2V/0wlplk/8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A87B20716;
	Wed, 26 Nov 2014 12:55:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8C13520715;
	Wed, 26 Nov 2014 12:55:10 -0500 (EST)
In-Reply-To: <CAGZ79kan-SetY=ZM=t69pE3JAL3PaZ9c5x0oDbq9QqU1JfPOug@mail.gmail.com>
	(Stefan Beller's message of "Tue, 25 Nov 2014 17:15:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5D6B6C16-7595-11E4-A424-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260286>

Stefan Beller <sbeller@google.com> writes:

> As this is in conflict with origin/sb/simplify-repack-without-refs
> we'd need to decide, which we'd take. I'd gladly go with this series as it seems
> cleaner and easier to read.

I'll drop sb/simlify-repack-without-refs and replace it with this
series (naturally called mh/simlify-repack-without-refs ;-).

Thanks, all.
