From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-curl: Fix push status report when all branches
 fail
Date: Thu, 23 Feb 2012 11:11:54 -0800
Message-ID: <7vhayh4b5x.fsf@alter.siamese.dyndns.org>
References: <8739bacpql.fsf@thomas.inf.ethz.ch>
 <1327079011-24788-1-git-send-email-spearce@spearce.org>
 <20120222101302.GA11606@sigill.intra.peff.net>
 <CAJo=hJsFDrt4rsxVAnx86bxZDY3yfWc1=GDd8opUU+9z7esLnw@mail.gmail.com>
 <20120222204050.GB6781@sigill.intra.peff.net>
 <20120223100434.GA3083@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 23 20:12:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0e5C-00078t-2l
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 20:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754675Ab2BWTL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 14:11:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43193 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754200Ab2BWTL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 14:11:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 475EE6D21;
	Thu, 23 Feb 2012 14:11:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=hU9ckE
	CeO4F0hfNhL4GHBvTi3YEwgn00GAfURXagLYCQZSIQAptmhtl6t3bHfqM5RJV/WF
	3dS/z1IYFLNPwl94ZTAoNM1DpvPOKzS211cgAe4/PhoxkIVv3QvhO/KzS2c6O5TS
	WBRCfMEIQUrJ+s/o6dWg65xxlFhDTrcW9orAs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fjjLkeu8SgVKHygW+CgiZsy6vSZvmX9f
	BZhImcg5DhuZq3cFnLz7lYkJmnHYxJlCkoCBseb9PM+irXDu3g1tqMdNzpeodq3k
	GIlsIB0aarLePNSkC3su4yitumLhGSHqBmAyWZLmrDeApJ8SkzWhN+OglKz4vgUf
	kKo30AK6nXI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CAB46D20;
	Thu, 23 Feb 2012 14:11:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C67696D1E; Thu, 23 Feb 2012
 14:11:55 -0500 (EST)
In-Reply-To: <20120223100434.GA3083@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 23 Feb 2012 05:04:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4060A63E-5E52-11E1-9E53-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191385>

Thanks.
