From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Documentation fixes in git-config
Date: Thu, 01 Mar 2012 08:24:18 -0800
Message-ID: <7vvcmonvbh.fsf@alter.siamese.dyndns.org>
References: <20110108144644.GA11019@localhost.suse.cz>
 <20110111055922.GD10094@sigill.intra.peff.net>
 <20110119100105.GB8034@fm.suse.cz> <20110119141401.GE8034@fm.suse.cz>
 <20110121002716.GC9442@sigill.intra.peff.net>
 <20110121102048.GF19715@fm.suse.cz> <20110121102537.GH19715@fm.suse.cz>
 <20120301081941.GA31079@fm.suse.cz>
 <20120301090828.GA16033@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Libor Pechacek <lpechacek@suse.cz>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 01 17:24:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S38nq-0004Hm-Ed
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 17:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756371Ab2CAQYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 11:24:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45404 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755846Ab2CAQYV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 11:24:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A54971BA;
	Thu,  1 Mar 2012 11:24:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C4yDhmLUkAGVkAjyWtb/Kj0v4aE=; b=cv4vXC
	JdquGDNTbc5PzBW6mCDrgsXfcYIcu5zP//oWq1LPe3y8GKKqUOJPKM4VTOVOFAUi
	EujsQXCk2kRH4puexbJrUwLP9lDqHFtQNRxO7H9A05i6f0aexwW0nPrxdV7zc06a
	zB/dvTUA1/+sMK97TtJN4EK4B9/8al/1QvjCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bgQaC7kQInV++odDD8Cn0TjYiSxbgMsw
	2EuWLtUEldrikk1UjWKc+Adr3BFRUGfxoRxhKS5EBt7pfsBfaom+1lrfLHce9cV4
	O1un94NDxVc/yFER0FF21QdF2px7b71/FC1AfftMks0CdMojhcuREMn6drIAUH5t
	MVWNpQISCMA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71B3871B9;
	Thu,  1 Mar 2012 11:24:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB4AF71B6; Thu,  1 Mar 2012
 11:24:19 -0500 (EST)
In-Reply-To: <20120301090828.GA16033@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 1 Mar 2012 04:08:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF702E2E-63BA-11E1-B6DC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191943>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 01, 2012 at 09:19:42AM +0100, Libor Pechacek wrote:
>
>> Variable names must start with an alphabetic character, regexp config key
>> matching has its limits.
>> [...]
>> This patch has fallen through the cracks, therefore I re-send it.  Previous
>> discussion about this patch is at http://www.spinics.net/lists/git/msg149593.html.
>> The only change I've done since version 2 of this patch is replacing
>> apostrophes with backticks in the first hunk.
>
> Wow, it's been a while. :)

It indeed is.

Thanks. Picked up the v4 patch.
