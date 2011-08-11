From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Add an update=none option for 'loose' submodules
Date: Thu, 11 Aug 2011 11:28:31 -0700
Message-ID: <7v8vqzreeo.fsf@alter.siamese.dyndns.org>
References: <cover.1312923673.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Aug 11 20:28:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrZzk-00046E-3T
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 20:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040Ab1HKS2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 14:28:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59808 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339Ab1HKS2e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 14:28:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AF3548FE;
	Thu, 11 Aug 2011 14:28:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mJAq8ElqZbVdKNWvd6w6ocYvscE=; b=xcsiC2
	NsgMCQfTN9Iykc+XELsu/w5Ky6m1K1sySkOYEVoF0CKo0ksqY0kfwqnQ65eUmV/A
	URtqlOjQ1THA5bUDKERdyKoVSQsJr7zq7qc5rjCnRgHVRo+NyWJkeDFWCYayc3UB
	iylGdX55ZlfTtiKZZUqqeF5CIJgElJ/jSMjFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OJF1brdeL+d3sjvXthbX4KSCNXPP/St1
	4HHavPZ7TeOk40M+L2saFCgRRH8fmmlSu5tfZNe+FEju1UcOIU1CSyiszhEoAyL+
	MDuOL1R2H497njj+GG8O3tS98N8xWySIOZyLfA8CZAfRa+eZNE3S3H2Gec1jmacv
	psq8Uvt+W5k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 228B948FD;
	Thu, 11 Aug 2011 14:28:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A89F248FC; Thu, 11 Aug 2011
 14:28:32 -0400 (EDT)
In-Reply-To: <cover.1312923673.git.hvoigt@hvoigt.net> (Heiko Voigt's message
 of "Thu, 11 Aug 2011 19:51:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7D4E6DA-C447-11E0-9F4D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179127>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> If a submodule is used to seperate some bigger parts of a project into
> an optional directory it is helpful to not clone/update them by default.

Sorry if I am slow, but I do not get this.

I thought unless you say "submodule init" once, a submodule you are not
interested in should not be cloned nor updated at all. If that is not the
case, isn't it a bug to be fixed without a new configuration variable that
fixes it only when it is set?

> We have been talking about loose submodules for some time:

Also before introducing a new terminology "loose submodule", please define
it somewhere. It feels confusing to me that a normal submodule, which
shouldn't be auto-cloned nor auto-updated without "submodule init", needs
to be called by a name other than simply a "submodule" but with an
adjuctive "loose submodule".
