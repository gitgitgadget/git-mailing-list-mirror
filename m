From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash completion: allow git stash store options completion
Date: Wed, 14 Jan 2015 12:06:32 -0800
Message-ID: <xmqq1tmx9lfb.fsf@gitster.dls.corp.google.com>
References: <1421171612-12058-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq7fwqed7b.fsf@gitster.dls.corp.google.com>
	<20150114190345.GC32115@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 21:06:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBUDA-0008SS-F7
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 21:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbbANUGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 15:06:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64856 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752309AbbANUGf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 15:06:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 72B6C2C352;
	Wed, 14 Jan 2015 15:06:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pn6dcBW29mlcZ9jIsU1HsyYemF8=; b=j59OgS
	e+34UKqyfhpQUhayueBWOuAQWcmn/FMjz9u7o59lJDdiOeeD2za8Q3E3SFqdAmcz
	Cwm5GHMUS7uOaAMf6KqeEjNPaHYESz4oze7MVt5gfQnQ3tdqcn+fZvp6eJmBaTI+
	jWN3S8PNsTaicijE3qj7KO9Ga7YWkP9XHNK1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kQwl52cuLM3hq25SwO/vnz4GbIywwdg3
	YTvdFFrxstgqE+xVayBBYq2h8MOdG9ZYzz15vSWXDZ4rXM34qRRGUMEWkG9F2qI5
	usNTNyqP+TAYQJk0jEHPIDMHJ5omljyzNsMWAao7fS93QpvY4w/CEDoXTdRNZgaU
	bgEWlaMjTJc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6313D2C351;
	Wed, 14 Jan 2015 15:06:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA2DF2C350;
	Wed, 14 Jan 2015 15:06:33 -0500 (EST)
In-Reply-To: <20150114190345.GC32115@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 14 Jan 2015 19:03:46 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D6752A3E-9C28-11E4-9DD9-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262418>


"brian m. carlson" <sandals@crustytoothpaste.net> writes:

[administrivia: please refrain from using Mail-follow-up-to]

> For what it's worth, I'll often sketch out a script at the command
> line before putting it in a file (either because I realize I'll need
> to do the same thing again or I want to share it with others), so I
> think this might be a useful addition.

Yes, but that applies to manual pages and possibly "-h" short hint;
keeping completion that is unnecessary for end-users has cost, e.g.
making unique prefix longer.
