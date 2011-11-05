From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck: print progress
Date: Sat, 05 Nov 2011 16:59:42 -0700
Message-ID: <7vk47e86j5.fsf@alter.siamese.dyndns.org>
References: <20111103211819.GA17341@sigill.intra.peff.net>
 <1320376242-27851-1-git-send-email-pclouds@gmail.com>
 <4EB4EB70.40801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 00:59:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMq9N-0005fI-Mi
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 00:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562Ab1KEX7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 19:59:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33938 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752523Ab1KEX7o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 19:59:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4285A6F53;
	Sat,  5 Nov 2011 19:59:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5LNbm+YXTobJODwicU8NLtxJr4I=; b=yBoWFt
	aJjxI9uRDMbaPLIQAGzAkpOjPjCAhp4I1kj1mgnksMKsvOxMsqMJdc7Cv+wEJD9Y
	c80jVtzaKtQ6VBvsYSU1A8NJxlyDqz1it2E98dNWHrtUZFNOvjCjdY0HJ/Nq4DeI
	h9635O0Rz+1HiAI7afmzsyC0VGuexQg2n2n2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pNBnr3YC41df6DZ+wpZuQGUJ+vwD3ShJ
	iNY44rgnSZw1UCaY+S1MUiAzZmcf3py1WZuPVxvKEoQ/ZnSmgotjWVw3cFNX0kqR
	w4KR2CPwZXPJqdTmWUo/zVVayOJIN7XsPdzK8p5EPvw8GEcd3T36mMbN6PBMkLgn
	dhMxglbhSmw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35D686F52;
	Sat,  5 Nov 2011 19:59:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA4106F51; Sat,  5 Nov 2011
 19:59:43 -0400 (EDT)
In-Reply-To: <4EB4EB70.40801@gmail.com> (Stephen Boyd's message of "Sat, 05
 Nov 2011 00:53:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B665834-080A-11E1-8A01-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184882>

Stephen Boyd <bebarino@gmail.com> writes:

> What progress isn't shown? How about
>
> 	If --verbose is used with --progress the progress status
> 	will not be shown.

When I ask for verbose output, I do not get progress eye-candy?

Why?
