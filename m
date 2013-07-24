From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-url-normalize.c: Fix gcc errors and sparse warnings
Date: Wed, 24 Jul 2013 13:39:44 -0700
Message-ID: <7vli4v66b3.fsf@alter.siamese.dyndns.org>
References: <51F0260B.5000905@ramsay1.demon.co.uk>
	<FDCB9C95-34A7-45D8-AC23-9739C24043B5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 22:40:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V25qw-0007nX-Mx
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 22:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045Ab3GXUjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 16:39:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60484 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752801Ab3GXUjs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 16:39:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57ED433064;
	Wed, 24 Jul 2013 20:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xgnOTs3DsF8HbAL+1V0G4LF4nTk=; b=DTy0l+
	mxfcqdgVeQgW3rcETb3V0YN7UhuPyLpQBL1rXILlpHKFlRcFZZBXjBCVS04muQqI
	CjMiY57otNl6FayD4Q9pkQ1x7pJxDG+h4YN8Je6uWZfyZel0F/niRa9jVUwmKzys
	H5385fWP11OyBlkTDtyyVklUZXsXONAhD3oUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HNidUlIdQkAJNjj3O+2VuEn7kL5XeBVw
	xyZCxZY7ewe51Wi/sKB9GcUR9iOMNV40iQghv1i3J+/d9m5AxxLIrOezd+9zEXPR
	9xCTArulVdMphfvNIVakT9GajLS5/SpHFbuYQkFpI2OzNXxS7O0koZOzWDpKsG+Z
	uTXJ32sAkd4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BBA133063;
	Wed, 24 Jul 2013 20:39:47 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C02FC33060;
	Wed, 24 Jul 2013 20:39:45 +0000 (UTC)
In-Reply-To: <FDCB9C95-34A7-45D8-AC23-9739C24043B5@gmail.com> (Kyle J. McKay's
	message of "Wed, 24 Jul 2013 12:35:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D406C9C-F4A1-11E2-A4C7-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231119>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> And hopefully Junio can add this as an incremental patch against next
> as it looks good to me.

Not likely to happen until the weekend.

If I had time for such a clean-up, I would rather be doing the
restructuring of the whole thing to make Peff's "git config --url
<class> <variable> $URL" easier to code myself ;-)
