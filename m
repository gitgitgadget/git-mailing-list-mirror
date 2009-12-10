From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] tag -d: print sha1 of deleted tag
Date: Thu, 10 Dec 2009 15:16:07 +0200
Message-ID: <87hbrz6kbs.fsf@jondo.cante.net>
References: <87ljhb87nj.fsf@jondo.cante.net>
	<3b0a7bfa75126e4c13ec15a4357645b2bfd14b5b.1260447713.git.git@drmicha.warpmail.net>
	<20091210124929.GA444@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 10 14:22:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIiyM-0007mQ-Vs
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 14:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757986AbZLJNWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 08:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753804AbZLJNWF
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 08:22:05 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:35356 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbZLJNWE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 08:22:04 -0500
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Dec 2009 08:22:04 EST
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 0C8478C9AB;
	Thu, 10 Dec 2009 15:16:14 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A04D3D07819; Thu, 10 Dec 2009 15:16:14 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 805E0E51A3;
	Thu, 10 Dec 2009 15:16:08 +0200 (EET)
Received: from proxy.cante.net ([192.168.1.7] helo=jondo.cante.net)
	by picasso.cante.net with esmtp (Exim 4.69)
	(envelope-from <jari.aalto@cante.net>)
	id 1NIisI-0007WL-8T; Thu, 10 Dec 2009 15:16:06 +0200
Received: from jaalto by jondo.cante.net with local (Exim 4.69)
	(envelope-from <jari.aalto@cante.net>)
	id 1NIisJ-0004tK-BG; Thu, 10 Dec 2009 15:16:07 +0200
In-Reply-To: <20091210124929.GA444@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 10 Dec 2009 07:49:29 -0500")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
X-SA-Exim-Connect-IP: 192.168.1.7
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135023>

Jeff King <peff@peff.net> writes:

> On Thu, Dec 10, 2009 at 01:23:43PM +0100, Michael J Gruber wrote:
>
>> Print the sha1 of the deleted tag (in addition to the tag name) so that
>> one can easily recreate a mistakenly deleted tag:
>> 
>> git tag -d tagname
>> Deleted tag 'tagname' DEADBEEF
>> git tag 'tagname' DEADBEEF # for lightweight tags
>> git update-ref refs/tags/'tagname' DEADBEEF # for annotated tags

> That being said, I am not a fan of the cut-and-paste format. This is not
> something that happens so frequently

It dpends on user. For me it it does.

>   1. It is not immediately obvious to a user seeing this message
>      for this first time exactly what the trailing sha1 means.
>
>   2. Even if they know what it means, it is not immediately obvious that
>      the error line is meant to be cut-and-pasted.

"not meant" specifically, but it's very convenient to have it in format
that happens to be "cut-n-paste ready". The SHA itself is easily
understood in the context.

Thanks for all that have so quickly implemented this,
Jari
