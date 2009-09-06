From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/6] docs: note that status configuration affects
 only long format
Date: Sun, 06 Sep 2009 01:04:44 -0700
Message-ID: <7vd464cxcz.fsf@alter.siamese.dyndns.org>
References: <20090905084809.GA13073@coredump.intra.peff.net>
 <20090905085218.GB13157@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 06 10:05:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkCkc-000397-Rl
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 10:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753AbZIFIFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 04:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754747AbZIFIFB
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 04:05:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39081 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754741AbZIFIE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 04:04:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B69CD46BC5;
	Sun,  6 Sep 2009 04:05:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=/5eLn0F2wXBPJIWgd9wRfRIE1is=; b=VCaZb9kWl+SzG1Do0x8ZMSE
	VYEeRWtQLjNFGXqBzFRW/CTO4ySzzHAjsz+BrQxuit6voXbkP3SAJ+RICtjlDsUq
	/BXtSWw2/hwEDO/l+vXgOWKu0NFM48/Lv1cVNawMx0KDV1oPo1q8RTmW4DF3IhgM
	rS5cElf/iorrP2tDbQpY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=aPxO3JekXDODJ/0VFYou62YmHr4KplD8pKafF5rgUFynWimRV
	w6YV1FHzjhuS2vtDLvUXESLJkTtmjCE4c+vLE3eis1fh7hh7aYgIvdM80dW8PhZC
	2YrmuLFV/Vfq+KwzNPkc0Ql6uTBZB6peLqKE1Hv5JmWRvCHXzs/TWdy5xg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6530E46BC0;
	Sun,  6 Sep 2009 04:04:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8FC7B46BB6; Sun,  6 Sep 2009
 04:04:46 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F7259C1A-9ABB-11DE-9E24-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127846>

Jeff King <peff@peff.net> writes:

> Combined with the --short/--porcelain distinction introduced later in
> the series, should short perhaps respect status.relativePaths and
> status.submoduleSummary?

I think that makes sense. 
