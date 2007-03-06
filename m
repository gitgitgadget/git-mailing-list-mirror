From: "Li Yang-r58472" <LeoLi@freescale.com>
Subject: RE: [PATCH] gitweb: Change to use explicitly function call cgi->escapHTML()
Date: Tue, 6 Mar 2007 19:07:52 +0800
Message-ID: <989B956029373F45A0B8AF02970818902DAA14@zch01exm26.fsl.freescale.net>
References: <20070306110156.GA13380@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: "Jakub Narebski" <jnareb@gmail.com>, <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>, "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 12:06:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOXVE-0002Ki-L1
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 12:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbXCFLGg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 06:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbXCFLGf
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 06:06:35 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:34935 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964936AbXCFLGf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Mar 2007 06:06:35 -0500
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id l26B6VnS028053
	for <git@vger.kernel.org>; Tue, 6 Mar 2007 04:06:32 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l26B6SeQ020611
	for <git@vger.kernel.org>; Tue, 6 Mar 2007 05:06:29 -0600 (CST)
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20070306110156.GA13380@coredump.intra.peff.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] gitweb: Change to use explicitly function call cgi->escapHTML()
Thread-Index: Acdf3t9zdYBlBOgiSV6EkqrXZ0Ms+QAALweg
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41577>

> -----Original Message-----
> From: Jeff King [mailto:peff@peff.net]
> Sent: Tuesday, March 06, 2007 7:02 PM
> To: Junio C Hamano
> Cc: Li Yang-r58472; Jakub Narebski; git@vger.kernel.org
> Subject: Re: [PATCH] gitweb: Change to use explicitly function call
> cgi->escapHTML()
> 
> On Tue, Mar 06, 2007 at 02:58:37AM -0800, Junio C Hamano wrote:
> 
> > Sorry, what I meant to say was on top of Li's patch.
> 
> Ah, I understand your point now. Yes, if other mod_perl CGIs can
impact
> the value, then we should definitely set it explicitly, as per your
> patch (and we should use Li's patch for safety, then, not mine).

I agree.

-Leo
