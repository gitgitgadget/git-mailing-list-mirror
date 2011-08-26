From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/5] git-tag: introduce long forms for the options
Date: Fri, 26 Aug 2011 10:11:22 -0700
Message-ID: <7vpqjsdrnp.fsf@alter.siamese.dyndns.org>
References: <20110825175301.GC519@sigill.intra.peff.net>
 <f02e446227a93fff37591f1a866566e6220ce283.1314367414.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 19:11:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwzwI-0007WB-Kt
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 19:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139Ab1HZRLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 13:11:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60960 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934Ab1HZRLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 13:11:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 245D840B0;
	Fri, 26 Aug 2011 13:11:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DPr/wr9TFe0lfgnuI1SiTjwKqfw=; b=oMDlNF
	U3Zq1zhmNgNPYT9nJiUY2lM9p0DpwdOpozDMby0WLuMOgQsPm87xGRyG2l3sZM+w
	l9WCWFm9htmRrmB4KFciTN+sRYgdoKnnZA/QNR1CGRZ50tocmhPfZdkBOUEyCAXt
	I5BBYdJMfKXC24S/UbhSd2dg6tiC+sGQo1onI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g/pLQazZGt/b5SEUdXojjrLYnqMh4IZ2
	1DKABBjhL5xTCKNADrEwH9vLySrv9iafkYHYmsG/nC0cakAX5y0hIldBNfJPFwlq
	FiBZ5oEam2dp8qA/Z9JWdpSzE4Hms8Iyw1ZnzhnGz7R4O05X9Um70tYj7oxg8FEe
	kN6dxHJ9BGs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BD6040AF;
	Fri, 26 Aug 2011 13:11:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F63B40AC; Fri, 26 Aug 2011
 13:11:23 -0400 (EDT)
In-Reply-To: <f02e446227a93fff37591f1a866566e6220ce283.1314367414.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri, 26 Aug 2011 16:05:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6CDE1BAE-D006-11E0-98DB-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180179>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Long forms are better to memoize, and more reliably uniform across
> commands.

I think people "memorize" and machines "memoize"; machines will do so just
fine without long forms, but I think you are talking about helping people.

The part after ", and" lacks a verb, making it a non-sentence.

> Design notes:
>
> -u,--local-user is named following the analogous gnupg option.
>
> -l,--list is not an argument taking option but a mode switch.

Ok.

The remainder looks good. Thanks.
