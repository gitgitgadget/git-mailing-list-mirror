From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] mergetools: split config files for vim and gvim
Date: Wed, 28 Mar 2012 13:53:08 -0700
Message-ID: <7vr4wctpl7.fsf@alter.siamese.dyndns.org>
References: <1332964693-4058-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 22:53:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCzrp-0000WI-5M
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 22:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932877Ab2C1UxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 16:53:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38903 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932847Ab2C1UxM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 16:53:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4BA76834;
	Wed, 28 Mar 2012 16:53:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GZ/kE8A4I7pJ+vsYMzHKp0yf23E=; b=atdAfz
	BsspB4myutgyPt3Ur3mTxTNMIHNZE6bFPfq6gLWrej50n8J+5SC88mYzZRpAzrX/
	HHKhqPABTid4TW9Q3rTy915zV0Lsrco1PKWTHFMh8lfWhCD3kNDH0NHWFJRHNVjW
	1y4BSbpsiQzkakfedHE9tX+oR2C7YL7kuFb/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f71lsBt4OzZAdWrMp7HCPKGvY7sfTSCy
	S32JwLsfq0Aa8gaB2HN7n76JOenMUZcP9gRHEsooZIhZCmxsJfftwoDgzd4DzOWv
	DcREbAasZomAVQgjEIRNAGFy1y/LXso17fHGsmG8NUDOonxjaPyVH4DtpsIQU3GZ
	HvufftkwWww=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC4B26833;
	Wed, 28 Mar 2012 16:53:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50CF36820; Wed, 28 Mar 2012
 16:53:10 -0400 (EDT)
In-Reply-To: <1332964693-4058-1-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Wed, 28 Mar 2012 15:58:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 071E186C-7918-11E1-9042-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194196>

Tim Henigan <tim.henigan@gmail.com> writes:

> One side-effect of this change which may be a problem is that we
> lose support for the 'vimdiff2' and 'gvimdiff2' tools that were
> created in 0008669 (mergetool-lib: make the three-way diff the
> default for vim/gvim).  The 2-panel options were not advertised in
> any way, so I don't know if it is important to keep them.

By default, anything we support is important unless there is a sound
justification to say otherwise.  I think they were kept for people who
were already used to the 2-pane version when 3-pane one was introduced.

But I will not be a good judge for this particular case, as I do not use
vim nor gvim for merge resolution.  Davidd?
