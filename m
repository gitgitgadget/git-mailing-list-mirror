From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-add.txt: Explain --patch option in
 layman terms
Date: Mon, 31 Aug 2009 16:42:16 -0700
Message-ID: <7vmy5fy2hz.fsf@alter.siamese.dyndns.org>
References: <87ocpxb46g.fsf@jondo.cante.net>
 <7vab1hdppb.fsf@alter.siamese.dyndns.org> <87tyzp9da4.fsf@jondo.cante.net>
 <7vskf954sr.fsf@alter.siamese.dyndns.org> <87ab1gaol2.fsf@jondo.cante.net>
 <7vbplw28js.fsf@alter.siamese.dyndns.org> <87y6p08lz5.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Tue Sep 01 01:42:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiGW7-00041R-FQ
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 01:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbZHaXmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 19:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbZHaXmV
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 19:42:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48810 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbZHaXmU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 19:42:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 08E9320C1F;
	Mon, 31 Aug 2009 19:42:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Dpz+WMr+Vw0A+aI4TgJfA0W+mrs=; b=XPQJMW8XuZzgTWfHUXcYvC9
	ouEdMxb6sJMiq6RWt7f9+Qe/kzUujBastzpIDF3YwNU/A8PyIKHHw+f/Hlg5iJvm
	miPEolvgFa29lQW9e2RjVmuFwu0B1SJLVRanpVdTv7kgrWGK+K2R1BNSP2xVHEZq
	BQyjucvTZTHw8GI5auCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=B0rGRqCPlsFenwzqm5QJrTmxAX//RtIDezKGu6adbq6J/RZ47
	dWGjEAeTkwUfcBqFtpx8WrFL3i355n1EfKn5in2gyHARIzW70Plnp1fZeK5Waj5B
	hw5zRX+L0Q5T7v3gYfXRkF3z1jO29bTt5Yq4A/P6GTNxRYkajvN2laAVeM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D95BC20C1D;
	Mon, 31 Aug 2009 19:42:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FA7820C1C; Mon, 31 Aug
 2009 19:42:18 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ECFF810C-9687-11DE-BDD0-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127508>

Jari Aalto <jari.aalto@cante.net> writes:

>     --patch:
>     -p::
>         In a modified work tree, choose interactively which patch hunks to
>         add. This gives a change to review the difference between the
>         index and the work before adding modified contents to the index.

Sounds sensible.  You may want to be even more direct and succinct, e.g.

    Interactively choose hunks of patch between the index and the work
    tree and add them to the index.
