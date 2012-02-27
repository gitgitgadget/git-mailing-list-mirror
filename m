From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Trivial cleanups in the post-receive-email script
Date: Mon, 27 Feb 2012 11:01:05 -0800
Message-ID: <7vlino85ji.fsf@alter.siamese.dyndns.org>
References: <1330367650-23091-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Kevin P. Fleming" <kpfleming@digium.com>,
	Andy Parkins <andyparkins@gmail.com>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Feb 27 20:01:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S25ov-0002Yb-Pm
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 20:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832Ab2B0TBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 14:01:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36395 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754557Ab2B0TBH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 14:01:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41F9A66DA;
	Mon, 27 Feb 2012 14:01:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=19Cblrr074Oj8Bg3mnoA+0Zhjqs=; b=XcXaHh
	LBTphPr/nljYe99HGmeEKKERYZXzOMMzUaM15wqSGkG4p0Y7BYpM9wRGTIJ1BMMo
	cVZW2NnIFrz9FX/+95bIuTsf6PCO9AGBoDNzgNTczqNv/9MzjQpVZEr54t5sAQXm
	DapPv1/07fD0HoWgsht54oyUAyHc+cYYH2ICo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=esguDXYDLJweEJFnhIVU/ECTpcrQHMBK
	7h+IY4xJ1ThJm5sJeY18zJV+Ew0HIk1u87bFg5SmuHCgZbtiacySXOLvdpJN8a63
	RXzfEtJDgaCfXH1/+/K9MqwEKZRv4DVLznsL1yx4igbKOZAh/DBvVkIuRtL/K0HR
	RP3jd8rFd7s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3839D66D9;
	Mon, 27 Feb 2012 14:01:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C00F366D7; Mon, 27 Feb 2012
 14:01:06 -0500 (EST)
In-Reply-To: <1330367650-23091-1-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Mon, 27 Feb 2012 19:34:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 672E3E5E-6175-11E1-8347-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191653>

Shows that nobody uses these sample script.

Will apply.  I wish all the patches were this easy ;-).

Thanks.
