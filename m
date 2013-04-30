From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/8] History traversal refinements
Date: Tue, 30 Apr 2013 14:28:33 -0700
Message-ID: <7vip33btdq.fsf@alter.siamese.dyndns.org>
References: <1367342788-7795-1-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Tue Apr 30 23:28:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXI6W-0007dc-PY
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 23:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933827Ab3D3V2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 17:28:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51378 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933825Ab3D3V2g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 17:28:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC70C1A0D8;
	Tue, 30 Apr 2013 21:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=40TgRpiPiIqTvMj3SM4QSls0dao=; b=UcbnFE
	fCst7p2JjsPS4SuDvOPY1gtbCpxsImkwBzR51r5ayL4RqvFlbyRUYDr4dTzvgQyf
	51IYUF/grFl5c8dGCBExjmBwqUvgDo3p7UNkd2jka4QHpEL4n9VMEkiF1W4RWHch
	+9tmuWE8tSg8V5Msbt6GtYhhmTpPCY9ywI5HU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DU0OZQ0YHPS9qJDpCxynccjeoxVrFTXM
	EN5yRtkjX4FR4um6bWXmZik4YavzH2bA/r7/ga1z3YWcGbLcBwAxTKaGOcgTR5yJ
	j70jqQYyfgHUS10XbOEQXnQnbLsCIqv2DxCkSP0g4zT1PyxcS5m5rK4qzrXHIeV6
	ErCfe3mXZmI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A41901A0D7;
	Tue, 30 Apr 2013 21:28:35 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF2D61A0D1;
	Tue, 30 Apr 2013 21:28:34 +0000 (UTC)
In-Reply-To: <1367342788-7795-1-git-send-email-kevin@bracey.fi> (Kevin
	Bracey's message of "Tue, 30 Apr 2013 20:26:20 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E9E00964-B1DC-11E2-A47B-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223012>

Kevin Bracey <kevin@bracey.fi> writes:

> Okay, here's what I'll call v2 of this series. In the 3 parts from
> before (4,6 & 7), I've addressed the comments from Junio and David,
> corrected some errors, reconstructed the main commit message, and made
> some adjustments in preparation for part 8.

Overally, very nicely done.  Thanks.
