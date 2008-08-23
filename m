From: Junio C Hamano <gitster@pobox.com>
Subject: Re: About git pretty
Date: Fri, 22 Aug 2008 17:12:53 -0700
Message-ID: <7v4p5c612y.fsf@gitster.siamese.dyndns.org>
References: <94a0d4530808221624m26034923pbc1f97cb4c4203d8@mail.gmail.com>
 <7vd4k062k2.fsf@gitster.siamese.dyndns.org>
 <e1dab3980808221704h3c713e64n41adc631d7a79601@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Felipe Contreras" <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: "David Tweed" <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 02:14:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWglc-00041s-L9
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 02:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbYHWAND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 20:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754503AbYHWAND
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 20:13:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389AbYHWANB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 20:13:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3A043691CD;
	Fri, 22 Aug 2008 20:13:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 86E4E691CC; Fri, 22 Aug 2008 20:12:55 -0400 (EDT)
In-Reply-To: <e1dab3980808221704h3c713e64n41adc631d7a79601@mail.gmail.com>
 (David Tweed's message of "Sat, 23 Aug 2008 01:04:09 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3ED99E4C-70A8-11DD-9322-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93408>

"David Tweed" <david.tweed@gmail.com> writes:

> On Sat, Aug 23, 2008 at 12:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> "Felipe Contreras" <felipe.contreras@gmail.com> writes:
>>> It is just me or 'pretty full' doesn't exactly convey the meaning of
>>> the action to execute?
> [snip]
>>> If you like the idea I can work on a patch.
>>
>> FWIW, I don't like it.
>
> It's probably much too late to change conventions given the number of
> deployed scripts, but one of the annoyances for me about git is that a
> lot of the commands/options names are based on what the code does/is
> written rather than relating to what a user who doesn't know or care
> about the inner workings expects as output. For instance, I imagine
> the --pretty gets its name because a pretty printing routine, called
> pretty_print_commit in the code,...

It's the other way around.  We name function pretty_print_commit() because
we would want to pretty print out output and the option to trigger the
behaviour then is named --pretty.
