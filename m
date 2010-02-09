From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-push: fix the documentation to explain all the
 status flags
Date: Mon, 08 Feb 2010 16:30:30 -0800
Message-ID: <7vaavj2qu1.fsf@alter.siamese.dyndns.org>
References: <7vmxzj726j.fsf@alter.siamese.dyndns.org>
 <1265672654-26511-1-git-send-email-larry@elder-gods.org>
 <7veikv2r50.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 01:30:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nee05-0007Sv-T5
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 01:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721Ab0BIAai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 19:30:38 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab0BIAah (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 19:30:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1561A98F97;
	Mon,  8 Feb 2010 19:30:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dZSo0t+3jeRn+EffIHPZiGsZJTU=; b=gj8SXv
	QtsythGh8hCN+AuftuqDfTboDH+bCVPmaRleK8FOUZDG3yEHsRA6AMWqm/GdRT+Z
	HxS5TceJiGXmhEuGl7sj26qeQqJVDu1RV0tHDDVdFG+ThjL2zTMgsgKtohqpcH2c
	nZcRpOWXmh2aQc5mBEiZgSSLoQUglWwYbF144=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QAIJQEr+Jde2ULagtFkEzcxxRdxf6hFC
	BS5gICHKkGvH62CCSIF7cfEho7YVVbwypedoPQkOrUuRkNhLMv6WRz9XgQPbt6qm
	pH2DO+S+LnjJOBI/ABapwcAkWerFDriO3EmcvSUvq2fX64LkIJZQFN29x8qVgZNK
	ugUgBRVyK1Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D9EC698F94;
	Mon,  8 Feb 2010 19:30:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 403F198F93; Mon,  8 Feb
 2010 19:30:32 -0500 (EST)
In-Reply-To: <7veikv2r50.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 08 Feb 2010 16\:23\:55 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 56763A00-1512-11DF-9CFC-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139340>

Junio C Hamano <gitster@pobox.com> writes:

> Both [horizontal] and three colons are something we never have used in the
> existing documentation set.  How confident are you that various versions
> of deployed AsciiDoc people would use all support this?
>
> I am not _complaining_; I am just being cautious to see if I have to look
> into the issue myself (if your answer is "not at all") or not (otherwise).

Unfortunately, http://www.methods.co.nz/asciidoc/newlists.html labels the
syntax as "new in 8.3.0", and Debian 5.0.X and Fedora 11 both use AsciiDoc
that are older than that (8.2.7 and 8.2.5).

I'll flatten the description into prose for now.

Thanks.
