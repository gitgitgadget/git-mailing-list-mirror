From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Lack of detached signatures
Date: Tue, 27 Sep 2011 17:03:06 -0700
Message-ID: <7vty7xttxh.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.1109271742460.24832@bruno>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joseph Parmelee <jparmele@wildbear.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 02:03:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8hcJ-0000mX-M7
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 02:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552Ab1I1ADL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 20:03:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62463 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207Ab1I1ADK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 20:03:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E11CC58E1;
	Tue, 27 Sep 2011 20:03:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GS6SRIJZgV0uReLdu9Fb3gJpVWk=; b=eP6XwO
	FATkl0/RZlyqP1VdLdxL+TMLzHdWHx0Ce3WGi6qMOvOY0Q4be2d8/5+vBMihgbza
	5/QhvBQxiego9XQjWJ9WTVZdL0PCoUPP4FLgL0YOD770jbeYiWszEN2OlpetJO7K
	8nemFlbrQ4ybm+FLIzikqjPN2jh14x/EbHkCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oJOLezzUIDnF3m6W0vhaXVAqlXfZCfdg
	ksv73RhqRZwCQ2DSYqsvP9GAK7UzIhrP7UcrJLak8o/vq+yjkJ/G0fTfhIvSd2Bd
	P9AWzMut2Fb062cEzk7YltTSnYm0rcYrlqobMzRDw3AtzdK31qvD8/ezPYbMcMR+
	MLers6ctjA4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D960558E0;
	Tue, 27 Sep 2011 20:03:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7050C58DF; Tue, 27 Sep 2011
 20:03:08 -0400 (EDT)
In-Reply-To: <alpine.LNX.2.00.1109271742460.24832@bruno> (Joseph Parmelee's
 message of "Tue, 27 Sep 2011 17:48:46 -0600 (CST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F565AF2-E965-11E0-8CDF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182280>

Joseph Parmelee <jparmele@wildbear.com> writes:

> Under the present circumstances, and particularly considering the
> sensitivity of the git code itself, I would suggest that you implement
> signed detached digital signatures on all release tarballs.

Well, signed tags are essentially detached signatures. People can verify
tarballs against them if they wanted to, although it is a bit cumbersome.
