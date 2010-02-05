From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] add --ff option to cherry-pick
Date: Fri, 05 Feb 2010 15:45:46 -0800
Message-ID: <7vtytvnt5h.fsf@alter.siamese.dyndns.org>
References: <20100205231028.3689.12228.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Feb 06 00:46:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdXsN-0003cb-9l
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 00:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933961Ab0BEXqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 18:46:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933483Ab0BEXqH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 18:46:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 632BE97B53;
	Fri,  5 Feb 2010 18:46:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HO+PexFKWipLLbaZrHOZ5ibML7s=; b=tR1WVU
	HeFTtCyYiwmN/Ya61h/SEVavgput1lmyTFemPTuTD2tvOygsVxo2M6LxHlLqiD6b
	6/WgUsNPiKrEnuiSbAmIIFBzVjbhhcK6aahWayZlD/enOAhDOWEHqsgvYXwHZGGz
	gD74OfENoAw83fNV9QcOR9TQXwdvP53y1guYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=svNBckBdQPtwTpvT7f3hMuh06FBEXG3L
	rpK4nmhNgU5ZIiXtrJuyOjgHYE1c1C849g2vixgelLgVzhqeKgTvbLlpH8lDx9l3
	bKx4qwD6hiTYKk25doXsxo/a2Hem0fFtpBGVj5rBwJx7ZhVD77HJ08T11zoX9NxM
	Mj8vlCWgqkk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9557397B52;
	Fri,  5 Feb 2010 18:45:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40EB497B4C; Fri,  5 Feb
 2010 18:45:48 -0500 (EST)
In-Reply-To: <20100205231028.3689.12228.chriscool@tuxfamily.org> (Christian
 Couder's message of "Sat\, 06 Feb 2010 00\:11\:02 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9B7105EA-12B0-11DF-9CE8-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139124>

Christian Couder <chriscool@tuxfamily.org> writes:

> Changes since the previous series are the following:

Could you please briefly describe what good does "adding -ff option to
cherry-pick" do in the first place?

IOW, help reviewers to convince themselves that it is worth allocating a
block of time to read through a 9 patch series.  That is what the cover
letter is for.

Thanks.
