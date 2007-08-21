From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git-mergetool: show original branch names when possible
Date: Tue, 21 Aug 2007 14:17:47 -0700
Message-ID: <7vir78oadg.fsf@gitster.siamese.dyndns.org>
References: <20070820075318.GA12478@coredump.intra.peff.net>
	<7vabsmtxsg.fsf@gitster.siamese.dyndns.org>
	<20070820085246.GA23764@coredump.intra.peff.net>
	<20070820181725.GB8542@efreet.light.src>
	<20070821061014.GB7323@coredump.intra.peff.net>
	<20070821145943.GI8542@efreet.light.src>
	<20070821205503.GA16777@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 21 23:18:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INb6s-0000d8-Ev
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 23:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755023AbXHUVRy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 17:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755107AbXHUVRy
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 17:17:54 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:59191 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960AbXHUVRx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 17:17:53 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id BEDE6125BD3;
	Tue, 21 Aug 2007 17:18:11 -0400 (EDT)
In-Reply-To: <20070821205503.GA16777@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 21 Aug 2007 16:55:03 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56332>

Jeff King <peff@peff.net> writes:

> On Tue, Aug 21, 2007 at 04:59:43PM +0200, Jan Hudec wrote:
>
>> >   1. It does not handle pulls which have no tracking branch (the only
>> >      ref we have is FETCH_HEAD, which is not a useful name :) ).
>> 
>> If there's no useful name, than it's probably hard to do anything at all
>> about it. Though FETCH_HEAD is not all that useless -- it at least says it is
>> that that you pull.
>
> But there _is_ a useful name, it's just not a ref (it's the information
> from FETCH_HEAD "branch 'foo' of git://..."). In this case,
> git-mergetool could pull it out of FETCH_HEAD, as well, but I feel like
> we're starting to make a lot of fragile cross-tool assumptions.

Isn't the label "FETCH_HEAD" itself clear enough, without even
looking at it to see which commit it is?
