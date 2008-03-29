From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with non-ascii characters
Date: Sat, 29 Mar 2008 09:44:55 +0100
Message-ID: <200803290944.55273.robin.rosenberg.lists@dewire.com>
References: <20080328212700.GA9529@coredump.intra.peff.net> <200803290819.07280.robin.rosenberg.lists@dewire.com> <20080329072203.GA17625@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 29 09:46:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfWhp-0004S6-2e
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 09:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753694AbYC2Ipr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 04:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753726AbYC2Ipr
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 04:45:47 -0400
Received: from [83.140.172.130] ([83.140.172.130]:27368 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753691AbYC2Ipq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 04:45:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 924398026E9;
	Sat, 29 Mar 2008 09:45:45 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3eaaOr1JvSDi; Sat, 29 Mar 2008 09:45:45 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 279BA800782;
	Sat, 29 Mar 2008 09:45:45 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20080329072203.GA17625@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78454>

Den Saturday 29 March 2008 08.22.03 skrev Jeff King:
> On Sat, Mar 29, 2008 at 08:19:07AM +0100, Robin Rosenberg wrote:
> > Den Friday 28 March 2008 22.29.01 skrev Jeff King:
> > > We always use 'utf-8' as the encoding, since we currently
> > > have no way of getting the information from the user.
> >
> > Don't set encoding to UTF-8 unless it actually looks like UTF-8.
>
> OK. Do you have an example function that guesses with high probability
> whether a string is utf-8? If there are non-ascii characters but we
> _don't_ guess utf-8, what should we do?

I guess the best bet is to assume the locale. Btw, is the encoding header
from the commit (when present) completely lost? (not that it can be trusted
anyway).

-- robin
