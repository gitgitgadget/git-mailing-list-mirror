From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/8] gitweb: Faster and improved project search
Date: Sun, 19 Feb 2012 23:09:01 -0800
Message-ID: <7v4numnfqq.fsf@alter.siamese.dyndns.org>
References: <1329338332-30358-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 08:09:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzNNV-0000nx-Ac
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 08:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797Ab2BTHJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 02:09:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57847 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942Ab2BTHJD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 02:09:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14C7632D7;
	Mon, 20 Feb 2012 02:09:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JdecUqgWJyVAbY8vUN1TIr1JOVI=; b=CO9p0x
	Q/fBfu9+r2qU9aUlm0l7l69DnzsYN0RMFrFUk/Tosk0WG7uoV6vSS2m18G937B4b
	AgeEEG3Uja7pVxJDDxrHNeNdA+6hYJP8gv5bCMOX1GQa59viH4ABQ3LTsKkR2DUv
	903eUAQWlo/AAdl3bicTP9yx8JEyfaIHmVsbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xjVmxgt6oyRXd000a+Ub1N0jvKnLZF7c
	3H0U0mRQE8eG7pIefdQto1ObxYBuxMFpFhAo3XrdSNpHHjpfV2UImUPVhJfsANLb
	wIkgEuvYKEj3WhQMO/4hX6kgHSUC9dCA6NobgRsAGxOaKl2g2MgBQj7lnK1EkZcI
	IYrk01lO3e4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D74232D6;
	Mon, 20 Feb 2012 02:09:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FE6A32D4; Mon, 20 Feb 2012
 02:09:02 -0500 (EST)
In-Reply-To: <1329338332-30358-1-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Wed, 15 Feb 2012 21:38:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C4AEC5E2-5B91-11E1-977B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191047>

Jakub Narebski <jnareb@gmail.com> writes:

> [Cc-ing Junio because of his involvement in discussion about first
>  patch in previous version of this series.]
>
> First three patches in this series are mainly about speeding up
> project search (and perhaps in the future also project pagination).
> Well, first one is unification, refactoring and future-proofing.
> The second and third patch could be squashed together; second adds
> @fill_only, but third actually uses it.

I'll queue these three separately to a topic jn/gitweb-search-optim,
and fork another topic jn/gitweb-hilite-regions from there.  I haven't
looked the latter closely, though.

Thanks.
