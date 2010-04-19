From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote add: add a --no-tags (-n) option
Date: Mon, 19 Apr 2010 14:52:14 -0700
Message-ID: <7vr5mbp0tt.fsf@alter.siamese.dyndns.org>
References: <20100419135014.1077.28627.stgit@localhost.localdomain>
 <7vvdbnqpis.fsf@alter.siamese.dyndns.org>
 <2010-04-19-22-19-11+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Mon Apr 19 23:52:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3ytL-0006du-2l
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 23:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004Ab0DSVwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 17:52:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35737 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab0DSVwV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 17:52:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F87DACB2B;
	Mon, 19 Apr 2010 17:52:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UCc3eRtlnMRo1qwt92vUFbFkMuQ=; b=SjMCrN
	RnDOoJVpg4yYAchU8bC32YaaT3rQ5jFnO8eFP1SuD+0Cel6AA2Fcyy5aFV0HRiUe
	Wb69O/Ud/KcKAGue/JjtWhioNEJ3ZvedomR2ysi7LeJaDoUKLKf1hqGAIc7aZOPH
	eFg+vMNud7HYYiT89HoyrP2nQgBoVoT6Zbpjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YwnCh9qrszODJg7DFrvZe+eNyK06TL8q
	kTbBHm7ZUfNqZHcVCXolYCy2yA5Ya1/4RzX+lRKxcTjcdc/6pgcAjMlvf3sCVGoI
	IsxOR8IT2mknBdbPy+oNYQbgE1CNuc29fBk6wq0jpN2IfrS3VIxQWJq42SkF+ry0
	I1M1PneO/XU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D6EFACB28;
	Mon, 19 Apr 2010 17:52:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA027ACB26; Mon, 19 Apr
 2010 17:52:15 -0400 (EDT)
In-Reply-To: <2010-04-19-22-19-11+trackit+sam@rfc1149.net> (Samuel Tardieu's
 message of "Mon\, 19 Apr 2010 22\:19\:10 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D3B19DA8-4BFD-11DF-979C-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145333>

Samuel Tardieu <sam@rfc1149.net> writes:

> I don't think we need to add "--tags" to "git remote add", do you? If
> you do, this is not difficult to add using the "git fetch" logic you
> describe.

I actually do suspect that would make the interface more consistent.
