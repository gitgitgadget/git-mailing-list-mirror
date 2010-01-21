From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make test case numbers unique
Date: Thu, 21 Jan 2010 00:00:34 -0800
Message-ID: <7vfx5zx4yl.fsf@alter.siamese.dyndns.org>
References: <4B5808CF.20006@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jan 21 09:02:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXryC-0007wI-91
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 09:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857Ab0AUIAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 03:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754818Ab0AUIAn
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 03:00:43 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54347 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754779Ab0AUIAn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 03:00:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E8A8493531;
	Thu, 21 Jan 2010 03:00:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ak6jIsVECkm/ECSHXkvRPE3OJRs=; b=w2gDZ5
	bFK74PvR2FhI4jH17h0/h1FsMtpUAET3M5bdSqMa0zDKlhZTp4k4rExdkJA+QP+8
	K/9/qVVQ5cnuvKXDSnG4/WNroligG6k6cIogouY8T2/HtjSbiJ4Zi8lIHlevfZo6
	1BIftfpmN9UBqZnzgCCG0EOU6fCW8C86SzOQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i1y/oc1NuEqv/UAi+vSnLHHClZfwxD8I
	e36TtCvKK/ZXCHF/9F8XUVnBA3GSF6EFWG+0U/XgVtW9gvho8pPSbDzJtdzeAsTt
	5uKrS6YHTBnf7cKDEArDjrwYrEYV/CraZRZPgMv9DM7XqPgiTI6vFpfUtMgo+zEs
	9nc99rspCgE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C6BC493530;
	Thu, 21 Jan 2010 03:00:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C0329352F; Thu, 21 Jan
 2010 03:00:35 -0500 (EST)
In-Reply-To: <4B5808CF.20006@viscovery.net> (Johannes Sixt's message of
 "Thu\, 21 Jan 2010 08\:57\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 10CD951A-0663-11DF-A81E-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137638>

Johannes Sixt <j.sixt@viscovery.net> writes:

> From: Johannes Sixt <j6t@kdbg.org>
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

Yuck; thanks.

I wonder if we can automate this somehow.  Perhaps teach pre-applypatch
about this...
