From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] Provide a build time default-pager setting
Date: Fri, 30 Oct 2009 15:59:43 -0700
Message-ID: <7vhbtgfpy8.fsf@alter.siamese.dyndns.org>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>
 <7vskd3o11t.fsf@alter.siamese.dyndns.org>
 <20091029073224.GA15403@progeny.tock> <20091029075021.GC15403@progeny.tock>
 <7v8weu6idl.fsf@alter.siamese.dyndns.org>
 <20091030101634.GA1610@progeny.tock> <20091030103925.GI1610@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 00:00:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N40Rx-00021s-1j
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 00:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933045AbZJ3W7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 18:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933040AbZJ3W7y
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 18:59:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933028AbZJ3W7y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 18:59:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FCBC6D7FC;
	Fri, 30 Oct 2009 18:59:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mq3xIhHsTNPIMnxD/2mjLVP8Xa8=; b=rLOoAs
	mgHATSwxEoBIxBjkxTuKlAQ/mTRLN0RIWsoGkVFgDbB/qDdBZtNqcD4Ue5mmD/Zh
	LP5zJEr5LyUk1+d6k6bJh4zkVtRd8ZoMh9BUPzsBW56xFlSIxSLGo1qDjqAYMVlD
	NOZmMeXqbAdhdYLmG3s+8cxQ1i2ROfp/2bMXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BRiNG57Ns9taCh26Vyok/6F0vqWzJsPu
	CxzX3hFlg6rXNlRDyom3KA0IhE8AGLTnifKd9Hl39OCvr+2V51fZJBkWkmvAv6x5
	XODB+AOwRrwMpkRyox334dHA/d27ziz6F1TOe8rIzYDQHthC3aIgg5k2eNNBhiyC
	kltKAY7nMlQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D1CC6D7FB;
	Fri, 30 Oct 2009 18:59:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD1A56D7F8; Fri, 30 Oct
 2009 18:59:44 -0400 (EDT)
In-Reply-To: <20091030103925.GI1610@progeny.tock> (Jonathan Nieder's message
 of "Fri\, 30 Oct 2009 05\:39\:25 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EE8C9196-C5A7-11DE-92D6-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131774>

I'll queue these for now probably on 'pu', but with the comments we saw on
the list expect them to be followed up with replacement patches.

Thanks.
