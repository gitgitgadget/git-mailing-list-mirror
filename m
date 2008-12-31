From: Junio C Hamano <gitster@pobox.com>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and
 other non-sophisticated new Git users :-) [Scanned]
Date: Tue, 30 Dec 2008 22:07:15 -0800
Message-ID: <7vzlicyj1o.fsf@gitster.siamese.dyndns.org>
References: <BB5F02FD3789B54E8964D38D6775E718242D36@ALTMORE-SVR.altmore.local>
 <200812302141.02248.bss@iguanasuicide.net>
 <7v7i5hymp7.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0812302356040.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Conor Rafferty <conor.rafferty@altmore.co.uk>,
	Jeff Whiteside <jeff.m.whiteside@gmail.com>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Dec 31 07:09:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHuH0-00039J-78
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 07:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbYLaGH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 01:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbYLaGH1
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 01:07:27 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45561 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbYLaGH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 01:07:26 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B8A898CDA6;
	Wed, 31 Dec 2008 01:07:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7E2998CD9F; Wed,
 31 Dec 2008 01:07:17 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0812302356040.19665@iabervon.org> (Daniel
 Barkalow's message of "Wed, 31 Dec 2008 00:21:42 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4B2FD98A-D701-11DD-8497-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104252>

Daniel Barkalow <barkalow@iabervon.org> writes:

> With that description, there's a bug: in addition to the above, it checks 
> out from the index any path which does match the <paths> but isn't in 
> <tree-ish>....
> ...
> (instead, you should get an error if a <path> doesn't match anything in 
> the <tree-ish> and only get those things that it matches in the 
> <tree-ish>.)
>
> I think I was too zealous sharing code back in February. I should have a 
> patch by the weekend if nobody beats me to it. (And I still think that, if 
> you hit this case, you must be confused, but git isn't helping by doing 
> what it does.)

I think that may be a good thing to do.

By the way, I am not opposed to have "git $revert <tree-ish> <path>..."
that makes the work tree and the index identical to what existed in
<tree-ish> at the named <paths>, i.e. checking out "the absense" of files
in the named directory if <path> is a subtree.  Because it is very
established to use the command verb "revert" to mean making a
counter-commit by now, we may have to use a word other than "revert" for
that purpose, though.
