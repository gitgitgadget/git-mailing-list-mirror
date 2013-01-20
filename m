From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git rm -u
Date: Sun, 20 Jan 2013 10:42:26 -0800
Message-ID: <7v622rn1bh.fsf@alter.siamese.dyndns.org>
References: <50FB1196.2090309@gmail.com> <20130119214921.GE4009@elie.Belkin>
 <vpq622s9jk1.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	git@vger.kernel.org, Tomas Carnecky <tomas.carnecky@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jan 20 19:42:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Twzr0-0001c3-W4
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 19:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230Ab3ATSm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 13:42:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48137 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752217Ab3ATSm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 13:42:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF6F6BEE9;
	Sun, 20 Jan 2013 13:42:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mimiq0bl6eke+mvIZC1ocIDzj9k=; b=n5FYC+
	xNTAzXDgpm62XsNqQGa65NfdRbL9QWWkUW5HAzIZn1aF5b+t8iuziNxwvgGxLWX1
	XzZSDZYUnaUoU+2M5JQaoJ2BYDt1s2qQ3qygLkRSv7eRJV+v7T+IFHpcMs/tExih
	l4vvXSBFDILB34zeIwWLSqYik35ciMXeKQ1u4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aMo+jSJXSSCUpAZkdieaipXeBB/de7jq
	h2ZbJmI0WQw2P9pZ+/r6SH2hcqdLM+mK9pbVMEwkQzSbFTTI2VnHUS35qExE9gAZ
	m67kNS/fdXP7EyQaMCAzXKhZQeaIwWBxgA/QKI3dpx42+pYbrpOeOBstuHqOTIC5
	984JGAROLl8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0377BEE8;
	Sun, 20 Jan 2013 13:42:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 341F7BEE6; Sun, 20 Jan 2013
 13:42:28 -0500 (EST)
In-Reply-To: <vpq622s9jk1.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Sun, 20 Jan 2013 12:32:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 23F34B66-6331-11E2-AE6B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214029>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> "git add -u" is one of the only exceptions (with "git grep"). I consider
> this as a bug, and think this should be changed. This has been discussed
> several times here, but no one took the time to actually do the change

Did we ever agree that it is a good change to begin with?  Pointers?
