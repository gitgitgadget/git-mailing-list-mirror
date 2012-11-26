From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] second try
Date: Sun, 25 Nov 2012 20:50:36 -0800
Message-ID: <7vtxsdvug3.fsf@alter.siamese.dyndns.org>
References: <4EC52508.9070907@tu-clausthal.de>
 <4ED0CE8B.70205@tu-clausthal.de>
 <20111130064401.GC5317@sigill.intra.peff.net>
 <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
 <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
 <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org>
 <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de>
 <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de>
 <7v39c41keo.fsf@alter.siamese.dyndns.org>
 <7vpqf8z8a6.fsf@alter.siamese.dyndns.org> <4F00B7F3.1060105@tu-clausthal.de>
 <4F038E49.9080809@tu-clausthal.de> <7vy5toqqab.fsf@alter.siamese.dyndns.org>
 <7vmwzzqwud.fsf@alter.siamese.dyndns.org> <509FD4F6.5050606@gym-oha.de>
 <50B11AF5.2090701@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Mon Nov 26 05:50:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcqek-0008Pq-Mf
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 05:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908Ab2KZEuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 23:50:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51383 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751Ab2KZEui (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 23:50:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70E8CA450;
	Sun, 25 Nov 2012 23:50:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sn/KmkppVxZAruoBpr8MHKS2gCM=; b=N1rPnI
	xhnbYywM+dBGWPt89WC8emUEImXRecTUgyVQ6Bt7xUOwjRdFdK2rKklrZmLstqck
	zPt0H67GHv9RlSHCbF/kxNae2sBHg+x8lZs+lz96uyAIX8reg8ylZmNoDvbp6AGa
	bJCncVETOxiRvWCpE4clNVpFrPKlZqhh1XLNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AfuKAuL8qtzO5DFv9rax6cUnzLMnW8HP
	b8xsx5J/Exwo/QJMWeI9L4CN4yo10k7mCrJqoVAk0JIoKhV2T0jq4OEnoIlQijrj
	d/JBQARKkDf5snw1TFSH1LmhXLF7m49Hxa2bkKD7sHmA09f0eUsoOk3GHgPG6Txs
	gev0K1XMcrA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E6B6A44F;
	Sun, 25 Nov 2012 23:50:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C285CA44E; Sun, 25 Nov 2012
 23:50:37 -0500 (EST)
In-Reply-To: <50B11AF5.2090701@tu-clausthal.de> (Sven Strickroth's message of
 "Sat, 24 Nov 2012 20:07:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D24DC246-3784-11E2-861D-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210409>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> Am 11.11.2012 17:40 schrieb Sven Strickroth:
>> Am 06.10.2012 20:28 schrieb Junio C Hamano:
>>> It is either that it was simply forgotten, or after I wrote the part
>>> you quoted early in January there were discussions later that showed
>>> the patch was not desirable for some reason. I do not recall which.
>> 
>> I noticed no threads about possible problems, so I try again.
>
> On November 11th I submitted the updated patches again, however, without
> any reaction or comments.

I think between Peff and me it fell in the cracks during the
hand-off; I do not know about the others, probably people did not
find it interesting perhaps?

I'll add Eric Wong (git-svn submaintainer) to Cc.
