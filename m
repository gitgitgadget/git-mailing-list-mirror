From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote: make prune work for mixed mirror/non-mirror repos
Date: Thu, 20 Jun 2013 16:44:46 -0700
Message-ID: <7v8v24pcsx.fsf@alter.siamese.dyndns.org>
References: <1371763424.17896.32.camel@localhost>
	<1371766304-4601-1-git-send-email-dennis@kaarsemaker.net>
	<7vppvgpfib.fsf@alter.siamese.dyndns.org>
	<1371769636.17896.44.camel@localhost>
	<7vhagspdfx.fsf@alter.siamese.dyndns.org>
	<1371771510.17896.61.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Fri Jun 21 01:44:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpoX7-0001fi-Ds
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 01:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965643Ab3FTXot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 19:44:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48047 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965026Ab3FTXos (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 19:44:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74FB52A6CD;
	Thu, 20 Jun 2013 23:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t62cGumWEK61f4ZY0havkShdiBM=; b=CfckzE
	ofIw4y6GR9RFJFf/xdtts2i/dNzD8Of6GpjoZ3EW/HJWGV+4Jzh8rmCsCwo2w9uM
	MjOlkC+2P7VPPkm6/9cgyLBOUAF2z3vc7cJc5RBq5C4eENzFYzjB//PZw3qG6zDr
	504bKAPv5Ps3Ow9cR//jQnDHCF8YGlV46dykw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fyelw7B7qXYg2algCTXyRm6feTsZZvMS
	xZrwEhqeuVaBj1nz3jahret+sETIH7c6KxFGiQa+n0YL+dScm1rYGqopm2LUiDcs
	pmCCrp8OzSzVOfkU4kEau26+XQJ21qPiLwGsGx2k56QhcEF0VbEE29WliNMahrpQ
	woVcgtM59vk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BED32A6CC;
	Thu, 20 Jun 2013 23:44:48 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D8C672A6CB;
	Thu, 20 Jun 2013 23:44:47 +0000 (UTC)
In-Reply-To: <1371771510.17896.61.camel@localhost> (Dennis Kaarsemaker's
	message of "Fri, 21 Jun 2013 01:38:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 646A180C-DA03-11E2-B999-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228562>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> I'd really like to have C as well though, would you accept a patch that
> implements it?

I already said I dunno, and asking me 5 minutes after that would not
change my answer X-<.  I tend to agree with Peff that it is papering
over the underlying problem, which B solves.
