From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "identifier redeclared" compilation error with SUN cc.
Date: Thu, 15 Nov 2007 14:15:50 -0800
Message-ID: <7v640340kp.fsf@gitster.siamese.dyndns.org>
References: <7vy7d08her.fsf@gitster.siamese.dyndns.org>
	<1195089303-28085-1-git-send-email-B.Steinbrink@gmx.de>
	<Pine.LNX.4.64.0711152253430.4090@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	gitster@pobox.com, raa.lkml@gmail.com, git@vger.kernel.org
To: Guido Ostkamp <git@ostkamp.fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Nov 15 23:16:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isn0t-0005yq-4S
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 23:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759439AbXKOWP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 17:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757654AbXKOWP7
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 17:15:59 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:45535 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756463AbXKOWP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 17:15:58 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 868712EF;
	Thu, 15 Nov 2007 17:16:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 06F669626F;
	Thu, 15 Nov 2007 17:16:13 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711152253430.4090@bianca.dialin.t-online.de>
	(Guido Ostkamp's message of "Thu, 15 Nov 2007 23:00:44 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65173>

Guido Ostkamp <git@ostkamp.fastmail.fm> writes:

> I tested it and the file in question compiled ok for the two versions
> of Sun Forte and Workshop compilers that I have available.
>
> I could also link & run the main git binary after applying my own
> mkdtemp() patch.

Are there problems with the implementation in compat/ directory,
we ship specifically to help platforms without mkdtemp()?
