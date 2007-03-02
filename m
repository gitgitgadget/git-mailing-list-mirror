From: "Li Yang-r58472" <LeoLi@freescale.com>
Subject: RE: gitweb not friendly to firefox?
Date: Fri, 2 Mar 2007 10:28:55 +0800
Message-ID: <989B956029373F45A0B8AF02970818902DA75D@zch01exm26.fsl.freescale.net>
References: <20070301140046.GM57456@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: <rea-git@codelabs.ru>, "Raimund Bauer" <ray@softwarelandschaft.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 03:28:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMxVL-0000C0-PU
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 03:28:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422791AbXCBC1o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 21:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422790AbXCBC1n
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 21:27:43 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:36893 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422792AbXCBC1n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Mar 2007 21:27:43 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id l222RXDw009421
	for <git@vger.kernel.org>; Thu, 1 Mar 2007 19:27:34 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l222RWdY001753
	for <git@vger.kernel.org>; Thu, 1 Mar 2007 20:27:33 -0600 (CST)
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20070301140046.GM57456@codelabs.ru>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: gitweb not friendly to firefox?
Thread-Index: AcdcCha9sD38BpJbQ46EUnlE7/qsMgAZOtUw
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41155>

> -----Original Message-----
> From: rea-git@codelabs.ru [mailto:rea-git@codelabs.ru]
> Sent: Thursday, March 01, 2007 10:01 PM
> To: Raimund Bauer
> Cc: Li Yang-r58472; git@vger.kernel.org
> Subject: Re: gitweb not friendly to firefox?
> 
> > > Line Number 43, Column 38:<tr><td>author</td><td>Li Yang
> > <LeoLi@freescale.com></td></tr>
-------------------------------------^
> >
> > Try to save the output and verify it with some other xml-parser. The
> > "<LeoLi@freescale.com>" seems to be the culprit here, since "@" is
no
> > allowed character for a xml-tag, and there maybe is some
html-escaping of
> > the email address missing?
> 
> I think that the situation is simpler: <LeoLi@....> is taken as the
> XML/HTML tag and it
> - does not closed anywhere,
> - has the wrong syntax, since "@" and "." can not live inside the
> tag name if memory serves me right.
> 
> The proper thing is to replace "<" with "&lt;" and ">" with "&gt;".

Yes, you are right.  But why gitweb didn't do that for me?  I observed
that some early version of gitweb doesn't have this problem.  Is it
possible that some new change caused this?

- Leo
