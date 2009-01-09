From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Funny: git -p submodule summary
Date: Fri, 09 Jan 2009 01:38:59 -0800
Message-ID: <7vaba024zw.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de>
 <20090109083836.GB21389@coredump.intra.peff.net>
 <7veizc25e8.fsf@gitster.siamese.dyndns.org>
 <20090109093307.GA2039@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 09 10:40:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLDr3-0007JF-52
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 10:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbZAIJjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 04:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753801AbZAIJjJ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 04:39:09 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60865 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbZAIJjG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 04:39:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 28BEF8ED4C;
	Fri,  9 Jan 2009 04:39:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 345DB8ED4B; Fri,
  9 Jan 2009 04:39:02 -0500 (EST)
In-Reply-To: <20090109093307.GA2039@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 9 Jan 2009 04:33:07 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5B8A1390-DE31-11DD-81F6-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104994>

Jeff King <peff@peff.net> writes:

> On Fri, Jan 09, 2009 at 01:30:23AM -0800, Junio C Hamano wrote:
>
>> This arrangement to have the third process could even open the possibility
>> of having it read from git and write to pager, and not launching the pager
>> if there is no interesting data from git to feed it with.
>> 
>> I do not know if I like the performance implications associated with it,
>> though.
>
> Ugh. That has definitely been a requested feature, but the thought of
> essentially running "cat" in our pipeline strikes me as a bit kludgey.
>
> On the other hand, we are by definition going to the pager in that case,
> so in theory performance is less of a consideration.
>
> But see my other mail for why a third process is hard to always do on
> Windows.

Heh, this late at night just before going to bed, I am allowed to say that
I do not care about Windows at all ;-).  More dedicated and competent
people will solve it for us while I am sleeping.
