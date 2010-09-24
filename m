From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] mergetool-lib: add a three-way diff view for
 vim/gvim
Date: Fri, 24 Sep 2010 17:38:52 -0400
Message-ID: <20100924213852.GB19676@sigill.intra.peff.net>
References: <1284517303-17244-1-git-send-email-dpmcgee@gmail.com>
 <1284517303-17244-2-git-send-email-dpmcgee@gmail.com>
 <20100918073428.GA9850@gmail.com>
 <AANLkTim_hwduHk-ENM73dwHUj9XbwfihZPRfsHX+M3DE@mail.gmail.com>
 <AANLkTin-BSAFwvuTyJ96BW6MqrKVEni+Af2M0u7WE_yZ@mail.gmail.com>
 <20100924190928.GC3768@vfa-6z.perlninja.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dan McGee <dpmcgee@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Charles Bailey <charles@hashpling.org>
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 23:39:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzFys-0002ER-Um
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 23:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758157Ab0IXVi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 17:38:56 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35476 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758151Ab0IXViz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 17:38:55 -0400
Received: (qmail 21655 invoked by uid 111); 24 Sep 2010 21:38:54 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 24 Sep 2010 21:38:54 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Sep 2010 17:38:52 -0400
Content-Disposition: inline
In-Reply-To: <20100924190928.GC3768@vfa-6z.perlninja.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157064>

On Fri, Sep 24, 2010 at 12:09:28PM -0700, Jacob Helwig wrote:

> > So are these patches good to go forward with? No major objections in a
> > over a week's time.
> > 
> > -Dan
> 
> I'd +1 David's suggestion of calling this "vimdiff3", I'd like to still
> be able to access the current behavior, since I have merge.conflictstyle
> = diff3, and already see the merge base when I use (g)vimdiff with
> mergetool.

Of course as soon as I say "nobody objected" in my other email, this
arrives. :)

Can we provide both, but make the vimdiff3 behavior the preferred
default? It better matches the default merge.conflictstyle, and people
who are using diff3 obviously understand how to tweak config.

-Peff
