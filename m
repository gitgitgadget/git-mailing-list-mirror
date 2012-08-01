From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rename detection
Date: Wed, 01 Aug 2012 14:07:10 -0700
Message-ID: <7vtxwme2yp.fsf@alter.siamese.dyndns.org>
References: <501799CF.1080100@keymile.com>
 <20120801203941.GA11940@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerlando Falauto <gerlando.falauto@keymile.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 01 23:07:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Swg8Y-0007ta-Ay
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 23:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936Ab2HAVHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 17:07:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48056 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753825Ab2HAVHO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 17:07:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06EB687EB;
	Wed,  1 Aug 2012 17:07:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v+pOXur31vLe4J/clo6OxYnW6AA=; b=Lys4Qx
	xfjkbWTwwGEc3SY6z5daWFmgkKvXIqY+pC3DTAdeCNl7UcN6kwrYF7pWqYfYowfl
	dW1io83UVdWWnsIBSWVqa9MQfmnE0hQ1cJE47YCyMVOXnVtuOMnrERXTNoY3lFoh
	/zz8bvljHdY9zozkdsnExF6v0hL11PamEe/A4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FEMFGJ0EAwbQxZcsHtzgsbl35fqPxd/d
	AIwJE9Cso4/OgHMN46g/1dDtzISYS34oakaYp8IBWP8UsoXzK1dSd6EmsDH5Xi92
	w+da1eLr1KDgk0tu4XYzU3x1cdKs0tb06UhgHN9nAIKGjsFbk9zdD9/14DTe43VE
	BNjSarpg6xI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFBBE87E8;
	Wed,  1 Aug 2012 17:07:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A02B87E6; Wed,  1 Aug 2012
 17:07:12 -0400 (EDT)
In-Reply-To: <20120801203941.GA11940@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 1 Aug 2012 16:39:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DCF12ED6-DC1C-11E1-ABBA-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202724>

Jeff King <peff@peff.net> writes:

> Hopefully the above has answered these questions for you.
>
> However, I hope it has also showed the limitations of pure file renames
> when you are looking at content movement from one file to another.

Nice write-up.

Care to save this somewhere more permanent (e.g. git.wiki.k.org or
Documentation/), after rewording the above to make it more clear
that the "limitations" you mention does not have anything to do with
Git, but is a fundamental flaw in thinking that it is somehow useful
to track that "file A was renamed to file B"?
