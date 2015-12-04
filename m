From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix quoting of redirect in test script
Date: Fri, 04 Dec 2015 13:05:20 -0800
Message-ID: <xmqqzixprkkv.fsf@gitster.mtv.corp.google.com>
References: <1449089407-14921-1-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Dec 04 22:05:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4xXj-0001QW-EV
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 22:05:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756090AbbLDVFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 16:05:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60711 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754445AbbLDVFW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 16:05:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7F76B315D8;
	Fri,  4 Dec 2015 16:05:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Fm641SnwkeqTg7QBShIBhTv+1Q=; b=Q8cFAC
	M+Klw6eA1FTpD/VwqOxd5f6A4E2ojlqI3FTaoQvsMZYNOybE/13FepadEWf5R6j0
	kA2ADwiVzmSWHjw4dfCeWCTtY2HfKm8Psz7VJcTMFohUhAcqy/WRikz+yx16qNfb
	V3jPNiR+IunPfVqw07yCrV7k7yh0JHgjlfmoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qaeF4poCfut8YB2MNRPjHNLwuIlOVBlA
	TDUViKRypqELkmYpHz7w+iYdX1er7uWR2MY4zW74RMMpPikHeXQYgqH+hFRFzjMs
	f9H1VZHkxpLo9deTJ6QX0SIXMUY9N6tj4K7XI1pv0DUc0uGueajXjBCV84s0mUH+
	xQx0McZCcXE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 76ED3315D3;
	Fri,  4 Dec 2015 16:05:22 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F0315315D2;
	Fri,  4 Dec 2015 16:05:21 -0500 (EST)
In-Reply-To: <1449089407-14921-1-git-send-email-charles@hashpling.org>
	(Charles Bailey's message of "Wed, 2 Dec 2015 20:50:07 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BB3AE85C-9ACA-11E5-A091-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282003>

Do you want to sign-off this patch?

Thanks.
