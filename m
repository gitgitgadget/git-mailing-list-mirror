From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Redoing a merge for a particular file
Date: Thu, 07 Jul 2011 17:37:49 -0700
Message-ID: <7v62ndhajm.fsf@alter.siamese.dyndns.org>
References: <CAFOYHZCFetkokgtn4z0O3nPTEy6GCTEcN0Pzc8ce-joqMzZM1Q@mail.gmail.com>
 <20110707224114.GA23273@sigill.intra.peff.net>
 <CAFOYHZBBtqK2VtZ-Bq3uMAhGD4esSz7JDJn_4xaKb4y8wt9LJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 08 02:38:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qez4v-0006HR-Ez
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jul 2011 02:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830Ab1GHAhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 20:37:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59453 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab1GHAhw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 20:37:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4DDCB66CE;
	Thu,  7 Jul 2011 20:37:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kn3Prd95VCja5JP79Yj0pi+R1sY=; b=m75Pfw
	dipR/qci3lwYukI4lmP5z9OBhhh2kLEUL/KA2FnI1WUolt/dO0sHE/+N8ylzRBe/
	vGtR5truFcR9MGi5ikMVzdRbIeB+Qxk9p+glBv45URVolVn0xhZvT31fkeLCnAdC
	cxkjOZHvDu9bT3BLQJyaMPaQ9GNXg8NRUUGxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f22Rlg8DJ3S7io3kgyRcPPu205kzC2Eo
	Api6OpuurP7KBhKbZtQ0lXjNhZeNOwW3604ykbxy8KnHiPF3Oun1Jc2BYDpqLbtq
	MsKI/cV6BJAldp3bhqctgnzAylosQ4CEz/MZbko5+jQkaqgbVZJByTAqj+zukvI3
	UK6rh2LbfwI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4698B66CD;
	Thu,  7 Jul 2011 20:37:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A2D5B66CC; Thu,  7 Jul 2011
 20:37:51 -0400 (EDT)
In-Reply-To: <CAFOYHZBBtqK2VtZ-Bq3uMAhGD4esSz7JDJn_4xaKb4y8wt9LJA@mail.gmail.com> (Chris
 Packham's message of "Fri, 8 Jul 2011 11:31:41 +1200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8326BA0C-A8FA-11E0-B099-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176794>

Chris Packham <judge.packham@gmail.com> writes:

> Perhaps checkout --merge <path> should automagically tell rerere to
> forget about the path?

NOOOOOOOO. Please don't.
