From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Bug?] "git commit --amend" always gives author-date to summary?
Date: Thu, 14 Apr 2016 19:13:00 -0700
Message-ID: <xmqq7ffzei1f.fsf@gitster.mtv.corp.google.com>
References: <xmqqh9f3gaqh.fsf@gitster.mtv.corp.google.com>
	<20160415020300.GA22112@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 15 04:13:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqtFt-0004Av-Bh
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 04:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbcDOCNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 22:13:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54793 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750957AbcDOCND (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 22:13:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C47413880;
	Thu, 14 Apr 2016 22:13:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1SYR6TQZR2Q41t4p8K9Wcc3ji3o=; b=PpFkn5
	71li07lQxd+oy4XefOb8NpIQdx2S6eLoDJd6N4zZVtil42BSR5hB5Q+nCfkfztNk
	t8DUeIhDy66kpFUXEBNmhkkCzUXRcU8wUEItbAH+9TsFjTFZJIsJHsa2K/m+MYqw
	3MinEPkpu3GNHI6DIfudstzdJps6aRSHQQ+Mk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gJEzPKUdRprKsjItaBE9noyR7mE9bH/o
	0DCnb1fuUz9lWNrBy3djZ//0hcpWN5UeBXSQpdcHmDuZ7GmxnWsvIvoBg+AZLmGB
	6SlpiZMXxGScCY+C6shqNj850LYdBH0ogN1/lrjWcwkiN09Ft3/sp5Hv6hNl9fX4
	ZUpEXLmX4/M=
Received: from pb-smtp2. (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B44A1387F;
	Thu, 14 Apr 2016 22:13:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D54491387D;
	Thu, 14 Apr 2016 22:13:01 -0400 (EDT)
In-Reply-To: <20160415020300.GA22112@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Apr 2016 22:03:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 94B5CF42-02AF-11E6-B779-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291593>

Jeff King <peff@peff.net> writes:

> That's working as I intended it in both cases. The point is to show
> extra information whenever we have picked an ident or date that is not
> the "normal" one.

OK.
