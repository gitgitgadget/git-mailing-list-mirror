From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.10-rc0
Date: Thu, 08 Mar 2012 12:05:29 -0800
Message-ID: <7vhaxydfjq.fsf@alter.siamese.dyndns.org>
References: <7v7gyvkh84.fsf@alter.siamese.dyndns.org>
 <m3wr6vs7a2.fsf@localhost.localdomain>
 <7v4ntzf45w.fsf@alter.siamese.dyndns.org>
 <201203081756.00604.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 21:05:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5jam-00026i-Mi
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 21:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758156Ab2CHUFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 15:05:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41375 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758086Ab2CHUFe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 15:05:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95D82615B;
	Thu,  8 Mar 2012 15:05:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SJbCSOD+AMnDs9kVgAvMOaOY0Zc=; b=aMu7Rr
	qTTmYp6fey63rGr2y5Z+vTPiMtYp1sXSSZaibe7ek5kp8MeZ2XurmotuRUrzXMC9
	tYzMd00ma3kvKqSCRs6j5QFDHqS4KxykVGb0OrQd77jKs+DmaT7piYEufnhN29t+
	dnPV22fkiMOhDHlUdQU61iJjZrgpsZ2nWBwN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qSDLE26V/SgPhsGvM62xPiPYtiPcbZwb
	L9CTg9jrU0E519trBb/I2X0sE1KSZ08dBDWr6gx220Cc57vpGy70Uxkmg5BNg4cC
	UYhZ+e78jLMYCYB8UZo4HWm4ZQCFFxcVzLfz+6OAspBqwZZfDsGdRgf/GcNfd9SU
	4Dh52UlYf38=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BFE8615A;
	Thu,  8 Mar 2012 15:05:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1EE5D6158; Thu,  8 Mar 2012
 15:05:31 -0500 (EST)
In-Reply-To: <201203081756.00604.jnareb@gmail.com> (Jakub Narebski's message
 of "Thu, 8 Mar 2012 17:55:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0EA325AA-695A-11E1-A45E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192640>

Jakub Narebski <jnareb@gmail.com> writes:

> I don't see it either in 'maint' or in 'master'.
>
> It is surely not in master, otherwise 'stg rebase' would drop the
> "gitweb: Fix fixed string (non-regexp) project search" patch.

That is because some of the topics were still very new to 'next' and
I didn't want to disrupt the zeroth release candidates with them.  I
think the following topics should be on 'master' before -rc1:

 + vr/branch-doc                                                03-06/03-06    #3
 + jn/maint-do-not-match-with-unsanitized-searchtext            03-06/03-06    #1
 + jl/maint-submodule-relative                                  03-04/03-07    #4

The two dates are the day the last patch in the series hit my tree,
and the day the topic as a whole has become part of next, and #<num>
shows the number of patches in the series (you can run "cook -w -"
and feed the "What's cooking" message into its standard input to get
the summary; both are available in the 'todo' branch).
