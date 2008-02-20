From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH(TIC)] push: annoy all users by deprecating the default
 semantics
Date: Tue, 19 Feb 2008 19:15:18 -0800
Message-ID: <7vmypwe2t5.fsf@gitster.siamese.dyndns.org>
References: <E7DE807861E8474E8AC3DC7AC2C75EE50542F2F1@34093-EVS2C1.exchange.rackspace.com> <20080219150826.GA24499@sigill.intra.peff.net> <76718490802190718t5e70abb2x8f96fc7154576594@mail.gmail.com> <20080219152549.GC24499@sigill.intra.peff.net> <alpine.LSU.1.00.0802191610480.30505@racer.site> <20080219163743.GA31668@sigill.intra.peff.net> <alpine.LSU.1.00.0802191651550.30505@racer.site> <20080219170507.GA1144@sigill.intra.peff.net> <5d46db230802191703v1e273284k71817fcd8a2639a1@mail.gmail.com> <7vr6f8e8lx.fsf@gitster.siamese.dyndns.org> <5d46db230802191721p527c0a85k362c7b364c7e99c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jay Soffian" <jaysoffian@gmail.com>,
	"Jason Garber" <jgarber@ionzoft.com>, git@vger.kernel.org
To: "Govind Salinas" <blix@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 04:16:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRfRY-0003mt-44
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 04:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbYBTDPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 22:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbYBTDPt
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 22:15:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42793 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbYBTDPs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 22:15:48 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B229E2A48;
	Tue, 19 Feb 2008 22:15:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 CB4862A44; Tue, 19 Feb 2008 22:15:35 -0500 (EST)
In-Reply-To: <5d46db230802191721p527c0a85k362c7b364c7e99c4@mail.gmail.com>
 (Govind Salinas's message of "Tue, 19 Feb 2008 19:21:08 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74500>

"Govind Salinas" <blix@sophiasuchtig.com> writes:

> On 2/19/08, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> I would not comment on "the most common" adjective, but I am
>> still a big believer of "core git gives common foundation for
>> Porcelains that support different workflows to talk with each
>> other" ideal, and I really like that you are building a
>> Porcelain that would suit your favorite workflow.
>>
> ...  I don't want it to _just_ be for my
> workflow.  I want something that appeals to the common user.

Oh, I did not mean "your private workflow that is not common to
anybody else".  That's certainly useless and there is no reason
I would have said "I really like" to something like that (on the
other hand, of course I would not stop such an attempt either).

That's why I said "your _favorite_ workflow".  Your favorite
could certainly be shared by other people.
