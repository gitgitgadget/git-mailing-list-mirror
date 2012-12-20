From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: "git config -l" should not expose sensitive information
Date: Thu, 20 Dec 2012 10:37:27 -0800
Message-ID: <7vfw306048.fsf@alter.siamese.dyndns.org>
References: <50CF039A.7010800@gmx.de>
 <20121220150408.GD27211@sigill.intra.peff.net>
 <20121220154915.GA5162@pug.qqx.org>
 <20121220155229.GA6008@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 20 19:37:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tll08-0000jq-Bh
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 19:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595Ab2LTShb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 13:37:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38251 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113Ab2LTSha (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 13:37:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD752A1C8;
	Thu, 20 Dec 2012 13:37:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vecthPsjs9TecI7Fl/AgwCuC1kk=; b=TMC64P
	J61JzaL4TQw8Y/ZYWwvjA222qnMlGkK1NQwBeaRpuK4I2pw/30URn23Uj42NR5ab
	DE0vri4YDDjfes/85m2iD8yJCCT0s9IeWsqzwLMlMT9SpHgigLpEhAjHuyhPsCMv
	GQza0XQbQXWpb5BD8PsyEwCOV5o99NGYuyw/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pUwRsjlIlRyuP1to2pybn6yKhLdEYK0V
	G3NFXINpzIdhFc9557Ffcf7WfljLdo7LuyjmIZCPItJAVbZMOwntrH3iRLuji8PQ
	qX+8xfxy5jl5K0Daq2RTyjy0Vh+IFW2eyI/DmKPbMYSctR+7pJErGfRtUGmSEWnX
	Vbrz98dr+Fk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A7DDA1C7;
	Thu, 20 Dec 2012 13:37:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1CC07A1C5; Thu, 20 Dec 2012
 13:37:29 -0500 (EST)
In-Reply-To: <20121220155229.GA6008@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 20 Dec 2012 10:52:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4EDE50DE-4AD4-11E2-8727-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211916>

Jeff King <peff@peff.net> writes:

> Yeah. Thanks for a dose of sanity. I was really trying not to say "the
> given advice is bad, and we cannot help those people". But I think you
> are right; the only sensible path is for the user to inspect the output
> before posting it.

True.
