From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2008, #07; Sat, 23)
Date: Mon, 25 Aug 2008 13:19:22 -0700
Message-ID: <7vtzd8g851.fsf@gitster.siamese.dyndns.org>
References: <7v1w0ft750.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0808241955550.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vd4jymdfn.fsf@gitster.siamese.dyndns.org>
 <7vwsi6kvow.fsf@gitster.siamese.dyndns.org> <20080825163203.GD22184@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Mon Aug 25 22:21:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXiZJ-00009l-Rt
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 22:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753797AbYHYUTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 16:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753486AbYHYUTo
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 16:19:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51166 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667AbYHYUTn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 16:19:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A04B5334B;
	Mon, 25 Aug 2008 16:19:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2661853349; Mon, 25 Aug 2008 16:19:35 -0400 (EDT)
In-Reply-To: <20080825163203.GD22184@cuci.nl> (Stephen R. van den Berg's
 message of "Mon, 25 Aug 2008 18:32:03 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 25665922-72E3-11DD-B793-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93666>

"Stephen R. van den Berg" <srb@cuci.nl> writes:

> Junio C Hamano wrote:
> ...
>>It seems that kill_some_child() will not kill anything if nobody else is
>>coming from the same address, while the old code did kill some.  Is this
>>intended?
>
> This is intended.
> ...
>>...  If you
>>simplify add_child() to queue the newborn always at the front of the list,
>>your kill_some_child() will continue to do so, so I do not see the point
>>of the loop in add_child().  Am I mistaken?
> ...
> You are mistaken.
> The point is that we need to find out *duplicate* IP-adresses.

Lightbulb goes on on both counts.  Thanks.

> Shall I incorporate your suggested changes (as far as I consider them ok)
> into my patches and resubmit them?

I think your response makes the only remaining is the style fixup, which
was my [1/3] from yesterday, so I think we are Ok with what already we
have.

Thanks.
