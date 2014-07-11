From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] tag: use skip_prefix instead of magic numbers
Date: Fri, 11 Jul 2014 11:42:59 -0700
Message-ID: <xmqqvbr33ff0.fsf@gitster.dls.corp.google.com>
References: <1405099447-27555-1-git-send-email-jacob.e.keller@intel.com>
	<20140711175056.GE7856@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 11 20:43:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5fmr-0000Cv-Mv
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 20:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbaGKSnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 14:43:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63113 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876AbaGKSnH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 14:43:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 52B1127207;
	Fri, 11 Jul 2014 14:42:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lgx8teOaD7VwRsaoTg972N61kvc=; b=cNw67m
	9jc/1kyuRPIODoJYpPQXMKj5CN7iQIBICQTHZ0uqG5HIIq+91hpUGbZlGSxExjM0
	PKnwdCTHaBnmQ1mazET7g60s66zz0OLLpZKlI5UQ+ViAU/+FQiU1aQ9joSDtZrM0
	cAM3xWW3jcLDrsVCLOAKKVfBeqm/04ZoYwMog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rodEgBoTiCWPPqi90SPXjLbfRoujy0pp
	TcfX1f0Qc/XqfvKWiGne6pmrm4YjM6n6RCbwG5DC00Wj/TsiaCUFPP/tY1PfXrQT
	Jvolrznj1Pmf7LDQjjjtazJZPP7yJKmSB/GFz/XPJZM/APUJNYXtcK897vc5z/uQ
	REtEgE1nN9I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 466FF27206;
	Fri, 11 Jul 2014 14:42:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F1C67271F0;
	Fri, 11 Jul 2014 14:42:45 -0400 (EDT)
In-Reply-To: <20140711175056.GE7856@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 11 Jul 2014 13:50:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 265FB942-092B-11E4-954E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253314>

Jeff King <peff@peff.net> writes:

> On Fri, Jul 11, 2014 at 10:24:05AM -0700, Jacob Keller wrote:
>
>> Make the parsing of the --sort parameter more readable by having
>> skip_prefix keep our pointer up to date.
>> 
>> Authored-by: Jeff King <peff@peff.net>
>
> I suspect Junio may just apply this on the version of the commit he has
> upstream, so you may not need this as part of your series.

You read me correctly ;-)  That is what I was planning to do, to
fork jk/tag-sort topic on top of the updated jk/skip-prefix topic.

> However, for reference, the right way to handle authorship is with a
>
>   From: Jeff King <peff@peff.net>
>
> at the top of your message body. Git-am will pick that up and turn it
> into the author field of the commit.

Thanks.
