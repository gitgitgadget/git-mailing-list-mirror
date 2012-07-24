From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn SVN 1.7 fix, take 2
Date: Tue, 24 Jul 2012 14:51:37 -0700
Message-ID: <7vipdcesk6.fsf@alter.siamese.dyndns.org>
References: <500F17A3.60307@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Robin H. Johnson" <robbat2@gentoo.org>,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 23:51:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stn1C-00068x-T9
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 23:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601Ab2GXVvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 17:51:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64665 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754278Ab2GXVvk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 17:51:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0984F82D8;
	Tue, 24 Jul 2012 17:51:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Abcxys5rM2eD/RiHL9wGFXQ3rI8=; b=U9D2y/
	jey7SkRhrRfXoXdavKfgquyBl4V2nuZXouYYIxd6Vej4RV2gjw7+fkdX+lZEP12K
	8UABmxXcT3DcMbnDqdH38Eb5lTdy2ArTkfwkoAxXVeDVeXFAWwXuLqzpAp2C4JGc
	UV5If1KjZpVj14MSvSvuYHlJnhotSEW8jdbIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aLdNrfPVDeRkzN/BqwWc3wwuzLaJBohc
	G1Qn16nBT6OTNqj9YG/qoxRGxW7bS0QhB71js4IYURKWFS0/lv0qjItFLjqUUcry
	V6stzUmleh3vDVWMms0nic8JvPxyV4bisUBJZU38iFEfAalDCWnZfv79I9p0r9iV
	9I4vRvaDpKI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAB5882D7;
	Tue, 24 Jul 2012 17:51:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C6A082D6; Tue, 24 Jul 2012
 17:51:38 -0400 (EDT)
In-Reply-To: <500F17A3.60307@pobox.com> (Michael G. Schwern's message of
 "Tue, 24 Jul 2012 14:46:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BEE603C4-D5D9-11E1-B166-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202075>

Michael G Schwern <schwern@pobox.com> writes:

> A big one is "do not blast 10 emails to a mailing list" but I gather that's ok
> here if a submission needs 10 commits to be well expressed and its done via
> git-send-email?  And then if patch #3 needs revision I'm to do it in a rebase
> and resend the whole 10 commits?  Am I to think of git-send-email less as a
> means of sending patches to a mailing list and more as a git transport mechanism?

Yes, yes and whatever (even though I think send-email is just a
better MUA/MSA when you want to send patches and isn't restricted
for a _git_ transport, I do not think it matters how you look at it).

> I'm trying to bust it up into easier to digest pieces.  I came into this cold
> without much knowledge of the problem ("something to do with
> canonicalization") and no knowledge of the code.

Perhaps it is a good idea to lurk and see how others submit their
topics first?
