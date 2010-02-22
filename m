From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-diff: add a test for git diff --quiet -w
Date: Sun, 21 Feb 2010 22:03:32 -0800
Message-ID: <7vhbp924ej.fsf@alter.siamese.dyndns.org>
References: <1266807524-28487-1-git-send-email-larry@elder-gods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 07:40:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjROe-0007N5-SP
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 07:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139Ab0BVGDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 01:03:44 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab0BVGDn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 01:03:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D6D769B51F;
	Mon, 22 Feb 2010 01:03:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=qJ4tNN
	yntdUYnkgnIs6b49kyJxYZwAkLvoEFf4SxLlHOxfXCZpjdYOZNGjkoo8GJca8B5Q
	VKO41B+G/e3Ah2k2JoamVRBEvqbM+TjW+qB0TobztbTdn4c7d0FVrxYxhRHVEBT+
	kFPKIlq8HP5+Rz+jMHczpjju9DBqEg3o1xeF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h/5LaAwWGpFMSSzeGIFBlGh6gJyC5RKM
	e1gmjG1F5Lqj4fqUPyr1RdC8RMLMBdmuyKITDdyaSS+upyzvgk4f2s4cgTGa6y8w
	YrF3T47xMyNWPohevBAsgiejPZ8gRlT2l4kDUyUUh0zJ+4+1gtxP4QmYPWvAY9EB
	krLDtWqtj70=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AE7D29B51E;
	Mon, 22 Feb 2010 01:03:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C75E9B51C; Mon, 22 Feb
 2010 01:03:34 -0500 (EST)
In-Reply-To: <1266807524-28487-1-git-send-email-larry@elder-gods.org> (Larry
 D'Anna's message of "Sun\, 21 Feb 2010 21\:58\:44 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 04785970-1F78-11DF-892A-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140619>

Thanks.
