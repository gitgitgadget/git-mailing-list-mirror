From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: bug with .git file and aliases
Date: Tue, 11 Aug 2009 12:26:20 +0200
Message-ID: <4A81474C.70804@viscovery.net>
References: <7f9d599f0907200654q2e068e6aq3051c122f6596053@mail.gmail.com> <20090720152117.GB5347@coredump.intra.peff.net> <4A814216.20708@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Geoffrey Irving <irving@naml.us>,
	git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:52:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Maqpi-0007FV-Dx
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144AbZHKMsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 08:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754399AbZHKMsR
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 08:48:17 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:34633 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbZHKMsN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 08:48:13 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MaoYf-0005mv-Bb; Tue, 11 Aug 2009 12:26:21 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C3E8D795; Tue, 11 Aug 2009 12:26:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A814216.20708@drmicha.warpmail.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125545>

Michael J Gruber schrieb:
> ...because it was up to the brave git-on-win folks to decide whether
> setenv() on win would be rewritten to not use putenv() when the value is
> "". J&J, has anything happened on the front or is it likely to? (I'm
> sorry I can't offer help, only moral support...)

Nothing has changed since. Nothing is likely to happen until there is a
need to touch compat/setenv.c, like, for example, a test in the test suite
that fails only on Windows...

-- Hannes
