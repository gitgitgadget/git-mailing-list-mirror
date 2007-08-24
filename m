From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tracking perms/ownership
Date: Fri, 24 Aug 2007 00:39:08 -0700
Message-ID: <7vd4xds7oj.fsf@gitster.siamese.dyndns.org>
References: <1187716461.5986.71.camel@beauty>
	<20070821134030.b763e9d3.seanlkml@sympatico.ca>
	<1187817948.5986.159.camel@beauty>
	<alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
	<1187905879.5986.199.camel@beauty>
	<7vtzqpsy3q.fsf@gitster.siamese.dyndns.org>
	<1187940171.6357.59.camel@beauty>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Josh England" <jjengla@sandia.gov>
X-From: git-owner@vger.kernel.org Fri Aug 24 09:39:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOTlH-00023Y-8m
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 09:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbXHXHjP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 03:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752429AbXHXHjP
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 03:39:15 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49584 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbXHXHjO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 03:39:14 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 20F5A127496;
	Fri, 24 Aug 2007 03:39:32 -0400 (EDT)
In-Reply-To: <1187940171.6357.59.camel@beauty> (Josh England's message of
	"Fri, 24 Aug 2007 01:22:51 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56559>

"Josh England" <jjengla@sandia.gov> writes:

> That's ok.  Any place to store the data is fine by me.  I'm just
> concerned about some comments I saw in attrs.c <line13>:
> /*
> The basic design decision here is that we are not going to have insanely
> large number of attributes.
> This is a randomly chosen prime.
> */
> #define HASHSIZE 257

That talks about the size of the vocabulary of attribute names,
such as "diff", "crlf", "merge".  IIRC, you need two more
(owner, perm) or maybe three (group), not 150k.
