From: "Medve Emilian" <Emilian.Medve@freescale.com>
Subject: RE: [PATCH] Remove git-status from list of scripts as it is builtin
Date: Tue, 27 Nov 2007 10:00:50 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E2701827FEA@az33exm24.fsl.freescale.net>
References: <20071123203508.GA6797@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 18:45:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix4V2-0002i0-2N
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 18:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757073AbXK0RpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 12:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756781AbXK0RpL
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 12:45:11 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:37620 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756565AbXK0RpK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2007 12:45:10 -0500
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id lARHhKiG012438
	for <git@vger.kernel.org>; Tue, 27 Nov 2007 10:45:06 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lARH0rOa018158
	for <git@vger.kernel.org>; Tue, 27 Nov 2007 11:00:53 -0600 (CST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <20071123203508.GA6797@spearce.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Remove git-status from list of scripts as it is builtin
thread-index: AcguEGQmvi7rJ2qQRWej63wetkDPkgDBpNGg
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66248>

Hi Shawn,


That does the trick. Thanks.


Cheers,
Emil.


> -----Original Message-----
> From: git-owner@vger.kernel.org 
> [mailto:git-owner@vger.kernel.org] On Behalf Of Shawn O. Pearce
> Sent: Friday, November 23, 2007 2:35 PM
> To: Junio C Hamano
> Cc: git@vger.kernel.org
> Subject: [PATCH] Remove git-status from list of scripts as it 
> is builtin
> 
> Now that git-status is builtin on Cygwin this compiles as
> git-status.exe.  We cannot continue to include git-status
> as a Makefile target as it will never be built.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
> 
>  I apologize if this is a dupe; I haven't had a chance to read
>  the list traffic to see what has been posted and what hasn't.
>  I'll be offline for the next few days so I figured I should get
>  this out there now, just in case anyone else might run into the
>  same problem I did.
> 
>  Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 313f9a2..a5a40ce 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -233,7 +233,7 @@ SCRIPT_PERL = \
>  
>  SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
>  	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
> -	  git-status git-instaweb
> +	  git-instaweb
>  
>  # ... and all the rest that could be moved out of bindir to 
> gitexecdir
>  PROGRAMS = \
> -- 
> 1.5.3.6.1936.gc44a9
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
