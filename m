From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merge seems to overwrite unstaged local changes
Date: Wed, 28 Sep 2011 08:25:48 -0700
Message-ID: <7vaa9o1yf7.fsf@alter.siamese.dyndns.org>
References: <j5v9r7$fi1$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 17:25:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8w1D-0004kN-U4
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 17:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793Ab1I1PZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 11:25:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45234 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752691Ab1I1PZu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 11:25:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E66E5863;
	Wed, 28 Sep 2011 11:25:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4MqSrlbRLvR0AWrGufkojftuG8Y=; b=bXrz/x
	irg5Jt9Zt3rQ4NweteO74DVSfr6W/3JqEI1XftwC5TdXS1vVSTzr8PUe2WQgmNk7
	IN/5Cd4h8iaCE7XumWhtOI00KS+GAimV4aXEnm+x7eB6sMAmXOm7lKyexVVgKl7i
	fsQr+FgNeDrG3bfH85qguA8lSHbxA1LdDmhUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z0W7IVl2QAS47HHvTzNc8CY6HLn74M8p
	9aQiLnVB6gAZw+BWN6znFj9RpbG73FvC6z1MFiemrENFeocFs8bLd2HPOeSSYWgb
	zWzXxvudVujKiGYW3/v259L6V+P6hFiRkoIItl6Ws92D5ANtHXSZJtuHu46hnWI+
	QLzy2L2nDr0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34C535862;
	Wed, 28 Sep 2011 11:25:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C252E5861; Wed, 28 Sep 2011
 11:25:49 -0400 (EDT)
In-Reply-To: <j5v9r7$fi1$1@dough.gmane.org> (Sebastian Schuberth's message of
 "Wed, 28 Sep 2011 16:08:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2543E450-E9E6-11E0-93A3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182334>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> ... I'm seeing this on Linux and Windows, with versions 1.7.4.3 and 1.7.6.

There recently have been quite a change in merge-recursive implementation
and it would be really nice if you can try this again with the tip of
'master' before 1.7.7 final ships.

Thanks.
