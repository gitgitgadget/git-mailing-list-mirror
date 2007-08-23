From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 21:21:53 -0700
Message-ID: <7v8x82x4m6.fsf@gitster.siamese.dyndns.org>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
	<46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0708221154150.16727@xanadu.home>
	<Pine.LNX.4.64.0708221713540.20400@racer.site>
	<86mywjcwv7.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0708221149440.30176@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708222033040.16727@xanadu.home>
	<alpine.LFD.0.999.0708222006110.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 06:22:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO4DJ-00021y-5P
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 06:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbXHWEWN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 00:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbXHWEWN
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 00:22:13 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:56152 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbXHWEWM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 00:22:12 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B8E0125316;
	Thu, 23 Aug 2007 00:22:27 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0708222006110.30176@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 22 Aug 2007 20:23:46 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56451>

Linus Torvalds <torvalds@linux-foundation.org> writes:

>> > I'd love for every single shell-script in git core to be written in C, so 
>> > that we can drop the dependency on shell *entirely*.
>> 
>> What about the test suite?
>
> The test suite is indeed special. But I think that's a "build requiement", 
> and if we require something like shell for *building*, that's different 
> from requiring normal users to have it.

Also it is a good test for the kind of scriptability you (and I)
seek.  We should not drop shell from the test suite for that
reason.
