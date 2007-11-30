From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 12:01:13 -0800
Message-ID: <7vve7jqz92.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711292218240.27959@racer.site>
	<20071129231444.GA9616@coredump.intra.peff.net>
	<alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org>
	<7veje8twt2.fsf@gitster.siamese.dyndns.org>
	<20071130003512.GB11683@coredump.intra.peff.net>
	<7vzlwwsgkp.fsf@gitster.siamese.dyndns.org>
	<20071130005852.GA12224@coredump.intra.peff.net>
	<alpine.LFD.0.99999.0711292004340.9605@xanadu.home>
	<20071130011748.GC11683@coredump.intra.peff.net>
	<474FB938.3040209@op5.se>
	<20071130150948.GA22095@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 30 21:01:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyC3X-0007lt-3E
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 21:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836AbXK3UB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 15:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753372AbXK3UB0
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 15:01:26 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:44543 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718AbXK3UBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 15:01:25 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id EBFA52F9;
	Fri, 30 Nov 2007 15:01:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2B2DD9B3FC;
	Fri, 30 Nov 2007 15:01:37 -0500 (EST)
In-Reply-To: <20071130150948.GA22095@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 30 Nov 2007 10:09:48 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66659>

Jeff King <peff@peff.net> writes:

> On Fri, Nov 30, 2007 at 08:18:16AM +0100, Andreas Ericsson wrote:
> ...
>> It would provide a ui inconsistency between platforms. Several people
>> pointed that out. It's decidedly a Bad Thing.
>
> Which, as I said, I have already addressed (and which Linus has also
> expanded upon in this thread). Since those hardlinks would be hidden
> from users who did not go to some trouble to find them, there will not
> be inconsistency problems.

I already can see exchanges in the user community after such a change
you propose would happen:

 Newbie: Ay! why doesn't git-commit work anymore?

 Jeff: Stupid Junio and Linus decided that you should not use dash form
       but say "git commit" instead.

 Newbie: But my fingers are trained and I like the "git-<tab>"
         completion.

 Jeff: If you really like that, here is a hidden trick.  Add
       /usr/libexec/git-core/ to your PATH.

 Newbie: Ah, that worked, thanks.

 A few days later...

 Newbie: Jeff, your trick does not work for my coworker.  He also has
         the latest git.  His installation does not even have that
         directory!  What gives?

 Jeff: Ah, sorry, that trick works for some platforms but not others.

 Newbie: Stupid inconsistency.  Who suggested that?
