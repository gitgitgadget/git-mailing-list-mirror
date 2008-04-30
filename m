From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: point git-prune users to git-gc
Date: Tue, 29 Apr 2008 18:01:52 -0700
Message-ID: <7v63u040lb.fsf@gitster.siamese.dyndns.org>
References: <32541b130804230841h32c07f3arc94cccfaf0b156a3@mail.gmail.com>
 <7vve28sdys.fsf@gitster.siamese.dyndns.org>
 <20080423221316.GE30057@sigill.intra.peff.net>
 <20080424012836.GA30812@sigill.intra.peff.net>
 <32541b130804240843k471ecfeteb1008c44a56808b@mail.gmail.com>
 <20080424161407.GA23737@sigill.intra.peff.net>
 <32541b130804240959y3b05d4b5u67ac7a7c14bf187e@mail.gmail.com>
 <20080429204514.GA21029@sigill.intra.peff.net>
 <7vskx45ncg.fsf@gitster.siamese.dyndns.org>
 <20080429231917.GB22646@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 30 03:02:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr0im-0006il-Ep
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 03:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153AbYD3BCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 21:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755694AbYD3BCG
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 21:02:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53791 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153AbYD3BCF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 21:02:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0A25A17BE;
	Tue, 29 Apr 2008 21:02:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 45F3417B4; Tue, 29 Apr 2008 21:01:59 -0400 (EDT)
In-Reply-To: <20080429231917.GB22646@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 29 Apr 2008 19:19:17 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0BFD4A52-1651-11DD-B106-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80777>

Jeff King <peff@peff.net> writes:

> I'm not so sure that they are interested in the prune command. At first
> I started with just a note near the end, but the point of this is
> specifically to deal with users who "stumble" upon prune, either from
> reading the command list (i.e., trying to match a command to the
> objective they want to perform) or from pre-gc tutorials or emails which
> mention it.

Ah, you are right.  People tend to stop reading when they _think_ they
heard enough even though they haven't.  The note upfront is good, and I
suspect we would not have to reword the latter parts either then.

>> > +Notes
>> > +-----
>> > +
>> > +In most cases, users will not need to call git-prune directly, but
>> > +should instead call linkgit:git-gc[1], which handles pruning along with
>> > +many other housekeeping tasks.
>> 
>> ... this paragraph should be made a bit fatter by mentioning what "other
>> housekeeping tasks" are.
>
> OK, I was trying to imply "go look at git-gc for those tasks" so they
> didn't have to be repeated. Would you prefer it be spelled out
> explicitly here, or is a more firm pointer OK?

Will apply as is.

Thanks.
