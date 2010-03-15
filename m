From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add core.trustlowlevelstat for diffs in dev,ino,uid and
 gid
Date: Sun, 14 Mar 2010 23:50:38 -0700
Message-ID: <7v1vfm9iyp.fsf@alter.siamese.dyndns.org>
References: <1240743317-10117-1-git-send-email-robin.rosenberg@dewire.com>
 <alpine.LFD.2.00.0904270757410.22156@localhost.localdomain>
 <86skjudr6u.fsf@broadpark.no> <201003142151.29969.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kjetil Barvik <barvik@broadpark.no>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Git Mailing List <git@vger.kernel.org>, spearce@spearce.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 07:51:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr48m-0001Ys-TO
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 07:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759623Ab0COGu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 02:50:57 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62252 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758806Ab0COGu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 02:50:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B710A153D;
	Mon, 15 Mar 2010 02:50:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=pEP/g4CT/dnMQ+SzeI2cfhllfWY=; b=EEdvH/jPNvYWjHhqrGm4Q99
	A5RkpCGM4p3oFHJ8yKiMsQnWmdXY0tGfXqaBcQeZOv0PibZJmutEaHnfddSpE8pf
	nhTpYk2qLIAu95q2V+mipDiYpFDjuF2TDOnKa0d510Ry8ws6abkPe5hsiiogYkrk
	1i0Whg8RNcODfFct1sLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=KAVgUSRWi8ZVo9PuQtURaXvuu2bObykDoQ1vYDhYgzMzwRac8
	H7etfvRq1gTN/L7O6O+PwYcqJAfgwXGyyhDj0KFgdH7xtc13y5T4drW+4eGkTPNG
	MhnZJBRnd+RFilxfno5e4U6t7wnmyHfmPO3ZsSeVBmKUzBftdSa+tiZIKU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E7974A1538;
	Mon, 15 Mar 2010 02:50:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5BCFA1533; Mon, 15 Mar
 2010 02:50:39 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 16251568-2FFF-11DF-A933-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142174>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> Did something pop up that I don't know of that prevented inclusion of this 
> patch, other than the NSEC option, or will it do if just refresh the patch?

I think all of us liked the general direction, and also all of us agreed
that we would want to keep NSEC support that was removed by Linus's patch.

Nobody had time or inclination to update the patch to implement the
consensus (I still had the thread in my inbox, by the way).  So "just
refresh the patch" would be the necessary first step.
