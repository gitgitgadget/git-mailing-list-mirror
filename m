From: Junio C Hamano <gitster@pobox.com>
Subject: Re: obnoxious CLI complaints
Date: Sat, 12 Sep 2009 19:47:21 -0700
Message-ID: <7v3a6r5znq.fsf@alter.siamese.dyndns.org>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
 <m3fxavvl5k.fsf@localhost.localdomain>
 <ef38762f0909091709t7336d86dkd2f175e5b3a6a3f@mail.gmail.com>
 <20090912103156.GA30385@dpotapov.dyndns.org>
 <43d8ce650909121132n76cda485ycd53a0497e397960@mail.gmail.com>
 <20090912214428.GB30385@dpotapov.dyndns.org>
 <43d8ce650909121521m3dbac12co7f5f2dcaf15190e7@mail.gmail.com>
 <20090912224335.GC30385@dpotapov.dyndns.org>
 <43d8ce650909121608t2b9c4b9bw44104acceea26e12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Brendan Miller <catphive@catphive.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 04:47:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmf7v-0007nZ-SJ
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 04:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794AbZIMCrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 22:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754771AbZIMCrf
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 22:47:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47694 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754670AbZIMCre (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 22:47:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 26A3F4E5B6;
	Sat, 12 Sep 2009 22:47:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LCoVxyFb3zVlEEa2Oc5UC9lpRjA=; b=m7iFk6
	EotBzQf1mkiCt7up0wY8Dp9gjuAvuFhiguAI19Mri7bP9f2pcYDljaXLzerZDr3X
	p2vLmmCo1Hq0rcWTETNCSCGJSeCzPN7JTs17TRQ3ab9SlI3gXbAk5+Asz8x6euWf
	tnz+x9Wi1+pMO1lXrGmGai5k0dH9nBQIQpo5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kaFR6+b4VnbPtb2uq96JJ7lm9vy8FDsD
	WgEH1vK+5CZegr8wLScVTLvCX9LZLk+SpZsxLKyXmgCdWmAorU3CZpxDnyezDO9n
	rNQS/0oY0R3V2QQhlBcZWuUJoRNT7lj47126xWbM46h89pdDPmIhOsus3ZU5O5Bh
	CiqlfzTgrXM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D31014E5B4;
	Sat, 12 Sep 2009 22:47:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CE7224E5B1; Sat, 12 Sep 2009
 22:47:22 -0400 (EDT)
In-Reply-To: <43d8ce650909121608t2b9c4b9bw44104acceea26e12@mail.gmail.com>
 (John Tapsell's message of "Sun\, 13 Sep 2009 02\:08\:50 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C931EAD0-A00F-11DE-9FA6-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128326>

John Tapsell <johnflux@gmail.com> writes:

> Ah, the manpage examples specifically give the --format=tar though.

So what?

> Why not have  --format=tgz  then or something?  Or better yet, give
> the filename on the command line and detect the format from the file
> extension.

That is an interesting enhancement and sounds like a useful feature.
