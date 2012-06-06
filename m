From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] Add the possibility to specify a default help format
Date: Wed, 06 Jun 2012 14:21:27 -0700
Message-ID: <7vbokwkug8.fsf@alter.siamese.dyndns.org>
References: <1338987397-7376-1-git-send-email-vfr@lyx.org>
 <1339014496-6736-1-git-send-email-vfr@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Wed Jun 06 23:21:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScNfb-0003z8-08
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 23:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121Ab2FFVVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 17:21:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55884 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750775Ab2FFVVa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 17:21:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6C06892C;
	Wed,  6 Jun 2012 17:21:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LPcJd03d3QxgOJorvmF8LdXkgCo=; b=NmpQVn
	UC3/ImyAyDsO9a+6BzSkxrM9iWqI0GCHFnW5ewfzFDKDDqrxL3MJoNk6TjQJpnlp
	ncfhJSGq2tD9k5W4Sb2m686sgqbzFKS8hR8bhKhv8xiaPSSkUi3iMYFEueokOUNH
	TSSxCH2EHztN/aPkSSGFBTJ+9czbeTmOd5740=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NN0dCxZLWKOJZ6UySAs0k2AcPNKSV1oW
	8iEN/wrxT5ZzFfr0f2sijGwUwnV/vCrvmAt8IEXb15BUcDu6Q2wbNBlnMb2Vcnao
	og2CwbSMqEZrMMvH8lmoJcM4S3q7WjYa9n3h1TKQlYQlEOr/IGtff3jcd48iwJoY
	+UuFUuARmqc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE019892A;
	Wed,  6 Jun 2012 17:21:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47F418929; Wed,  6 Jun 2012
 17:21:29 -0400 (EDT)
In-Reply-To: <1339014496-6736-1-git-send-email-vfr@lyx.org> (Vincent van
 Ravesteijn's message of "Wed, 6 Jun 2012 20:28:16 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94B1F8B0-B01D-11E1-9DAE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199357>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>

If there were an existing test that assumes "git help" will default
to "man" and verify output from the command, this patch alone will
break it, but I didn't check.

Thanks; will queue (with some rephrasing of the log message).
