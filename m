From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Friendly refspecs
Date: Wed, 16 Apr 2008 13:03:22 -0700
Message-ID: <7vod89pnxx.fsf@gitster.siamese.dyndns.org>
References: <20080409101428.GA2637@elte.hu>
 <20080409145758.GB20874@sigill.intra.peff.net>
 <20080409200836.GA19248@mithlond>
 <20080409203453.GA10370@sigill.intra.peff.net>
 <20080409222500.GB19248@mithlond>
 <20080409225112.GB12103@sigill.intra.peff.net>
 <20080413093102.GC12107@mithlond.arda.local>
 <20080416034823.GA11727@sigill.intra.peff.net>
 <alpine.LNX.1.00.0804161126280.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Teemu Likonen <tlikonen@iki.fi>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Apr 16 22:18:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmDs0-0000nG-5h
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 22:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149AbYDPUDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 16:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753274AbYDPUDj
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 16:03:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35617 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926AbYDPUDg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 16:03:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 86F7539E3;
	Wed, 16 Apr 2008 16:03:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id ADAC739E2; Wed, 16 Apr 2008 16:03:28 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79737>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I was only working on making "HEAD" expand to HEAD:<current branch>. I 
> think that the matching type is only most likely what you want, not 
> certainly enough to just do it. I'd say that push should suggest it, but 
> not actually do it automatically, or possibly require -f to do it without 
> the full name.

Hmm.  `-f` means "I know there are the ones that do not fast forward but I
want them updated", which is quite a different thing.  I'd say either we
should just do it, or we don't, and keep `-f` orthogonal to the ref
dwimming.
