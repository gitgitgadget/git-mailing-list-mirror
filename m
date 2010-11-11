From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH 1/2] [RFC] Use --find- instead of --detect- as prefix
 for long forms of -M and -C.
Date: Thu, 11 Nov 2010 12:44:04 +0100
Message-ID: <20101111114404.GF8911@home.lan>
References: <1289420833-20602-1-git-send-email-ydirson@altern.org>
 <1289420833-20602-2-git-send-email-ydirson@altern.org>
 <201011111147.04365.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Nov 11 12:44:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGVZl-0005Zn-Gs
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 12:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669Ab0KKLoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 06:44:13 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:36907 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755119Ab0KKLoM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 06:44:12 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id C5A68D4815F;
	Thu, 11 Nov 2010 12:44:05 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PGVZU-0006pB-IT; Thu, 11 Nov 2010 12:44:04 +0100
Content-Disposition: inline
In-Reply-To: <201011111147.04365.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161228>

On Thu, Nov 11, 2010 at 11:47:04AM +0100, Thomas Rast wrote:
> Yann Dirson wrote:
> > Rationale: this is both shorter to spell and consistent with
> > --find-copies-harder.
> [...]
> >  -M[<n>]::
> > ---detect-renames[=<n>]::
> > +--find-renames[=<n>]::
> 
> Umm.  The reasoning seems ok for me, but the farthest you can go is
> deprecating the options.  Removing them as in
> 
> > -	else if (!prefixcmp(arg, "-M") || !prefixcmp(arg, "--detect-renames=") ||
> > -		 !strcmp(arg, "--detect-renames")) {
> > +	else if (!prefixcmp(arg, "-M") || !prefixcmp(arg, "--find-renames=") ||
> > +		 !strcmp(arg, "--find-renames")) {
> 
> would break backwards compatibility.

I don't think we care with compatibility here, since those are not
part of any release.

-- 
Yann
