From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] rev-parse: add --filename-prefix option
Date: Tue, 09 Apr 2013 14:33:10 -0700
Message-ID: <7vfvyzpey1.fsf@alter.siamese.dyndns.org>
References: <cover.1365364193.git.john@keeping.me.uk>
 <cover.1365539059.git.john@keeping.me.uk>
 <0d570e110dbf714310f9cbc4fa47e711630707f2.1365539059.git.john@keeping.me.uk>
 <7vtxnfpglq.fsf@alter.siamese.dyndns.org>
 <20130409212827.GG2222@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Apr 09 23:33:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPgAI-00032M-Lo
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 23:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934955Ab3DIVdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 17:33:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45483 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762666Ab3DIVdN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 17:33:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D862F15F9F;
	Tue,  9 Apr 2013 21:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nQ+L+kQJy3pQQSSO8yZVzWi0IDE=; b=uni+bD
	GcMHFq/zuZBtRV3qlpu7Gh4rrkxEOPwcB2JD9A4hwAyCrOXoUIQpmnqHn9+2oTxO
	Hyd/QSQh8fpSWj0irjm4jHFlXtMuT2HmxYnBiiHZbMlgXOrnsIYgVHcoenydHWkD
	nJLtAKbL13SNLnWe+zYr2+vmDGauHWggRnsPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UpmTMk2z+NnCqaue/ymI8lBGVW5BVVHB
	aSW6Rv3+pTwXiJgFsUflD6p6DPsGBJbWvmh7BfDy3F+5XLVaAR9tedBYwXQnSTw/
	aMLRX8IUoMxWTjRsi0DCdKI2eItVwZ4JWgNbmrjHUbw+Br9FvM7TX2fqUz3HqB+t
	j2BLFxkcaNY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBB7215F9E;
	Tue,  9 Apr 2013 21:33:12 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11D7215F9B; Tue,  9 Apr
 2013 21:33:11 +0000 (UTC)
In-Reply-To: <20130409212827.GG2222@serenity.lan> (John Keeping's message of
 "Tue, 9 Apr 2013 22:28:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1466A50C-A15D-11E2-93DE-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220638>

John Keeping <john@keeping.me.uk> writes:

> It's not guessing on all of "$@" in git-submodule - we know that
> everything left is a path.

OK, then.
