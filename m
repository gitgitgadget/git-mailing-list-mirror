From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1bis/2] Diff patterns for POSIX shells
Date: Wed, 03 Aug 2011 11:53:50 -0700
Message-ID: <7vmxfqba2p.fsf@alter.siamese.dyndns.org>
References: <7vzkjrem6b.fsf@alter.siamese.dyndns.org>
 <1312349176-20984-1-git-send-email-giuseppe.bilotta@gmail.com>
 <20110803093252.GA16351@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 03 20:53:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QogZp-00016L-J8
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 20:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534Ab1HCSxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 14:53:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44974 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753872Ab1HCSxw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 14:53:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A43D440C;
	Wed,  3 Aug 2011 14:53:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+qGBEUNW5O8vJ1qEJAS2Wdeel4M=; b=us0df0
	6o4QYvh2bm4VdtmKcci9xyH7HirODStcV3TT0io7Hkeg6EN6XnJBkPBHztgdq5Q7
	MNO/MvHo3UyW0JWxUI9xscTVWR8szN4cSnynXUDDcxpldf3hUoQPBqyrdT8wbzf1
	OoixVvkAdnLaxivL60fZqTg+6yWfNopt1/HKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EKdf7xFW72ElzEjssswazVb2Js6TM/JX
	tsKUGjTVmpZuxAzdBkgnU89MjnPBq3qyaYEYkNoRk+U83wvv62BWpOG6xSEszVNX
	pM1AZ6TtflQPhkhdgp/fSolNRoRoGU2ZH2H7zStyogrNi9+UMBlihCnHTJd10BXo
	Qh+Nuc+kBZs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71D9D440B;
	Wed,  3 Aug 2011 14:53:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E414E440A; Wed,  3 Aug 2011
 14:53:51 -0400 (EDT)
In-Reply-To: <20110803093252.GA16351@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 3 Aug 2011 03:32:52 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE10E100-BE01-11E0-8C63-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178606>

Jeff King <peff@peff.net> writes:

> On Wed, Aug 03, 2011 at 07:26:16AM +0200, Giuseppe Bilotta wrote:
>
>> All diffs following a function definition will have that function name
>> as chunck header, but this is the best we can do with the current
>> userdiff capabilities.
>
> Curious as to how this would look in git.git, I tried "git log -p"
> before and after your patches, and diffed the result. I noticed two
> things:

Hmm, sounds like a regression without much upside to me.
Thanks for looking.
