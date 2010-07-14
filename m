From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] add basic tests for merge-tree
Date: Wed, 14 Jul 2010 09:26:46 -0700
Message-ID: <7vwrsyxc55.fsf@alter.siamese.dyndns.org>
References: <1278854215-9022-1-git-send-email-wmpalmer@gmail.com>
 <1278854215-9022-2-git-send-email-wmpalmer@gmail.com>
 <7vaapv0xin.fsf@alter.siamese.dyndns.org>
 <1279090893.2789.21.camel@dreddbeard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: wmpalmer@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 14 18:27:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ4nT-00035o-J7
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 18:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756369Ab0GNQ0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 12:26:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55006 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236Ab0GNQ0x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 12:26:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 24B9DC41EA;
	Wed, 14 Jul 2010 12:26:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8c5jhd+oz28MHa1t3UmCBWxXkGA=; b=nyHL04
	zL8MPgzZi0fFl5EaNTbYTX1uvPPMN6GAGA7zFGVOn5yw/tjMQmQP1/ip79z6yung
	+eLDTRbmDCP0345RQDM9fHYaTVwianCmFTUa/o8ch0nSAiU77TvTp3YdQqYZLIQh
	GuiQmJerAQno1/5CkVZ2Izv/Azipbfmx+/IYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L/P2ZeqPaP0RNz2ckz+mY8gOIX/TqnhN
	zztzbt+RoNZ0EamxiapcdjYZd2XC7v900oRrnvNz6PnKkl5+lPZcKYSZ13+laSPI
	vmcIEOdcKOGtsino6JuEK6OMkfyYslVSzZ+iNdautkYZu+N0EpbXCgNbHE+8sc7k
	o5sKyPcKFZg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DC992C41E9;
	Wed, 14 Jul 2010 12:26:50 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09F13C41E0; Wed, 14 Jul
 2010 12:26:47 -0400 (EDT)
In-Reply-To: <1279090893.2789.21.camel@dreddbeard> (Will Palmer's message of
 "Wed\, 14 Jul 2010 08\:01\:33 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9B42251E-8F64-11DF-9537-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151006>

Will Palmer <wmpalmer@gmail.com> writes:

> However, merge-tree has a function similar to diff (it shows differences
> between trees) and apply (it creates the "result" object when there are
> no conflicts), and its purpose seems to be more of a "shower" than a
> "do-er" (contrasted with something like git-merge, which actually
> creates a commit object, for example), so I thought that diff-commands
> would be a good classification.

Ok, that makes sense (I haven't heard anybody use merge-tree in real life,
though).  Let's keep the numbering as-is.
