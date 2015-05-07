From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/12] Improve git-pull test coverage
Date: Thu, 07 May 2015 12:01:48 -0700
Message-ID: <xmqqy4l0nrdv.fsf@gitster.dls.corp.google.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 21:01:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqR3T-0005xM-Gb
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 21:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbbEGTBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 15:01:51 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50446 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750806AbbEGTBu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 15:01:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C19A94F0F1;
	Thu,  7 May 2015 15:01:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SBlyOFffr4ahcJBGiDad9SG8y68=; b=EPfdHV
	w/ulV7Sdr4ukQZAQNz52sQQklADRX9c9K6jTvfoJzCTKDrbDaE9N901wsnMMs3un
	T8w2MwSfHwCRxBpu9G2vJdU1mlLEjSeXMxgvG3TXMqYozkJP5e7kEjhVn5Opw+CC
	dr3G3HKEbPO1QFb8eg4ME7p+IYb4mBw4v/nls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YZPWmhN6RWwbDmo4t+dPIhJaIdTBg08b
	JKDvlwB5BNhaAL6kjWWuMMnVyhgGl5VTTmsemWPWn1hOReqFZyxVLLJHcOapnKOh
	E2lN1ErlQYqKua5hKqhVPXh4fuuUO1fhiAYdjB2KFROyAYuxSlSTvIFRnmBuKh7K
	BBpDxwrUoY8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B9D4E4F0F0;
	Thu,  7 May 2015 15:01:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3AF784F0EF;
	Thu,  7 May 2015 15:01:49 -0400 (EDT)
In-Reply-To: <1430988248-18285-1-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Thu, 7 May 2015 16:43:56 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 83BBDCAE-F4EB-11E4-B01C-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268580>

Paul Tan <pyokagan@gmail.com> writes:

> This patch series improves test coverage of git-pull.sh.
>
> This is part of my GSoC project to rewrite git-pull into a builtin. Improving
> test coverage helps to prevent regressions that could occur due to the rewrite.

Overall, I like what I saw in this series.  Good first progress ;-)
