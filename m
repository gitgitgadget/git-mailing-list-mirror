From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/2] [RFC] Use --find- instead of --detect- as prefix for long forms of -M and -C.
Date: Thu, 11 Nov 2010 23:24:57 +0100
Message-ID: <201011112324.57572.trast@student.ethz.ch>
References: <1289420833-20602-1-git-send-email-ydirson@altern.org> <201011111147.04365.trast@student.ethz.ch> <20101111114404.GF8911@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Thu Nov 11 23:25:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGfZo-0006Wg-PR
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 23:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757029Ab0KKWY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 17:24:59 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:39607 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754706Ab0KKWY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 17:24:59 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 11 Nov
 2010 23:24:57 +0100
Received: from pctrast.inf.ethz.ch (217.162.250.31) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.218.12; Thu, 11 Nov
 2010 23:24:58 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.36-90-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <20101111114404.GF8911@home.lan>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161307>

Yann Dirson wrote:
> On Thu, Nov 11, 2010 at 11:47:04AM +0100, Thomas Rast wrote:
> > Yann Dirson wrote:
> > > Rationale: this is both shorter to spell and consistent with
> > > --find-copies-harder.
> > [...]
> > >  -M[<n>]::
> > > ---detect-renames[=<n>]::
> > > +--find-renames[=<n>]::
> > 
> > Umm.  The reasoning seems ok for me, but the farthest you can go is
> > deprecating the options.  Removing them as in
> > 
> > > -	else if (!prefixcmp(arg, "-M") || !prefixcmp(arg, "--detect-renames=") ||
> > > -		 !strcmp(arg, "--detect-renames")) {
> > > +	else if (!prefixcmp(arg, "-M") || !prefixcmp(arg, "--find-renames=") ||
> > > +		 !strcmp(arg, "--find-renames")) {
> > 
> > would break backwards compatibility.
> 
> I don't think we care with compatibility here, since those are not
> part of any release.

Ah well.  You're right of course, but you could have mentioned that
somewhere :-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
