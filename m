From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Fri, 03 Sep 2010 10:03:15 -0700
Message-ID: <7vsk1qzrn0.fsf@alter.siamese.dyndns.org>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
 <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
 <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
 <4C7FC3DC.3060907@gmail.com>
 <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
 <20100902155810.GB14508@sigill.intra.peff.net>
 <alpine.LFD.2.00.1009021233190.19366@xanadu.home>
 <4C7FDA32.5050009@gmail.com>
 <alpine.LFD.2.00.1009021326290.19366@xanadu.home>
 <AANLkTi=Q7EfeUDB6PuSa88PDtaBZSMMuaMqh8hU25ECb@mail.gmail.com>
 <20100902192910.GJ32601@spearce.org>
 <AANLkTimDi=KYZ7Bs4C+WEGoP8y-yzjynddWpkxohWoix@mail.gmail.com>
 <alpine.LFD.2.00.1009022033520.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Sep 03 19:03:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrZfr-0000qP-L9
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 19:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004Ab0ICRD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 13:03:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39474 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab0ICRD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 13:03:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 363BAD2F6D;
	Fri,  3 Sep 2010 13:03:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HAZ/ZZveHclLhixaaPhWKzCL6EI=; b=w7JFnk
	/Bh+IhJrmtcu+HyJiOvhE/1tIpky5L5tcHFush65YFghluzdGB6udZR3+XdiGeJz
	lys4nw/rsQmnz+0SzvaS10eElOCJbW3dxnQ32GF4DysBLRvR3pirx8CbKcpN+keM
	V3RhaZIvkJJBSofYb+hAskgBa8iIzZLvxQApA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IFgZZaFQ04yiYWJAE+KRRzu/1g7JVRrh
	NSuyyuEUWS4XWzJhwW6uf5TM5BqlZa6p8zEVgNNOKgHxFt31cYUjRl1VlQ9VwGB6
	yZmObVyJLldBD16zB419hGxEmZjgZ0WYfyaqnfBzYjG9+6xs2QHu15WDEXCqj4Vm
	/8ZPQDZ1Jds=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD69ED2F6C;
	Fri,  3 Sep 2010 13:03:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4763D2F61; Fri,  3 Sep
 2010 13:03:17 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.1009022033520.19366@xanadu.home> (Nicolas
 Pitre's message of "Thu\, 02 Sep 2010 20\:36\:31 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 28D31C72-B77D-11DF-B1CB-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155251>

Nicolas Pitre <nico@fluxnic.net> writes:

>>  i can - so that git pack-objects, after "git repack -f", returns a
>> canonical pack! :)
>
> But did you try it?  The -f means "don't reuse any existing pack data 
> and recompute every delta from scratch to find the best matches".  This 
> is a very very costly operation that most people happily live without.

Also "the best matches" will change, hopefully in a better way, with newer
vintage of git.  Optimization like c83f032 (apply delta depth bias to
already deltified objects, 2007-07-12) that is based on heuristics derived
from empirical statistics can and should be allowed to happen.
