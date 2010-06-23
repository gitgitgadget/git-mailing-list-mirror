From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Newbie question: how can I list added files?
Date: Wed, 23 Jun 2010 10:43:16 -0700
Message-ID: <7vzkylejbf.fsf@alter.siamese.dyndns.org>
References: <AANLkTinxOE5xcP_V-PvoZGlfsxtcCafoYKy_PuBZnQnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT List <git@vger.kernel.org>
To: Bruce Korb <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 23 19:43:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORTz1-0001rQ-4z
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 19:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441Ab0FWRn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 13:43:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44223 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057Ab0FWRnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 13:43:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4690CBE18D;
	Wed, 23 Jun 2010 13:43:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YtpznPln6rPe4/GXjeXokYQZIl8=; b=Z/5eOM
	5fGbF6soWcTXXrpJkd6ZYrq7dzYfWt4seMZ21FZoKrhdoVSzAGrO254SgmE5+FG+
	ufCQGDVHhhD97mueZ+od6Ojtp3LQkiDoS3FhiaM63wnvSgP8rZDe20+BHbxHLfWN
	vy+Kst0OgKmP7+rAkWao/utpbBfnsYaZMkJBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V9HTj3wuQyhDiJ70XFZV/W0ZvcAvcWCS
	SAYbdn0eeck/p5SfwrXAkOPmtfMwhZ9u6YHN9ccomGxY5Ti9gjJgX+2a79jliouA
	AJkVzA5HBMnsVSA370hQIpV0teBU0RctvbAew3IVw3BMBjLwnMHq04srZVX0eCpM
	lDDyiFfLJ5Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 21A92BE18B;
	Wed, 23 Jun 2010 13:43:21 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52C94BE18A; Wed, 23 Jun
 2010 13:43:18 -0400 (EDT)
In-Reply-To: <AANLkTinxOE5xcP_V-PvoZGlfsxtcCafoYKy_PuBZnQnQ@mail.gmail.com>
 (Bruce Korb's message of "Wed\, 23 Jun 2010 10\:31\:07 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D0945920-7EEE-11DF-9172-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149524>

"git diff --name-only --diff-filter=A HEAD"?
