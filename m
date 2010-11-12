From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH 1/2] [RFC] Use --find- instead of --detect- as prefix
 for long forms of -M and -C.
Date: Fri, 12 Nov 2010 08:21:55 +0100
Message-ID: <20101112072154.GJ3167@home.lan>
References: <1289420833-20602-1-git-send-email-ydirson@altern.org>
 <201011111147.04365.trast@student.ethz.ch>
 <20101111114404.GF8911@home.lan>
 <201011112324.57572.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@free.fr>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Nov 12 08:22:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGnxr-000485-0l
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 08:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510Ab0KLHWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 02:22:05 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:44143 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752052Ab0KLHWE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 02:22:04 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 35FFED48018;
	Fri, 12 Nov 2010 08:21:56 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PGnxL-00015O-0n; Fri, 12 Nov 2010 08:21:55 +0100
Content-Disposition: inline
In-Reply-To: <201011112324.57572.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161326>

On Thu, Nov 11, 2010 at 11:24:57PM +0100, Thomas Rast wrote:
> Yann Dirson wrote:
> > On Thu, Nov 11, 2010 at 11:47:04AM +0100, Thomas Rast wrote:
> > > Yann Dirson wrote:
> > > > Rationale: this is both shorter to spell and consistent with
> > > > --find-copies-harder.
> > > [...]
> > > >  -M[<n>]::
> > > > ---detect-renames[=<n>]::
> > > > +--find-renames[=<n>]::
> > > 
> > > Umm.  The reasoning seems ok for me, but the farthest you can go is
> > > deprecating the options.  Removing them as in
> > > 
> > > > -	else if (!prefixcmp(arg, "-M") || !prefixcmp(arg, "--detect-renames=") ||
> > > > -		 !strcmp(arg, "--detect-renames")) {
> > > > +	else if (!prefixcmp(arg, "-M") || !prefixcmp(arg, "--find-renames=") ||
> > > > +		 !strcmp(arg, "--find-renames")) {
> > > 
> > > would break backwards compatibility.
> > 
> > I don't think we care with compatibility here, since those are not
> > part of any release.
> 
> Ah well.  You're right of course, but you could have mentioned that
> somewhere :-)

Ah, I was sure I did, but apprently not :)
