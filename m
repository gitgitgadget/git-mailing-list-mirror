From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix settings in default_user_config template
Date: Fri, 17 Apr 2015 10:33:32 -0700
Message-ID: <xmqq1tjir76b.fsf@gitster.dls.corp.google.com>
References: <20150417145516.GB2421@peff.net>
	<1429290535-38647-1-git-send-email-oherrala@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ossi Herrala <oherrala@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 20:58:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjBT8-0001ik-RE
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 20:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088AbbDQS6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 14:58:22 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59675 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753096AbbDQS6V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 14:58:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E76A34ADDB;
	Fri, 17 Apr 2015 14:58:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p6x6OaMRZ40rs7Vzlca2QowWb2s=; b=gL+Paa
	M+vpN0513wBp0RRc9v8LJxaMWiTitBSS7mywyt/7+YRJ2gtFLfEgS+Nw4xxIPnRD
	gIlWVNRbMebJT77FxQpl14Lh/BPrOHzpkLLtzBhnTHqyFqZF87RE+r2247UVEfGG
	dEvGefYsJUGhLpA8f2WK04+K+My6D3U4HDHFs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aF9FRNEB1mluW3CRPuZrJJjp3L/bWnhu
	Hg3ErmMxHCF/HWYSnWtN+rk7huSj0TAtKJ9r4RmeO5oMcCCH+Ro0/5f7OD5HLW1y
	rbMHucnEvsLKg7d2Gd9EIT1ncnuTqKFTJ3VkQ7xp5xrYjlJKkLWIdZtUz6OefpPh
	E2f94GUD0U4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DFC104ADDA;
	Fri, 17 Apr 2015 14:58:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A390C48A62;
	Fri, 17 Apr 2015 13:33:33 -0400 (EDT)
In-Reply-To: <1429290535-38647-1-git-send-email-oherrala@gmail.com> (Ossi
	Herrala's message of "Fri, 17 Apr 2015 20:08:54 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DF106256-E527-11E4-A2A1-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267378>

Ossi Herrala <oherrala@gmail.com> writes:

> The name (not user) and email setting should be in config section
> "user" and not in "core" as documented in Documentation/config.txt.
>
> Signed-Off-By: Ossi Herrala <oherrala@gmail.com>
> Reviewed-by: Jeff King <peff@peff.net>

Thanks ;-)
