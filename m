From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Dropping '+' from fetch = +refs/heads/*:refs/remotes/origin/*?
Date: Fri, 02 Sep 2011 09:14:15 -0700
Message-ID: <7v4o0uncq0.fsf@alter.siamese.dyndns.org>
References: <7vliu8w25g.fsf@alter.siamese.dyndns.org>
 <20110902000039.GB9339@sigill.intra.peff.net>
 <4E6088F9.5070102@drmicha.warpmail.net>
 <20110902152947.GB19213@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 02 18:14:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzWNt-0004Zb-Od
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 18:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137Ab1IBQOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 12:14:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49778 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752963Ab1IBQOT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 12:14:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E59DA4E7D;
	Fri,  2 Sep 2011 12:14:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bSbgLLW0PuXf+4STpFVYTUI0c9w=; b=u5Ko4E
	V8mquWpem4mM2QaRs+mQA5vsO2HScbSj3hvi2S2Fqn4666PdOdLORe0bsDB0fE4O
	FlTOQkodUoadOFQdYGjTfAPzF68t+eaXo/1StGJDJDux+yY4sHxjl/zdshRYxbPu
	OFKBq+Q1mlSzo4vjzbuQbqH+scFjGuXVYKqtU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DHXnr0prE6t2ju2giU8a+pfxe3O4zlBs
	WO20zqqMYFLGKK7R5WEDEF925HmCms5Uw9aPdPPAs0mrnelQ5uHHmSY8Zf72WVi3
	F89snbt59NetutGN5zZnQR1FfQP71Roey+4ryUikyqUmVqNzhGlFybid7uyx9Hr0
	4amLzocl8O4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC0AF4E7C;
	Fri,  2 Sep 2011 12:14:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 567CB4E7B; Fri,  2 Sep 2011
 12:14:17 -0400 (EDT)
In-Reply-To: <20110902152947.GB19213@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 2 Sep 2011 11:29:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B90AA70-D57E-11E0-9C7C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180618>

Jeff King <peff@peff.net> writes:

> [1] My idea of "limited" would be an allow-known-good list of harmless
> config keys which we would respect when they came from the remote, with
> the option for the user to whitelist or blacklist more keys if they
> wanted.

It coincides with my idea too, but it might be a very limited set. For
example, there may be a good "suggested by upstream" default for LHS of
fetch refspecs (e.g. somebody may have 47 topics published but majority of
people are expected to follow only his "master" branch), but it is up to
the user of that suggestion what the RHS would be.
