From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/5] submodule.c: add .gitmodules staging helper functions
Date: Tue, 30 Jul 2013 14:37:58 -0700
Message-ID: <7vsiyvvidl.fsf@alter.siamese.dyndns.org>
References: <51F8187F.7040603@web.de> <51F8190A.3030002@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 30 23:38:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4HcR-0007JY-1U
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 23:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757382Ab3G3ViD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 17:38:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48575 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756870Ab3G3ViB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 17:38:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBE0A34E65;
	Tue, 30 Jul 2013 21:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wHRCFqcZUEuIZt+faw1fZR7Zfyg=; b=L+NZXi
	glcdvIx7fl+3bBqZ7pRnCFVsSGiZ81RMXaRBH7dJGSLE8FKo+bEe3JpqqZk4kwDF
	n7xYZzk+7hgHasmzeYUA+x4jz8e3fRWxKkWN6NuseGzyccG6feM2w+ZRAKFoPnaU
	rDpdI+37blonY19yQbMAp+m2ygIhFMGrw6yXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vPH1XVbx0iq1jZTRG/jeSunAaY2u+l3c
	3b41x3qdvblxP2l3EBWCiLMBC8Rh/sOyjGSoITjeD9GnjPTedOJvq0VTRuCfShE4
	ZrfvplY6Ndcghg7NVEJffQHwuQtRbAi9SQyfOhWZHq/JbYlzQxIEFrTJ3F1allia
	Qh77IxvqVz0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF0AF34E64;
	Tue, 30 Jul 2013 21:38:00 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C0C534E63;
	Tue, 30 Jul 2013 21:38:00 +0000 (UTC)
In-Reply-To: <51F8190A.3030002@web.de> (Jens Lehmann's message of "Tue, 30 Jul
	2013 21:50:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4E6E3CC8-F960-11E2-B896-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231393>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> +int is_staging_gitmodules_ok()

Will tweak this to:

	int is_staging_gitmodules_ok(void)

and fix this as well:

> +int is_staging_gitmodules_ok();
> +void stage_updated_gitmodules(void);


before queuing.

Thanks.
