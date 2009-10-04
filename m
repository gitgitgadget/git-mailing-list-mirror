From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Interim maintainer tree
Date: Sat, 03 Oct 2009 23:06:30 -0700
Message-ID: <7viqevu1zt.fsf@alter.siamese.dyndns.org>
References: <20090925160504.GW14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 04 08:17:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuKPJ-0007uH-Bj
	for gcvg-git-2@lo.gmane.org; Sun, 04 Oct 2009 08:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbZJDGHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2009 02:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbZJDGHs
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 02:07:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56909 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbZJDGHr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 02:07:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 563E86AC12;
	Sun,  4 Oct 2009 02:06:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bozTYlw7pPqc3WAPr9MBoNdvx1E=; b=V6izIS
	Sy0YhsSQ3ivNciYwRxaaJIpwr8W4i/VOBmIyc3QYgUbmL1nY0eP56MgUx+YFcFPQ
	Jf5wvd3+Xw61c+asyFJdHlvxsDCuSbyFPR16QSPIxQ0qn7lcT8ZAIqAea3Brvz1Z
	U5EtDG9HJU3jlfsJnXPq6Why1lq4hJofWq3C0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q1sDQHLptyKA3n/yHkWgXSmAyOpKG9GI
	kNX6zkFsIAlo+Ld1B1I6nddMkT+OHr/toM1x034hY5Rg1B2BcU+gRVNKfwAx1eX5
	dWMc+nQGys/OdjsEp1U5jTQniyyDCnXu+Rl++76c5OofCpCvbUNA+XueLdQJiyeW
	oPtl81TZL/I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D4A86AC11;
	Sun,  4 Oct 2009 02:06:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BDFBA6AC10; Sun,  4 Oct 2009
 02:06:31 -0400 (EDT)
In-Reply-To: <20090925160504.GW14660@spearce.org> (Shawn O. Pearce's message
 of "Fri\, 25 Sep 2009 09\:05\:04 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 133E3B72-B0AC-11DE-9C39-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129508>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio is on vaction for the next week.  In his absence Peff and I
> are trying to keep up with current patches in my fork:
>
>   git://repo.or.cz/git/spearce.git
>   http://repo.or.cz/r/git/spearce.git
>
> Right now the tree matches Junio's last push, I'll try to pick up
> the patches since then and push later today.

Thanks, both.

I've fetched, but haven't fully examined "log ..spearce/*" nor "log ..peff/*"
yet.

I noticed that some topics in 'pu' have been rebased (not complaining, but
just making sure I am not hallucinating).

Do you have preferences/suggestions as to how to proceed?  Should I just
take the tips over at this point, or do you have some more patches you
were polishing but haven't pushed out that I should wait for?
