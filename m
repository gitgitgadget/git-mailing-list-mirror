From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Trying to use AUTHOR_DATE
Date: Sat, 30 Apr 2005 14:08:40 +0200
Message-ID: <1114862920.17673.1.camel@localhost.localdomain>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
	 <42730061.5010106@zytor.com>
	 <Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org>
	 <20050430125333.2bd81b18.froese@gmx.de>
	 <1114859594.24014.60.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Edgar Toernig <froese@gmx.de>, Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Luck, Tony" <tony.luck@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 14:03:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRqh1-00010g-2l
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 14:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVD3MIx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 08:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVD3MIx
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 08:08:53 -0400
Received: from soundwarez.org ([217.160.171.123]:64488 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261204AbVD3MIo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2005 08:08:44 -0400
Received: from dhcp-113.off.vrfy.org (d029120.adsl.hansenet.de [80.171.29.120])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 17B9F2928F;
	Sat, 30 Apr 2005 14:08:40 +0200 (CEST)
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1114859594.24014.60.camel@localhost.localdomain>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-30 at 12:13 +0100, David Woodhouse wrote:
> On Sat, 2005-04-30 at 12:53 +0200, Edgar Toernig wrote:
> > +       tm = localtime(&now); /* get timezone and tm_isdst */
> > +       offset = -timezone / 60;
> > +       if (tm->tm_isdst > 0)
> > +               offset += 60;
> 
> Some locales have DST offsets which aren't 60 minutes, don't they?

Yes, some have half-hour offsets:
  http://www.timeanddate.com/library/abbreviations/timezones/au/nft.html

Kay

