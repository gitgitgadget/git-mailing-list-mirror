From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] shell doc: remove stray "+" in example
Date: Thu, 08 May 2014 10:26:41 -0700
Message-ID: <xmqqsiok41wu.fsf@gitster.dls.corp.google.com>
References: <20140507234401.GY9218@google.com>
	<20140508040438.GB26630@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 08 19:26:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiS5p-0005Zl-OG
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 19:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742AbaEHR0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 13:26:46 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50885 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754314AbaEHR0p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 13:26:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 498151479C;
	Thu,  8 May 2014 13:26:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GFJH4VGEz632JrUj7AFqn+NQCpI=; b=PHVHX4
	7lD78zKXeR0oq6u7+jOz7zHkqDsbxS/EY5myouaKA1h3SldIHZT52DPt+bb/hBTh
	nh7MsA9Ep8lMi+CmJuXA5RnAKe+xSTfvfoBeyynyivBjmMsMG9G4GQPE4qO099Sy
	TgL2pz2eV8ziuUguQLj089sPcMj+CFAQktpcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cb4DfVT5XEDS9/KQsSxrigDhzc0FH0kn
	6pLaWbA68q1rLWbeXiSetvHJuPgXNi8J09zrLNuJqwlXhawtOtcDfV+j+cyLrAl+
	l1lov0rCSWIzaQpZl++JqXV+DqqUdMRkRn7udglqjGf2y2nIpQop8knZZSCtneBE
	DAjW9xbNX3E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3F19C1479B;
	Thu,  8 May 2014 13:26:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D38BD1479A;
	Thu,  8 May 2014 13:26:42 -0400 (EDT)
In-Reply-To: <20140508040438.GB26630@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 8 May 2014 00:04:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EC1A5B3E-D6D5-11E3-89A9-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248427>

Jeff King <peff@peff.net> writes:

> On Wed, May 07, 2014 at 04:44:01PM -0700, Jonathan Nieder wrote:
>
>> The git-shell(1) manpage says
>> 
>> 	EXAMPLE
>> 	       To disable interactive logins, displaying a greeting
>> 		instead:
>> 
>> 		+
>> 
>> 		   $ chsh -s /usr/bin/git-shell
>> 		   $ mkdir $HOME/git-shell-commands
>> [...]
>> 
>> The stray "+" has been there ever since the example was added in
>> v1.8.3-rc0~210^2 (shell: new no-interactive-login command to print a
>> custom message, 2013-03-09).  The "+" sign between paragraphs is
>> needed in asciidoc to attach extra paragraphs to a list item but here
>> it is not needed and ends up rendered as a literal "+".  Remove it.
>> 
>> A quick search with "grep -e '<p>+' /usr/share/doc/git/html/*.html"
>> doesn't find any other instances of this problem.
>> 
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Looks good to me. I suspect it was copied from another spot where the
> examples _were_ in a list (e.g., git-add's EXAMPLES section). Either
> way, your fix is the right thing to do.

Thanks, both.  Looks good to me, too.
