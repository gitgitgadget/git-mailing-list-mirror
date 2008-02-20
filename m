From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH(TIC)] push: annoy all users by deprecating the default
 semantics
Date: Tue, 19 Feb 2008 17:10:02 -0800
Message-ID: <7vr6f8e8lx.fsf@gitster.siamese.dyndns.org>
References: <E7DE807861E8474E8AC3DC7AC2C75EE50542F2F1@34093-EVS2C1.exchange.rackspace.com> <20080219043353.GA23239@sigill.intra.peff.net> <76718490802190509k20225092o66853916f48e08b1@mail.gmail.com> <20080219150826.GA24499@sigill.intra.peff.net> <76718490802190718t5e70abb2x8f96fc7154576594@mail.gmail.com> <20080219152549.GC24499@sigill.intra.peff.net> <alpine.LSU.1.00.0802191610480.30505@racer.site> <20080219163743.GA31668@sigill.intra.peff.net> <alpine.LSU.1.00.0802191651550.30505@racer.site> <20080219170507.GA1144@sigill.intra.peff.net> <5d46db230802191703v1e273284k71817fcd8a2639a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jay Soffian" <jaysoffian@gmail.com>,
	"Jason Garber" <jgarber@ionzoft.com>, git@vger.kernel.org
To: "Govind Salinas" <blix@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 02:11:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRdUG-00013X-5s
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 02:11:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757926AbYBTBK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 20:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757625AbYBTBK1
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 20:10:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35793 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756747AbYBTBKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 20:10:25 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0535484FC;
	Tue, 19 Feb 2008 20:10:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 0B7AE84F9; Tue, 19 Feb 2008 20:10:12 -0500 (EST)
In-Reply-To: <5d46db230802191703v1e273284k71817fcd8a2639a1@mail.gmail.com>
 (Govind Salinas's message of "Tue, 19 Feb 2008 19:03:23 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74493>

"Govind Salinas" <blix@sophiasuchtig.com> writes:

> For those interested, this is how I plan to have the default for
> pyrite.  The default currently just calls "git push origin HEAD"
> Calling with another target repository and refspec would still be
> supported of course.
>
> In general, the plan it to take the most common work flows and simply
> the UI around those.  This includes silently doing "git add -u" before
> pushing a commit and "pyt diff" will diff between the working
> directory and HEAD because I have never been interested in the state
> of the index, only in the state of the working dir.

For both counts, it feels so much like Cogito.

I would not comment on "the most common" adjective, but I am
still a big believer of "core git gives common foundation for
Porcelains that support different workflows to talk with each
other" ideal, and I really like that you are building a
Porcelain that would suit your favorite workflow.
