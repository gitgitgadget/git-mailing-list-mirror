From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] fmt-merge-msg: hide summary option
Date: Wed, 24 Mar 2010 19:45:16 -0700
Message-ID: <7v4ok5dsqr.fsf@alter.siamese.dyndns.org>
References: <1269414964-9518-1-git-send-email-bebarino@gmail.com>
 <1269414964-9518-8-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 03:45:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nud4g-0001NK-Mr
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 03:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469Ab0CYCp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 22:45:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51168 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab0CYCp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 22:45:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BF63A56E2;
	Wed, 24 Mar 2010 22:45:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0mSC7dHmWc9Mba85Zh0e6B7wy6I=; b=tc6za4
	k/ADh2WnYIAAFPtKiF7YJcMx82BqJL0i6CAiD/ENvxmV3ER3iBaoIKEuyXSAweq1
	GhJbvjmGu1DihXdl20xBZTBnOETvFLe4raXFdNCS1r0ROR15hSii+Ik4CwJRkBT+
	BDCVtJC/ygBGC9oFEDDloxPnAqRnM9NUO7yJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BVR5QZJUsD7lQJKQDM1LW6jL9gZV0B2h
	qJy5Qj3qsEcqAhcck20mBWee/X3K23ONcoaqjzDR4u6n0Jk1lX++ATw++F29tuQ+
	Pl8xmCqbf6yMmSeXELypHcJdgTPzzXaRBFS5zNVWmFnvu9k7Jq6ISF0h007lICs+
	Oe/Vx6670sM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7218AA56D8;
	Wed, 24 Mar 2010 22:45:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2750A56D2; Wed, 24 Mar
 2010 22:45:17 -0400 (EDT)
In-Reply-To: <1269414964-9518-8-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Wed\, 24 Mar 2010 00\:16\:04 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 764A977C-37B8-11DF-9BE0-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143144>

Stephen Boyd <bebarino@gmail.com> writes:

> When is this option going to be removed? It's approaching 2 years
> since the deprecation occured in 6cd9cfe (fmt-merge-msg: add
> '--(no-)log' options and 'merge.log' config variable, 2008-04-06)

We could do that sometime in this autumn timeframe if we start making
noises when they are used, just like we did during the 1.7.0 transition
against soon-to-be-deprecated "features".

Are there other ancient features we have been passively advertising as
deprecated that we should now start the removal process?
