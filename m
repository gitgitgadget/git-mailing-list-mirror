From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add commands that git-gc runs underneath
Date: Fri, 31 Aug 2007 23:27:46 +0200
Message-ID: <85hcmfbdil.fsf@lola.goethe.zz>
References: <lkbtwek0.fsf@cante.net>
	<Pine.LNX.4.64.0708301107320.28586@racer.site>
	<46D6984D.9040802@op5.se> <7v7inc907e.fsf@gitster.siamese.dyndns.org>
	<46D7E058.9050001@op5.se> <7vlkbrxvbm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 23:28:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRE2M-00046n-GV
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 23:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965835AbXHaV1w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 17:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965600AbXHaV1w
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 17:27:52 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:42557 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965783AbXHaV1v (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2007 17:27:51 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id AAE6612F8D;
	Fri, 31 Aug 2007 23:27:50 +0200 (CEST)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 95B252D378F;
	Fri, 31 Aug 2007 23:27:50 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-032.pools.arcor-ip.net [84.61.17.32])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 5126D12E80;
	Fri, 31 Aug 2007 23:27:50 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id A5C481D3DB8A; Fri, 31 Aug 2007 23:27:46 +0200 (CEST)
In-Reply-To: <7vlkbrxvbm.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 31 Aug 2007 14\:12\:13 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4112/Fri Aug 31 22:01:59 2007 on mail-in-11.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57216>

Junio C Hamano <gitster@pobox.com> writes:

> But my feeling is that we do not want to describe what happens
> solely in terms of what other individual commands do.  Referring to
> other manual pages for more details is fine, but that should not be
> the sole description.
>
> In other words, instead of saying:

[...]

> I think we would want to say it this way:

[...]

I would say your feeling is dead-on.  Full agreement with that
proposal.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
