From: "Haruki Dai-r35557" <Dai.Haruki@freescale.com>
Subject: RE: problem with plain git clone
Date: Wed, 3 May 2006 09:24:40 -0700
Message-ID: <18AEF66AFDF06F4CAAA1D419D000FD3349E710@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 03 18:25:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbK9p-0000yd-Sy
	for gcvg-git@gmane.org; Wed, 03 May 2006 18:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWECQYz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 12:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965237AbWECQYz
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 12:24:55 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:45030 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S965236AbWECQYy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 12:24:54 -0400
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id k43He2lv006208
	for <git@vger.kernel.org>; Wed, 3 May 2006 11:40:02 -0600 (MDT)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k43GQxTg024605
	for <git@vger.kernel.org>; Wed, 3 May 2006 11:27:00 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: problem with plain git clone
Thread-Index: AcZuyN/HthY5TG7qQUihHacOY3Q76wABQfIQ
To: "Kumar Gala" <galak@kernel.crashing.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19498>

Hi Kumar,
 Could you enable post update hook? I couldn't clone through http:. 
Thanks,
Dai 

> -----Original Message-----
> From: git-owner@vger.kernel.org 
> [mailto:git-owner@vger.kernel.org] On Behalf Of Kumar Gala
> Sent: Wednesday, May 03, 2006 10:46 AM
> To: Shawn Pearce
> Cc: git@vger.kernel.org
> Subject: Re: problem with plain git clone
> 
> 
> On May 3, 2006, at 9:31 AM, Shawn Pearce wrote:
> 
> > Kumar Gala <galak@kernel.crashing.org> wrote:
> >> Anyone see an issues like the following:
> >>
> >> [kgala@kgala_lnx z]$ git clone 
> git://git.kernel.org:/pub/scm/boot/u-
> >> boot/galak/u-boot.git
> >> git clone 
> git://git.kernel.org:/pub/scm/boot/u-boot/galak/u-boot.git
> >> fatal: unable to connect a socket (Connection timed out)
> >
> > There's no GIT daemon running on the empty port.  Notice the ':'
> > appearing right after '.org'.
> >
> > Hmm, that sounds like a bug in the protocol URL parser...
> 
> Yeah, that was it. thanks.
> 
> - kumar
> -
> To unsubscribe from this list: send the line "unsubscribe 
> git" in the body of a message to majordomo@vger.kernel.org 
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
