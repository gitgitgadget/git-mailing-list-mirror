From: Junio C Hamano <gitster@pobox.com>
Subject: Re: size_t vs "unsigned long"
Date: Wed, 03 Oct 2007 14:05:13 -0700
Message-ID: <7v641newom.fsf@gitster.siamese.dyndns.org>
References: <7vabr0djqr.fsf@gitster.siamese.dyndns.org>
	<20071003204801.GC28188@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 23:06:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdBPm-0008VY-JN
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 23:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755448AbXJCVFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 17:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755577AbXJCVFW
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 17:05:22 -0400
Received: from rune.pobox.com ([208.210.124.79]:53960 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753505AbXJCVFU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 17:05:20 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id B79D0141029;
	Wed,  3 Oct 2007 17:05:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 36F391412D4;
	Wed,  3 Oct 2007 17:05:38 -0400 (EDT)
In-Reply-To: <20071003204801.GC28188@artemis.corp> (Pierre Habouzit's message
	of "Wed, 03 Oct 2007 22:48:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Pierre Habouzit <madcoder@debian.org> writes:

>   Well, afaict, on every linux archs I know of, unsigned longs and
> size_t are the same. Though, I don't know if that holds for the msys
> port, and if that does not holds, then a s/unsigned long/size_t/ would
> help them. Else, for consistency sake, I believe the change is a good
> one.

FWIW, I am already getting bitten on a FC box with gcc 4.1.1
20060525 that warns about the wrong type being passed, as I
usually build things with -Werror; the issue is not just "they
are of the same underlying type".
