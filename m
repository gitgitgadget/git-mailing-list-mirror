From: "Li Yang-r58472" <LeoLi@freescale.com>
Subject: RE: gitweb not friendly to firefox?
Date: Fri, 2 Mar 2007 14:47:59 +0800
Message-ID: <989B956029373F45A0B8AF02970818902DA7E4@zch01exm26.fsl.freescale.net>
References: <7v4pp4ntpo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: <rea-git@codelabs.ru>,
	"Raimund Bauer" <ray@softwarelandschaft.com>, <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 02 07:46:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN1XR-0001Pu-LR
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 07:46:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422901AbXCBGqm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 01:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422972AbXCBGql
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 01:46:41 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:62348 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422901AbXCBGql convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2007 01:46:41 -0500
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l226kb9d021617
	for <git@vger.kernel.org>; Thu, 1 Mar 2007 23:46:38 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l226kabv025500
	for <git@vger.kernel.org>; Fri, 2 Mar 2007 00:46:37 -0600 (CST)
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <7v4pp4ntpo.fsf@assigned-by-dhcp.cox.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: gitweb not friendly to firefox?
Thread-Index: AcdchPuE/v1eQ+oGQtiE0SV5RopphwAEUh1g
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41161>

> -----Original Message-----
> From: Junio C Hamano [mailto:junkio@cox.net]
> Sent: Friday, March 02, 2007 12:41 PM
> To: Li Yang-r58472
> Cc: rea-git@codelabs.ru; Raimund Bauer; git@vger.kernel.org
> Subject: Re: gitweb not friendly to firefox?
> 
> "Li Yang-r58472" <LeoLi@freescale.com> writes:
> 
> >> The proper thing is to replace "<" with "&lt;" and ">" with "&gt;".
> >
> > Yes, you are right.  But why gitweb didn't do that for me?  I
observed
> > that some early version of gitweb doesn't have this problem.  Is it
> > possible that some new change caused this?
> 
> It's very possible.

Well, I had found out that the escapeHTML() is not functioning on my
server.  It leaves the "<", ">", "@" unchanged.  Does anyone have a clue
about it?  I'm using Redhat 9.0 full installation.

- Leo
