From: Junio C Hamano <gitster@pobox.com>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a
 custom merge strategy
Date: Mon, 28 Jul 2008 14:35:05 -0700
Message-ID: <7vr69dpu9i.fsf@gitster.siamese.dyndns.org>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com>
 <20080728185604.GA26322@sigill.intra.peff.net>
 <alpine.DEB.1.00.0807282008470.8986@racer>
 <7vproxrcvu.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0807281310j16b4ef5alf9738ec0f3270ba0@mail.gmail.com>
 <7vljzlrca9.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0807281324k38198fffwd3b586394b354ed2@mail.gmail.com>
 <7vvdyppv4c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jeff King" <peff@peff.net>,
	"Git Mailinglist" <git@vger.kernel.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Mon Jul 28 23:36:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNaOB-0003j9-MX
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 23:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbYG1VfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 17:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753250AbYG1VfS
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 17:35:18 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbYG1VfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 17:35:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DB21040429;
	Mon, 28 Jul 2008 17:35:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 844E440424; Mon, 28 Jul 2008 17:35:07 -0400 (EDT)
In-Reply-To: <7vvdyppv4c.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 28 Jul 2008 14:16:35 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 10BABE34-5CED-11DD-B5A3-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90508>

Junio C Hamano <gitster@pobox.com> writes:

> "Sverre Rabbelier" <alturin@gmail.com> writes:
>
>> On Mon, Jul 28, 2008 at 22:20, Junio C Hamano <gitster@pobox.com> wrote:
>>> "Sverre Rabbelier" <alturin@gmail.com> writes:
>>>> Mhhh, but the proposed strategy there was in response to the 'insane'
>>>> git-merge-theirs version, not to the 'exact opposite of
>>>> git-merge-ours' that I refer to now, yes?
>>>
>>> No.
>>
>> Nanako Shiraishi's patch was not in response to the "git-merge-theirs"
>> thread, or I am missing something here....?
>
> The quoted sentence by me in that message was after I explained why "per
> hunk theirs" aka "-Xtheirs" was not such a great idea I further went on to
> say "by the way, '-s theirs' is even worse and here is why".

Heh, I ended up doing the "digging" myself.   The quote came from this:

    http://thread.gmane.org/gmane.comp.version-control.git/89010/focus=89024

and "tried not to sound too negative" there refers to:

    http://thread.gmane.org/gmane.comp.version-control.git/89010/focus=89021

which _was_ about the "-Xtheirs", not "-s theirs".
