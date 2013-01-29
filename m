From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] transfer.hiderefs
Date: Mon, 28 Jan 2013 21:13:31 -0800
Message-ID: <7vham0tvus.fsf@alter.siamese.dyndns.org>
References: <1359418412-26602-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 06:14:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U03W9-0006Dr-Tb
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 06:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133Ab3A2FNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 00:13:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51853 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753Ab3A2FNe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 00:13:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B19388829;
	Tue, 29 Jan 2013 00:13:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kE2bk5Ei6jHr9cTqqlzYW3ywd0c=; b=b08myb
	CTHV4uCEl7bItWrXdUVnh0c6xclOmJU4t+kbC5t2BzBkOCfSP3cZ2WqcezK++qx6
	3HYSFoGIiUTjdPUKnEg9NX1SpxOti6PVTX71vHNBJ5ngJNDoLrjhvmKNav95jHzg
	+vqZFUMv7tBBkgEREdVe43pa937B0T3urbAVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=buvP/fxB+qXiSnjS+AxWLQq1dtJM6YlJ
	dUkZGGuuh51V8x8/cemo+w7vF+TWyxlMNFDa6L/b4m1ULHV3exLnbBlY+clQm1Ja
	WQqFVZdIe+joTim1zZ8Y0YtYeIRwXwmP3zMPRwnq+wngYCpLaXB21gLf/99F2oBB
	rEbntngs3kY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6D068828;
	Tue, 29 Jan 2013 00:13:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34C228826; Tue, 29 Jan 2013
 00:13:33 -0500 (EST)
In-Reply-To: <1359418412-26602-1-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Mon, 28 Jan 2013 16:13:29 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A08DCA0A-69D2-11E2-B520-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214902>

Please take this as just a preview of early WIP.  I think I may end
up doing moderate amount of refactoring as a preparatory step before
these patches, so nitpick-reviews are likely to become waste of
reviewer's time at this point.
