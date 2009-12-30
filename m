From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature suggestion: support arguments for GIT_PROXY_COMMAND &   
      core.gitproxy
Date: Wed, 30 Dec 2009 00:06:43 -0800
Message-ID: <7vmy1051ik.fsf@alter.siamese.dyndns.org>
References: <cone.1261179562.490491.4033.1000@toolshiner.phx1.kidfixit.com>
 <20091230121329.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Joey Korkames <joey+floss@kidfixit.com>,
	git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 09:06:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPta6-00074y-Uj
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 09:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbZL3IGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 03:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752246AbZL3IGz
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 03:06:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbZL3IGy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 03:06:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 920DB8CC3C;
	Wed, 30 Dec 2009 03:06:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Iyx8LkQ+YXr2YY4wuxql/hDCvwo=; b=u5BkGj
	6tbdrYkK8xr77dJZ7BR86/YmYB6V2kPYlgfWKBX+37JZl9h6fpEstizms9EUFjON
	UViYU8gfBMnOkIUxjLMmm3jezRlpfzYKoyIZf10sgo4G3QXZWWOyadwsZzv8Rx58
	drsqg7mFZaMJOeilO9e8lNjLAmRVh2SXYHW38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CjG3jJF6OvXlUhmmWtM/ACYMJRL9I+7F
	ydHqJEfIC0IBmvs9XwP6rlcSo4uvb0oQIR2CcHxZ/pSj0CNJx9Q5i0fAxYBwUgI7
	Dnzz/85GUAM8uxAT9HYbhotmR80KpNDhPvyCLG8oUryVDUhd1+cI5qxXcv5Q9yac
	HV0m0yPzkoQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 474FE8CC3B;
	Wed, 30 Dec 2009 03:06:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 615788CC3A; Wed, 30 Dec
 2009 03:06:44 -0500 (EST)
In-Reply-To: <20091230121329.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Wed\, 30 Dec 2009 12\:13\:29 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 47EFFF9C-F51A-11DE-8A60-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135869>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Junio, could you tell us what happened to this thread?
>
> I think this is probably related to the "textconv" change.

Yeah, you guessed right. I think the unified way to launch user specified
programs would come first and then spawning proxy the same way as others
would become trivial.
