From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git checkout -b: unparent the new branch with -o
Date: Sat, 13 Mar 2010 01:42:22 -0800
Message-ID: <7vaaucd0ch.fsf@alter.siamese.dyndns.org>
References: <1268173713-5224-1-git-send-email-erick.mattos@gmail.com>
 <7vr5nqrpyg.fsf@alter.siamese.dyndns.org>
 <55bacdd31003120845kc980d16s1e6006d56d6f923a@mail.gmail.com>
 <7v8w9whd3g.fsf@alter.siamese.dyndns.org>
 <m38w9wlg7i.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Erick Mattos <erick.mattos@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 13 10:43:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqNs2-0004ms-BO
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 10:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934701Ab0CMJmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 04:42:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33279 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934247Ab0CMJmf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 04:42:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EFF6A18EC;
	Sat, 13 Mar 2010 04:42:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8vOXQgu+QkAZHgLbCpXMWLmvDhc=; b=Y+Sefw
	ntkLW/m0jP68Kb0vkO1SHMd7Aw6HLWJzmaN2LTi63pkZt/GX9Di3ApxtEFe/Bwqg
	J13p8SZPTCriPAp0+XWgGLcUriprSGVPK0Oxrz8z/sU3LEnc059GUNeBwM2Syfb3
	wbh+VqoWr14CNdfTgW1fsVEfojLdvBDOqbfIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sD8/rOzyPkR9yCqKuMCf+3VGz9KmOlG9
	Q+MH3BXIiRA5Fj+HIVGOq3OUhM/YkHZ8WV2NcVv6KNmcaungMVjp/F0ncuP7vTl3
	UHsYrBsMrxyff0AaAIDzjdW4RpDg5Mu1xbu5qcZww+Vuz6G0ch7HoSSR5vZMlgv1
	Lvx3Mdu2ExQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E7E80A18E3;
	Sat, 13 Mar 2010 04:42:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F180A18E0; Sat, 13 Mar
 2010 04:42:23 -0500 (EST)
In-Reply-To: <m38w9wlg7i.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Sat\, 13 Mar 2010 01\:33\:19 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BD31BCFC-2E84-11DF-A3B2-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142095>

Jakub Narebski <jnareb@gmail.com> writes:

> BUT in the case of 'html' and 'man' branches I could see why current
> implementation of _removing index and not removing files_ might be
> advantageous.  Remove index, create HTML and manpage version of
> documentation, and add HTML (in 'html' branch) or manpages (in 'man'
> branch)... probably shifting root, so it is not all in single
> Documentation directory.

When you have some spare time, I'd recommend you to read dodoc.sh script
in the 'todo' branch.  These preformatted documentation branches are
coming from their own repositories, very much on purpose.

> Just my 2 eurocents.

Already?
