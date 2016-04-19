From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] WAS: [PATCH] mv: allow moving nested submodules
Date: Mon, 18 Apr 2016 17:01:45 -0700
Message-ID: <xmqqwpnu31qu.fsf@gitster.mtv.corp.google.com>
References: <1461022884-30819-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, gmane@otterhall.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 02:02:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asJ7F-0001MP-Ok
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 02:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbcDSACA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 20:02:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51534 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752101AbcDSAB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 20:01:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CE0C715644;
	Mon, 18 Apr 2016 20:01:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DzHjIb1KkBxilvUXmZfHaDeO0tw=; b=yWYxNr
	vcrnueWzb+Furp/KhU9536w5bl0Ko7Q7kGS2bL2S6AdRaZo34/rEfHt4+nF/VgPZ
	ya2LkKojaX8MFCwi7bXF4XpQ3blj0ljbWVozS+NmCwengs4oLw2AVQGoKDwFCeUe
	U/O2HFkzy2uFyWPLOZUAtKzvhizFTmhCrX9tE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Umc0Y8+dRSlzbnxhfsGMfDOHADTLHiHa
	/0a4rXkLFjybw+jW/Vph+Vz2UcXz5ATvwlkP3c2JJ7OD45GOVXa7utJ/ZzKzN5yn
	azjaAz9UTTdafAupa0qkGi+i0oTiZrCZ9pNUzu8eUnXpfyA/8tBVgZsfuUjrIwMl
	vi0XRuSpzog=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C5FF515643;
	Mon, 18 Apr 2016 20:01:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F4EE15642;
	Mon, 18 Apr 2016 20:01:47 -0400 (EDT)
In-Reply-To: <1461022884-30819-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 18 Apr 2016 16:41:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E8A63E56-05C1-11E6-A14C-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291839>

Stefan Beller <sbeller@google.com> writes:

> A single patch evolves into a series.

Power of code inspection to see bugs that are not reported, perhaps
;-)?

I wonder if we can come up with test cases to cover these potential
issues that are addressed in [1/2]?

Thanks.
