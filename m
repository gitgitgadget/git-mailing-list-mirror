From: "Li Yang-r58472" <LeoLi@freescale.com>
Subject: RE: [PATCH] gitweb: Change to use explicitly function call cgi->escapHTML()
Date: Tue, 6 Mar 2007 18:31:23 +0800
Message-ID: <989B956029373F45A0B8AF02970818902DAA12@zch01exm26.fsl.freescale.net>
References: <20070306093917.GA1761@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: "Junio C Hamano" <junkio@cox.net>, <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>, "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 11:30:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOWvp-0002We-35
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 11:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933226AbXCFKaG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 05:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933227AbXCFKaG
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 05:30:06 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:53065 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933226AbXCFKaE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Mar 2007 05:30:04 -0500
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l26AU0qe001304
	for <git@vger.kernel.org>; Tue, 6 Mar 2007 03:30:00 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l26ATwNB015238
	for <git@vger.kernel.org>; Tue, 6 Mar 2007 04:29:59 -0600 (CST)
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20070306093917.GA1761@coredump.intra.peff.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] gitweb: Change to use explicitly function call cgi->escapHTML()
Thread-Index: Acdf01uDRbdM+4QPQHmUG8rvZsLSMgAAxgKw
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41567>

> -----Original Message-----
> From: Jeff King [mailto:peff@peff.net]
> Sent: Tuesday, March 06, 2007 5:39 PM
> To: Jakub Narebski
> Cc: Junio C Hamano; Li Yang-r58472; git@vger.kernel.org
> Subject: Re: [PATCH] gitweb: Change to use explicitly function call
> cgi->escapHTML()
> 
> On Tue, Mar 06, 2007 at 10:34:32AM +0100, Jakub Narebski wrote:
> 
> > >Regardless of the recent xhtml+html vs html discussion, I think
> > >this is probably a sane change.  Comments?
> > Good (although a bit magic) solution. Ack, FWIW.
> 
> I think this should do the same, and is perhaps less magic (or maybe
> more, depending on your perspective).

Yes, it also fixed the problem.  I'm not very familiar with perl.  Will
CGI::autoEscape(1) change CGI action for other users of CGI module on
the system?  If so, maybe it will break other CGIs.

- Leo
