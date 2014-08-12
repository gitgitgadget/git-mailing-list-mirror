From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: Make git-gui lib dir configurable at runtime
Date: Tue, 12 Aug 2014 09:38:32 -0700
Message-ID: <xmqqtx5h64tz.fsf@gitster.dls.corp.google.com>
References: <1405966809-30882-1-git-send-email-dturner@twitter.com>
	<xmqqbnsiifq6.fsf@gitster.dls.corp.google.com>
	<1405979864.15933.4.camel@leckie> <87tx5k8scn.fsf@red.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	David Turner <dturner@twitter.com>
To: patthoyts@users.sourceforge.net
X-From: git-owner@vger.kernel.org Tue Aug 12 18:38:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHF60-0007oY-7A
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 18:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524AbaHLQio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 12:38:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52411 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753164AbaHLQin (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 12:38:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C28422E2C9;
	Tue, 12 Aug 2014 12:38:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=slYwyx/nAc6nraluve9RbyaeRhs=; b=IE2g8R
	Bh+iBe+MzG3EBRVBcD+hPGQf4BAU9xZmGFsvYFWmDREsNzgZvgwt4eTRAbf5x8B6
	jGzvbKjNVNFKXUkndkU7QQbhaSabyH+N/ii84/3/JAf6GeqtwlPotes2pMadYyuE
	RK3nds3+j0J0/x851kicTwMg3CNv0r17f9KRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MO0iaWCEFA0lryDv6QBMpnVTwpZQBozL
	Jcw2WJYVcWTpG0XUu3cKKXSlkSrmPiznmuBozc3OzEm1+KVbqoqA7jHk4OZhf7Of
	/tRUu1Z76ExmdktA/8A0TVe8u7ekQvTGRARqihZzREOgbjRNAFUv4hptglU47nXH
	C1CK7ub0FRU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B89E02E2C8;
	Tue, 12 Aug 2014 12:38:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C07962E2C1;
	Tue, 12 Aug 2014 12:38:33 -0400 (EDT)
In-Reply-To: <87tx5k8scn.fsf@red.patthoyts.tk> (Pat Thoyts's message of "Sun,
	10 Aug 2014 13:03:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 19BBE6CA-223F-11E4-8809-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255154>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

>>Pat, do you want patches via the git mailing list, personal mail, or
>>some other way?  
>>
>
> The standard method is both: personal to ensure I see it and mailing list to
> allow everyone to comment.
>
> I've applied this patch to git-gui master.

Thanks, both.  Is it a good time to pull the changes from you to be
in the final 2.1 release?
