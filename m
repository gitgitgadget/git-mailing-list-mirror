From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] Bugfix: undefined htmldir in config.mak.autogen
Date: Wed, 20 Feb 2013 09:42:41 +0000
Message-ID: <20130220094240.GB5011@serenity.lan>
References: <1be0a520b99fbfecd7255c1d26753015612856b3.1361272864.git.worldhello.net@gmail.com>
 <7v8v6j52qf.fsf@alter.siamese.dyndns.org>
 <7v4nh750v3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	"Christoph J. Thompson" <cjsthompson@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 10:43:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U86Cr-0006rV-Cf
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 10:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934684Ab3BTJmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 04:42:51 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:48274 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933774Ab3BTJmu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 04:42:50 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id A5CB51980B2;
	Wed, 20 Feb 2013 09:42:49 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zff5p0y3Y6Z0; Wed, 20 Feb 2013 09:42:49 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 624BC1980B1;
	Wed, 20 Feb 2013 09:42:42 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7v4nh750v3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216699>

On Tue, Feb 19, 2013 at 03:40:16PM -0800, Junio C Hamano wrote:
> I am not sure if such a layout can be actually used for installing,
> though.  Didn't we see some issues around the relativeness of
> htmldir and mandir vs passing them down to Documentation/Makefile,
> or is it not an issue when ./configure and config.mak.autogen is
> used?

If these variables are set explicitly in config.mak.autogen (or indeed
config.mak) then these values should override the ones calculated in the
Makefiles so that we avoid that problem - the problem occurs if the
relative paths from the top-level Makefile are exported to
Documentation/Makefile.


John
