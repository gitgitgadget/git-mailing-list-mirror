From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: write memoized data explicitly to avoid
 Storable bug
Date: Mon, 19 Jul 2010 09:37:48 -0700
Message-ID: <7vlj97pgv7.fsf@alter.siamese.dyndns.org>
References: <1279455469-6384-1-git-send-email-vsu@altlinux.ru>
 <20100719063903.GA3680@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	A Large Angry SCM <gitzilla@gmail.com>,
	Sergey Vlasov <vsu@altlinux.ru>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jul 19 18:38:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OatM1-0003qa-CM
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 18:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936436Ab0GSQiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 12:38:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36763 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936408Ab0GSQiA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 12:38:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D2F9BC6056;
	Mon, 19 Jul 2010 12:37:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ztn4tpmDRr8kL80bJawCc34aEWM=; b=WDMyay
	0bStiqkmIWKN35y4nOGzAuU6ZPKBUOt0Cm73AO7YoE/14xQ3rEsskH3o0ZaloBEx
	zEnvixWRkryLX8+oYVrJOaB/dRYxp1hRcws9uk87YHxY5d3b32GHrZ2J5DcoxZlJ
	GLpSzfOe2XFnhLcZQRhDmzsiQ2bHWdVfL6toc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SvRzNn52FD0FUVQJmH6HJU39eLmPy23I
	13pwtcICRNqrICxSw9sZAdisofW6DnGdHoA3/TsqhMifZrye0zA7dy1Dm/wzoD0k
	HQ5e3VzxcOSU+y1ZrPNjedHHPM0h1Dw6XIj7RTOBNwiSJ7Ci68N2JNshWlpSK9q/
	WFg53gQFG5Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D78FC6055;
	Mon, 19 Jul 2010 12:37:55 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87895C6054; Mon, 19 Jul
 2010 12:37:49 -0400 (EDT)
In-Reply-To: <20100719063903.GA3680@dcvr.yhbt.net> (Eric Wong's message of
 "Mon\, 19 Jul 2010 06\:39\:03 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FB6D44E4-9353-11DF-AE7A-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151259>

Eric Wong <normalperson@yhbt.net> writes:

> Thanks Sergey,
>
> Acked-by: Eric Wong <normalperson@yhbt.net>
>
> ...and pushed to git://git.bogomips.org/git-svn

Thanks all; pulled.
