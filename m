From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git documentation at kernel.org
Date: Thu, 09 Feb 2012 16:23:01 -0800
Message-ID: <7vmx8rtu3e.fsf@alter.siamese.dyndns.org>
References: <CAPyqok3USqMxm0gNf_T9vnCoicp9XSwpWUCYJ8jh79h=V_UuOA@mail.gmail.com>
 <20120208213410.GA5768@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ftpadmin@kernel.org, Petr Onderka <gsvick@gmail.com>,
	git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Feb 10 01:23:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RveGe-0003li-GQ
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 01:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758351Ab2BJAXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 19:23:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45738 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756580Ab2BJAXE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 19:23:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FCA27C5D;
	Thu,  9 Feb 2012 19:23:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lct3KnlcdXSyqmcWrGQpGoMUjjM=; b=rdbuos
	PkQ+/uHaaXr+MOaHkdBkdL+9By4lI1jHFRB8WABEq5QKavc085IzfMQ2kOUYopLu
	tzX/O2eNq4YluXBYoxfqubwhv9A9dcOvsuljyzllkKKgOKbBXN/fq/dVxDXlJSze
	E9T01howCNXDyTfAFwNbc8ebKrqa5B8JEv9z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QtkxILIwrDIL+ZUO8hBNlL40x5xs1FbY
	Z6XBCZp3KxBHvQE/k+gdJS3eBEQhgWWDa2HMSp6wi/3710804rDfveUmxatUzwLe
	bgmNY/MtWOZ77YPkX+H6VC1mGXSQTyS/4LugWK9GUV7gEfQ1J51Ddgynf3aH3FvU
	9VWRBRdnTQQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 147497C5C;
	Thu,  9 Feb 2012 19:23:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88EF37C5A; Thu,  9 Feb 2012
 19:23:02 -0500 (EST)
In-Reply-To: <20120208213410.GA5768@ecki> (Clemens Buchacher's message of
 "Wed, 8 Feb 2012 22:34:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6570C4F2-537D-11E1-8D29-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190348>

Clemens Buchacher <drizzd@aon.at> writes:

> Please restore access to the following files when possible. Some sites
> are referencing those, including kernel.org itself:
>
>  http://www.kernel.org/pub/software/scm/git/docs/git.html

The pages reachable from this used to be living documents in that every
time the 'master' branch was updated at k.org, automatically a server side
hook script generated a new set of HTML pages and updated them.

My understanding is that we do not want to run such random server side
hooks at k.org, so it no longer can be a living document anymore.

It might be a workable short term workaround to redirect

    http://www.kernel.org/pub/software/scm/git/docs/$anything

to

    http://schacon.github.com/git/$anything

although that would not give you an access to the list of documentations
for older releases, e.g.

    http://www.kernel.org/pub/software/scm/git/docs/v1.6.0/git.html

> Also, it would be great if the git wiki could be made editable again.

Amen.
