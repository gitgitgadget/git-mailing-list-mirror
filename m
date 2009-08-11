From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: bug with .git file and aliases
Date: Tue, 11 Aug 2009 12:37:07 +0200
Message-ID: <4A8149D3.1050103@drmicha.warpmail.net>
References: <7f9d599f0907200654q2e068e6aq3051c122f6596053@mail.gmail.com> <20090720152117.GB5347@coredump.intra.peff.net> <4A814216.20708@drmicha.warpmail.net> <4A81474C.70804@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Geoffrey Irving <irving@naml.us>,
	git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:15:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaqGQ-0000RC-Er
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbZHKMGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 08:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbZHKMGU
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 08:06:20 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36164 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753033AbZHKMGT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 08:06:19 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C336012F2E;
	Tue, 11 Aug 2009 06:37:22 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 11 Aug 2009 06:37:22 -0400
X-Sasl-enc: BGvdlNDjMaH+UEkfcDIf6CGpJeC369aLSbUI8v1Ktx/Z 1249987042
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 94D543146E;
	Tue, 11 Aug 2009 06:37:21 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.3pre) Gecko/20090811 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <4A81474C.70804@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125522>

Johannes Sixt venit, vidit, dixit 11.08.2009 12:26:
> Michael J Gruber schrieb:
>> ...because it was up to the brave git-on-win folks to decide whether
>> setenv() on win would be rewritten to not use putenv() when the value is
>> "". J&J, has anything happened on the front or is it likely to? (I'm
>> sorry I can't offer help, only moral support...)
> 
> Nothing has changed since. Nothing is likely to happen until there is a
> need to touch compat/setenv.c, like, for example, a test in the test suite
> that fails only on Windows...

...well, that can be taken care of quickly. Go, Jeff, go :)

Michael
