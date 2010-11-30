From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH 1/2 maint] apply --whitespace=fix: fix tab-in-indent
Date: Tue, 30 Nov 2010 23:19:10 +0000
Message-ID: <20101130231909.GA2425@arachsys.com>
References: <4CF366B1.8070400@viscovery.net>
 <7vhbezwqan.fsf@alter.siamese.dyndns.org>
 <4CF4B42C.4080104@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Dec 01 00:57:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNa4s-0007tB-NI
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 00:57:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579Ab0K3X5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Nov 2010 18:57:37 -0500
Received: from alpha.arachsys.com ([91.203.57.7]:48756 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640Ab0K3X5g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Nov 2010 18:57:36 -0500
X-Greylist: delayed 2300 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Nov 2010 18:57:36 EST
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1PNZTc-0003ib-L9; Tue, 30 Nov 2010 23:19:13 +0000
Content-Disposition: inline
In-Reply-To: <4CF4B42C.4080104@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162493>

Johannes Sixt <j.sixt@viscovery.net> writes:

> When the whitespace rule tab-in-indent is enabled, apply --whitespace=fix
> replaces tabs by the appropriate amount of blanks. The code used
> "dst->len % 8" as the criterion to stop adding blanks. But it forgot that
> dst holds more than just the current line. Consequently, the modulus was
> computed correctly only for the first added line, but not for the second
> and subsequent lines. Fix it.

You're quite right! My mistake, so if you like, please feel free to add

Acked-by: Chris Webb <chris@arachsys.com>

Cheers,

Chris.
