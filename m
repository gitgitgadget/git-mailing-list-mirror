From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Thu, 04 Feb 2010 16:55:09 -0800
Message-ID: <7vaavosdqq.fsf@alter.siamese.dyndns.org>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com>
 <7v4olxhrti.fsf@alter.siamese.dyndns.org>
 <201002041821.22864.jnareb@gmail.com> <201002050144.50538.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 01:55:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdCTt-0000ns-2P
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 01:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933581Ab0BEAz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 19:55:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36369 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933576Ab0BEAzX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 19:55:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A2742965F7;
	Thu,  4 Feb 2010 19:55:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FmxWz7RdhARUYi8W8z/IeCVuM+4=; b=OOFEwf
	D4vWqwhxyoYxEfLmcUs7ONY6iEQGOIlfiqIxbQ8A966vCl+OB/su9p3hGyUBq5L1
	TT/yRP2gGbvHWvLDKnHQ8Aujmm1+UfEXqramDcIpgne2b6A32OIaAuVuLiUYRn0b
	DEDAGrZC1hwyouCEpC183s4fjRMKqOHZtl/O8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s7U/kc6Bh27qCV7tH0rN5h2QzBxx/g/m
	Z/s3gdAgBSopifvfEVryfj8FBaw4uQZlx6nuHzJoGQj5XkIlvUZh1tAU8mLdzw18
	8Ok9sXtiON2G0ZlT/kpqF0nQS86ugMHmErYAhgx7bO7kGw+KjnfQ/dOjee2dASng
	OLjH1OmCceY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E238965EE;
	Thu,  4 Feb 2010 19:55:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42677965EC; Thu,  4 Feb
 2010 19:55:11 -0500 (EST)
In-Reply-To: <201002050144.50538.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri\, 5 Feb 2010 01\:44\:49 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 205D5986-11F1-11DF-A24C-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139017>

Jakub Narebski <jnareb@gmail.com> writes:

> Still, 1 or 2 git commands per commit is a bit too much (with shortlog
> displaying 100 commits per page)

But who said you need to display notes for all commits by default?

It could be a thing that you would get _on demand_, just like patch text
or diffstat is given only on demand by going to the commitdiff page.
