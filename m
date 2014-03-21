From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] [GSoC] Draft of Proposal for GSoC
Date: Fri, 21 Mar 2014 10:45:03 -0700
Message-ID: <xmqq8us3v42o.fsf@gitster.dls.corp.google.com>
References: <CAM+=D-BWCt9kNSUUQ19ZcPykb6j-tuEr=igBz0ukEk2TA3vWkg@mail.gmail.com>
	<20140321054208.GA31737@sigill.intra.peff.net>
	<CAM+=D-ATimdXmcYpqSyKwZXE=TYXg9cZFG9kyjEOg22K1wF+3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Brian Bourn <ba.bourn@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 18:45:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR3VJ-0005Sg-VP
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 18:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbaCURpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 13:45:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44069 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbaCURpG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 13:45:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 592DD741A5;
	Fri, 21 Mar 2014 13:45:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4CfyK0hoiEsc4K3WNbjnFV0pVzM=; b=S/R0NG
	PPA2cksvc/QIIrmWpYNFSIacoqvAVJRW6LPrNqgVvVnLHRaq+o3AIkyHtcxonOgK
	XC5taPreS09DZ9iIj9kOztEKUlyCLKyIwpGrZN7Edaf8T1VvdlPTLKSvZoykxqaE
	7K82SnxhoMOrasToDzMpn/L1zOScBMZ7cNo3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OuTZwmmuys5Y7zmqC0f0LvOxZCzOzFEs
	DHUy0sm3RBiapu7lcFwzMvvgdT0jiy9jBkUkfKZrYIwDj+SLZBMrIwYsD766r7BY
	C6bVuLfXhbHWFxNnPGhxvHLkH8OD6FtI40bervZtWD5q4fdrRtoLzGFe2JYKYOAN
	7LO14QiXwMI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43429741A3;
	Fri, 21 Mar 2014 13:45:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F53A741A1;
	Fri, 21 Mar 2014 13:45:05 -0400 (EDT)
In-Reply-To: <CAM+=D-ATimdXmcYpqSyKwZXE=TYXg9cZFG9kyjEOg22K1wF+3Q@mail.gmail.com>
	(Brian Bourn's message of "Fri, 21 Mar 2014 05:41:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 898BD7B6-B120-11E3-A495-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244708>

Brian Bourn <ba.bourn@gmail.com> writes:

> Something like this?
>
> Sample api calls
> Add_Opt_Group()
> Parse_with_contains()
> Parse_with_merged()
> Parse_with_no_merged()
> Parse_with_formatting()
> (each of the 4 calls above may have internal calls within the library
> in order to parse the option for each of the different function which
> may call these functions)

This list is a bit too sketchy to be called "sample api calls", at
least to me.  Can you elaborate a bit more?

What do they do, what does the caller expect to see (do they get
something as return values?  do they expect some side effects?)?
