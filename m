From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 1/2] handle color.ui at a central place
Date: Wed, 21 Jan 2009 23:35:24 +0100
Message-ID: <200901212335.24727.markus.heidelberg@web.de>
References: <20090117153846.GB27071@coredump.intra.peff.net> <200901182137.16562.markus.heidelberg@web.de> <20090120040448.GA30714@sigill.intra.peff.net>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: =?utf-8?q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 23:36:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPlgg-00039W-8u
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 23:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392AbZAUWfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 17:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753346AbZAUWfR
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 17:35:17 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:56318 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbZAUWfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 17:35:16 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 53B69F6DC0E4;
	Wed, 21 Jan 2009 23:35:14 +0100 (CET)
Received: from [89.59.73.85] (helo=pluto)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LPlfG-0007Sc-00; Wed, 21 Jan 2009 23:35:14 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <20090120040448.GA30714@sigill.intra.peff.net>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX185jWO1YT6+LqMitox4kGNhXJ9WguiGRW09sMP0
	EBG8GbldHcXEWRG3WDZlNhDhh5mVDfeJOTP5NzMYxiBpJDb3PR
	g0thynsEJeQ4I8D6rmzw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106691>

Jeff King, 20.01.2009:
> On Sun, Jan 18, 2009 at 09:37:15PM +0100, Markus Heidelberg wrote:
> 
> > Not sure, if you it has something to do with the following, but I had
> > this in my tree for some days now, waiting for the 2 commits mentioned
> > in the log message to graduate to master, which happend just an hour or
> > so ago.
> 
> I think this is probably an improvement, but I had in mind something a
> little more drastic. Right now we keep munging one variable that is our
> current idea of "should we do color" based on multiple config values.
> Then you end up with (best case) this "finalize color config", which is
> a bit ugly, or (worst case) bugs where the value hasn't always been

Yes, I didn't find it to be that great either.

> properly initialized (or finalized).
> 
> So I think it makes more sense to record each config value, and then
> check a _function_ that does the right thing. I.e., you end up with
> something like:
>
> [example code snipped]

That would probably be better.

Markus
