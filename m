From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Tue, 29 Apr 2008 16:17:42 -0700
Message-ID: <7vzlrc45ex.fsf@gitster.siamese.dyndns.org>
References: <4816A989.2010204@gnu.org> <20080429053814.GA3332@steel.home>
 <4816C527.4000406@gnu.org> <4816CB46.1050100@op5.se>
 <4816D505.1000208@gnu.org> <20080429204417.GC6301@steel.home>
 <48178FD6.90104@gnu.org> <20080429213323.GA2413@steel.home>
 <48179625.3050704@gnu.org>
 <alpine.DEB.1.00.0804292324040.13650@eeepc-johanness>
 <20080429230237.GA22598@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Bonzini <bonzini@gnu.org>,
	Alex Riesen <raa.lkml@gmail.com>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com,
	srb@cuci.nl
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 30 01:19:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqz6D-0006jR-5F
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 01:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585AbYD2XSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 19:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753451AbYD2XSL
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 19:18:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277AbYD2XSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 19:18:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 671BC3456;
	Tue, 29 Apr 2008 19:18:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6CB3B3451; Tue, 29 Apr 2008 19:17:57 -0400 (EDT)
In-Reply-To: <20080429230237.GA22598@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 29 Apr 2008 19:02:37 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 86A81B06-1642-11DD-9486-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80768>

Jeff King <peff@peff.net> writes:

> I wonder this a bit, too, and I am even somebody who _likes_ the new
> behavior. But there is a difference between "should have been designed
> this way in the first place" and "is currently designed some other way,
> and will cause pain to switch it to this way."
>
> So it might simply not be worth the trouble to change. OTOH, I think
> this is how we end up with many commands to do slightly different
> things, which can end up confusing new users. I'm not sure what the
> right answer is.

Well, the thing is, push and fetch are different, so expecting the same
behaviour and syntax from them is a lost cause to begin with.  Even if we
were designing fetch and push right now, I do not necessarily think the
series shows a way that "should have been designed in the first place".
