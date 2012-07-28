From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] log: remove redundant check for merge commit
Date: Fri, 27 Jul 2012 22:58:55 -0700
Message-ID: <7v7gtoxw80.fsf@alter.siamese.dyndns.org>
References: <1343409699-27199-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1343409699-27199-3-git-send-email-martin.von.zweigbergk@gmail.com>
 <7vfw8czvj5.fsf@alter.siamese.dyndns.org>
 <CAOeW2eFROgZ+taqFvCHoSTVrQZnaQZo567e=73BcA+d5uSjKDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 07:59:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv03M-0007tj-1e
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 07:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823Ab2G1F66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 01:58:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44897 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751661Ab2G1F66 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 01:58:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 280F346B1;
	Sat, 28 Jul 2012 01:58:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=haxa93iVk0Ht/50kMDFUVRBQdWU=; b=b9L9AZ
	eB16N8minyJXrZl51Y3H4H9F7kTkHjk6DYRPI59XuIlK4ds84BmUG2M5MFoLmCbk
	Ir97gxsKrTrpxoacBHb61LFNTwh34q/3cDdK65oUWQUXvh2P0UQTyiQVFpSMqgid
	T6PaTjFcOHAB3bg/6kLjeeQizqpruW6H+Od3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZKauHoG3nz2pxnG2uw5lRvSBbobZffOB
	1fq8t63J5Llq+BrI/pOuJRwVxbDO/tTGKQ+5SoAlQ3DhY5yzwpYNOw4rrhh6bQNz
	fx06RCzQeq9mx9XVtk2tqy25UdgZr6rzAE4Esx2rKrjEfCFGXL0FypZ2ZrN8X/rA
	w2uu8qyjHs0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15BD346B0;
	Sat, 28 Jul 2012 01:58:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BD6546AF; Sat, 28 Jul 2012
 01:58:56 -0400 (EDT)
In-Reply-To: <CAOeW2eFROgZ+taqFvCHoSTVrQZnaQZo567e=73BcA+d5uSjKDA@mail.gmail.com> (Martin
 von Zweigbergk's message of "Fri, 27 Jul 2012 21:52:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5161518A-D879-11E1-87E8-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202405>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> Do you want a reroll with updated commit messages (the missing "avoid"
> above, the dropped "seems like" about the prefix in 1/2)?

Nah, I've already queued them with log message tweaks.  Thanks for
asking, though.
