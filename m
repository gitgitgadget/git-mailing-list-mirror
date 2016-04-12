From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 6/6] commit: add a commit.verbose config variable
Date: Tue, 12 Apr 2016 14:39:14 -0700
Message-ID: <xmqqy48io6bh.fsf@gitster.mtv.corp.google.com>
References: <01020153faf9fc14-e6ad18fa-c892-4601-bab7-e2cc4cd9e100-000000@eu-west-1.amazonses.com>
	<01020153faf9fcd0-879c8263-6143-4ad2-a3b3-deb78c93246a-000000@eu-west-1.amazonses.com>
	<xmqqa8kyplkp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 23:39:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq61s-0001yG-Tj
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 23:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757701AbcDLVjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 17:39:19 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756274AbcDLVjR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 17:39:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 46EEB55585;
	Tue, 12 Apr 2016 17:39:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EkTICPd8n4h9PSVWqPXF/FI+um8=; b=BLpprj
	ZH2IOAsQzv7cxlGI28Mf6be3AqHmcs4cthZ40h9CKy2QPV9lYzRE2BoVfeAKBt/n
	7w4xX9KS4SUNJDoQh+qQNo4og0t4N8cTJyZrlhwOJEppjgJRJI1KMDuqf0GASPf6
	3DTIukH8SIVxjCrWajZQ5I7x0DC9pjmWcE5WY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RF+kfdcs+lU9WCEw4ftQHAY4FpgSAKNS
	gMCWiBKRzOX7YBGR6++/WlVqLjBEaBMfxThLuTCwAFc4hsmZydurdyqRZ4ob8+kU
	iZyRtenWS1SZpCjKiOx3D5e9w3YH8tIb/zN+F0hyvA2K9RPufUSQ74/TkulwRT7L
	oa71AAyHqgg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3E48555584;
	Tue, 12 Apr 2016 17:39:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B051755583;
	Tue, 12 Apr 2016 17:39:15 -0400 (EDT)
In-Reply-To: <xmqqa8kyplkp.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 12 Apr 2016 14:24:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0122B79A-00F7-11E6-8F9E-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291300>

Junio C Hamano <gitster@pobox.com> writes:

> Hmph, isn't this already in 'next', hence we cannot accept a
> replacement patch?

As a one-time measure, I'll revert the previous one

50f0d20d (commit: add a commit.verbose config variable, 2016-03-14)

out of 'next' and queue this one instead on 'pu'.
