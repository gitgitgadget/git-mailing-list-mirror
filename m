From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 1/2] Add "--only-untracked" flag to status commands.
Date: Thu, 23 Aug 2007 22:50:11 +0200
Message-ID: <vpqabsikmbg.fsf@bauges.imag.fr>
References: <11878991123605-git-send-email-v@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
X-From: git-owner@vger.kernel.org Thu Aug 23 22:51:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOJe9-0001Us-HU
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 22:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760726AbXHWUvO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 23 Aug 2007 16:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759028AbXHWUvO
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 16:51:14 -0400
Received: from imag.imag.fr ([129.88.30.1]:42990 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759954AbXHWUvN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 16:51:13 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l7NKoBFs026450
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 23 Aug 2007 22:50:13 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IOJd5-0007ZI-9C; Thu, 23 Aug 2007 22:50:11 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IOJd5-00079Z-6l; Thu, 23 Aug 2007 22:50:11 +0200
In-Reply-To: <11878991123605-git-send-email-v@pp.inet.fi>
 (=?iso-8859-1?Q?=22V=E4in=F6_J=E4rvel=E4=22's?= message of "Thu\, 23 Aug
 2007 22\:58\:31 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 23 Aug 2007 22:50:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56531>

V=E4in=F6 J=E4rvel=E4 <v@pp.inet.fi> writes:

> Subject: Re: [PATCH 1/2] Add "--only-untracked" flag to status comman=
ds.
                                       ^^

I suppose you meant --only-tracked.

>  static const char runstatus_usage[] =3D
> -"git-runstatus [--color|--nocolor] [--amend] [--verbose] [--untracke=
d]";
> +"git-runstatus [--color|--nocolor] [--amend] [--verbose]
> [--untracked]" "[--only-tracked]";
               ^^^

The compiler will concatenate the strings, but won't add a space. That
results in "... [--untracked][--only-tracked]".

Otherwise, the patch sounds fine to me. Not /terribly/ usefull, but
why not.

--=20
Matthieu
