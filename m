From: Junio C Hamano <gitster@pobox.com>
Subject: Re: misleading diff-hunk header
Date: Fri, 24 Aug 2012 21:29:56 -0700
Message-ID: <7va9xjy4or.fsf@alter.siamese.dyndns.org>
References: <503385D0.5070605@tim.thechases.com>
 <87a9xoi82i.fsf@thomas.inf.ethz.ch> <5033AC55.8080405@tim.thechases.com>
 <7vfw7gdtfg.fsf@alter.siamese.dyndns.org>
 <20120824142908.GA15162@sigill.intra.peff.net>
 <20120824164415.GA23262@sigill.intra.peff.net>
 <50381F52.9030007@tim.thechases.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 06:30:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T580f-0007oV-Gf
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 06:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933Ab2HYEaC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 00:30:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47728 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830Ab2HYEaA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 00:30:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EB649D11;
	Sat, 25 Aug 2012 00:29:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=erzE7MhJg38fPdwzpEqNrfzI6UU=; b=tysXqf
	JYjjTJlsXrL+S7+C3TqpT+nqs5eZUR3MifAZCy4334TtsrBb2E+MEf7ZX8Yzktwm
	a+J8EraSeaAL+TwKWdNhr3W0FH0AWFDerfsUmHqVVO7FkYFLOx+ykGkMCRZmZ5S/
	//FSY8D5AF5r5ocCOPag8OxMA3sCcVczODGO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dMp/Ya/6AszxQPTlOXjLP78aA5tFBZ7A
	e0VwO+HgEAR78tvm9V/CfGwEcpjQ5Pj7UzUxxZgHA4NSSBGtVIMlRXZwHfHY4BOM
	KTUqSAokA+fiF7SK6QBXbbNIIQAZB6fKkAs2PkqqaR9ahnEmIVNBNBWY15mOfQnv
	jNaY6rz0z2k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D3B19D0F;
	Sat, 25 Aug 2012 00:29:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 969CE9D0E; Sat, 25 Aug 2012
 00:29:58 -0400 (EDT)
In-Reply-To: <50381F52.9030007@tim.thechases.com> (Tim Chase's message of
 "Fri, 24 Aug 2012 19:41:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8746DF68-EE6D-11E1-8A19-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204245>

Tim Chase <git@tim.thechases.com> writes:

> If the documented purpose of "diff -p" (and by proxy
> diff.{type}.xfuncname) is to show the name of the *function*
> containing the changed lines,....

Yeah, the documentation is misleading, but I do not offhand think of
a better phrasing. Perhaps you could send in a patch to improve it.

How does GNU manual explain the option?
