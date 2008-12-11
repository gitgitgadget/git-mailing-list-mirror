From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 4/5] Define Patch to parse a sequence of patch FileHeaders
Date: Thu, 11 Dec 2008 21:23:49 +0100
Message-ID: <200812112123.49659.robin.rosenberg.lists@dewire.com>
References: <1228971522-28764-1-git-send-email-spearce@spearce.org> <200812111934.13218.robin.rosenberg.lists@dewire.com> <20081211183954.GH32487@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 21:25:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAs6E-0004Pv-6i
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 21:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756859AbYLKUXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 15:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756884AbYLKUXy
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 15:23:54 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:62690 "EHLO
	pne-smtpout2-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756871AbYLKUXx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Dec 2008 15:23:53 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout2-sn1.fre.skanova.net (7.3.129)
        id 4843FAEB02DA6506; Thu, 11 Dec 2008 21:23:51 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <20081211183954.GH32487@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102815>

torsdag 11 december 2008 19:39:54 skrev Shawn O. Pearce:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > > +		assertEquals(572, fRepositoryConfigTest.startOffset);
> > > +		assertEquals(1490, fRepositoryConfig.startOffset);
> >
> > 1487 here
> 
> Really?  1490 is the only value that the test vector passes with.
> What's the 3 bytes you think I'm off by?

Ah, --whitespace=fix did that.

-- robin
