From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: honor prepare-commit-msg hook
Date: Tue, 15 Feb 2011 13:36:39 -0800
Message-ID: <7voc6dm13s.fsf@alter.siamese.dyndns.org>
References: <1297732070-32704-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 22:36:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpSZo-0007DM-W0
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 22:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755634Ab1BOVgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 16:36:48 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40461 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876Ab1BOVgr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 16:36:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B1FF244AD;
	Tue, 15 Feb 2011 16:37:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7hwg1dp8OE+gGVMTHPow/QuuhFE=; b=k1D+Ut
	y4DRT0P/eGSYS7yK7NCbTZ3t0QSEJkRNRE0Koy56A9AVedYHWvgGtUH1cAtSRs2h
	/pw30TtT9N+g28go4xVwDsej/5fYvhWoptYY3FQMOgq7C7v0gScuo+c7XKQuroVo
	oxPps5g19fLTILUr5AO/Dx0OldYTqMJpNk1tM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PldxuEk/EsPKjYrOiU3kRZOW0nSbuPyW
	g9Lpbl7/F9D8xrk7zD+KN3/PCL4e0MCNr7K+mxaOUYF8W2p9y8mczN+oKfrVx8LW
	NyL/uFrW4pOlPl/+i8MDdXlDYujo35aP/HdEn0J9ILS2biI5KxGmVCduvdqsrHPo
	Rlyxx1wMlMA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9098A44AC;
	Tue, 15 Feb 2011 16:37:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B16AE44A8; Tue, 15 Feb 2011
 16:37:46 -0500 (EST)
In-Reply-To: <1297732070-32704-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Mon\, 14 Feb 2011 20\:07\:50 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D5ED37B2-394B-11E0-A80B-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166881>

Jay Soffian <jaysoffian@gmail.com> writes:

> When a merge is stopped due to conflicts or --no-commit, the
> subsequent commit calls the prepare-commit-msg hook. However,
> it is not called after a clean merge. Fix this inconsistency
> by invoking the hook after clean merges as well.
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
> I sent this out previously as an RFC:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/151297
>
> But never prepared a proper patch. Here it is.

Looks very sensible.  Thanks.

Will queue.
