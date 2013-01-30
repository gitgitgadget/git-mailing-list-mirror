From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] transfer.hiderefs
Date: Tue, 29 Jan 2013 23:19:52 -0800
Message-ID: <7vfw1jm92f.fsf@alter.siamese.dyndns.org>
References: <1359418412-26602-1-git-send-email-gitster@pobox.com>
 <7vham0tvus.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 08:20:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Rxx-0007CX-68
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 08:20:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866Ab3A3HT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 02:19:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64472 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753684Ab3A3HTz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 02:19:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0E578D4E;
	Wed, 30 Jan 2013 02:19:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BTVIRUtola2y0svc9HNBdHBM59E=; b=Em54PJ
	pNGUgQ/PuVkW8MkaDTdwv6J1oFBwPfOjrxiOsXOcTqannOS8mZ29VBCFAacThUZB
	xYZGg3ZfsUoUvse8o1uxKIz5oZ35KNTAFNQbBZkM5eFuQtbEUnlHEvoBYyQOEzBU
	6+OXJXeGnZ5e5NS4RAmotjQh7ag8O2XHf9BEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rGVLhoXUzfRuvDUxD+g8XB8rsqF8rWGe
	OuwjyBdbG8VaXAjw7VMB+LCCvf4zvyMArKvfTBsFWthZwjZN6X100eCmrVNbMLY+
	+d4C7oH0HVdb8Ja39znehTA4akv/wv/msvnlnb37vCwJeG0WjRZWhPvPISUICFVf
	0OxfUObsk8I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A68838D4D;
	Wed, 30 Jan 2013 02:19:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 263548D4A; Wed, 30 Jan 2013
 02:19:54 -0500 (EST)
In-Reply-To: <7vham0tvus.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 28 Jan 2013 21:13:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 718F1CBE-6AAD-11E2-8D7C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215003>

Junio C Hamano <gitster@pobox.com> writes:

> Please take this as just a preview of early WIP.  I think I may end
> up doing moderate amount of refactoring as a preparatory step before
> these patches, so nitpick-reviews are likely to become waste of
> reviewer's time at this point.

I've pushed out a mostly-done reroll on 'pu'; I'll send them out as
patches for review tomorrow.  I think I am making a good progress.
