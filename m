From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 0/3] gitweb: Faster project search
Date: Thu, 23 Feb 2012 12:54:55 -0800
Message-ID: <7vd3952rts.fsf@alter.siamese.dyndns.org>
References: <1330011779-7803-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 21:55:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0fgt-0006Q1-Dy
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 21:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756930Ab2BWUy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 15:54:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41611 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756909Ab2BWUy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 15:54:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A42216C95;
	Thu, 23 Feb 2012 15:54:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vrTJy3GwSp1LVJBACCYibgvcgy8=; b=jtyERD
	SPiVS2JToMnNvEa8KpcuPELMisTF7lAEli3zBuBKmKHQvBaNa2fAtXvLCMzKu5tw
	Bfz6esPU66lIjIQqnYvh1LU4L/J3lVUO33eaLqCi9UQVi5k33a0x01GxBTSacqQu
	fvfPK2fdq5mHSed5a3vP3TGkYQO2kTnjyP6Us=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j8aUReqU0+oiZMn7RVyJMajvYkxSvtSD
	I5QvV3SoacxbQeLI0dmQxkkRd+uBpJcllsVg61DdcGab09eUJu4rCoBVPGzuIOVn
	/87oow2zesi1AKD5mu9iyZncGP1vvvRrOhB0eYmqTdo05/smqmSRxa8dYjq0eWT1
	uJvFPv5rJo8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A4B56C93;
	Thu, 23 Feb 2012 15:54:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1273F6C92; Thu, 23 Feb 2012
 15:54:56 -0500 (EST)
In-Reply-To: <1330011779-7803-1-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Thu, 23 Feb 2012 16:42:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4B288D8-5E60-11E1-8BFA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191399>

Jakub Narebski <jnareb@gmail.com> writes:

> [Cc-ing Junio because of his involvement in discussion]

Heh, drop that line. People can guess that from the context.

> These patches are separated from first part of previous version of
> this series
>
>   "[PATCHv2 0/8] gitweb: Faster and improved project search"
>   http://thread.gmane.org/gmane.comp.version-control.git/190852
>
> It is meant to replace 'jn/gitweb-search-optim' in pu

I think the result is a lot easier than the previous rounds; will replace
the said topic and move it to 'next' soonish.

Thanks.
