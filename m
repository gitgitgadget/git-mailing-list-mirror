From: Junio C Hamano <gitster@pobox.com>
Subject: Re: name-rev does not show the shortest path
Date: Fri, 24 Aug 2007 11:33:39 -0700
Message-ID: <7v6434eq9o.fsf@gitster.siamese.dyndns.org>
References: <20070823103817.GF6573@informatik.uni-freiburg.de>
	<Pine.LNX.4.64.0708241253050.8987@reaper.quantumfyre.co.uk>
	<20070824125230.GA12030@informatik.uni-freiburg.de>
	<Pine.LNX.4.64.0708241615040.7313@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Aug 24 20:33:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOdyh-00087J-Jv
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 20:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756381AbXHXSds (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 14:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758208AbXHXSds
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 14:33:48 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:58083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756375AbXHXSdr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 14:33:47 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id DA08F1279F8;
	Fri, 24 Aug 2007 14:34:03 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0708241615040.7313@reaper.quantumfyre.co.uk>
	(Julian Phillips's message of "Fri, 24 Aug 2007 16:21:46 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56588>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> From a quick look at the code, that's not surprising, it runs "git
> name-rev --name-only --tags" under the bonnet - so not helpful at all,
> sorry.
>
> So now I wonder how useful --contains really is ... I would have
> expected to always get the "closest" tag.  ~1009^2~1^3~5 seems closer
> than ~1686^2~1^3~5 to me ... ho hum.

The usefulness of --contains is only to provide a nicer looking
shortcut to older name-rev program, as more people are already
familiar with "git describe".  It does not improve name-rev.

I _think_ name-rev goes for shorter-to-type tags and does not
have any other heuristics.  Dscho?
