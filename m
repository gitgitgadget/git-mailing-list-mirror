From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Re: Workflow: split repository?
Date: Fri, 12 Oct 2007 16:57:01 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200710121657.01256.wielemak@science.uva.nl>
References: <200710121421.39159.wielemak@science.uva.nl> <20071012143043.GD7865@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Oct 12 17:17:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgM2w-0005kz-R1
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 17:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381AbXJLPDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 11:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754370AbXJLPDQ
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 11:03:16 -0400
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:4190 "EHLO
	smtp-vbr10.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbXJLPDP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 11:03:15 -0400
Received: from gollem.science.uva.nl (gollem.science.uva.nl [146.50.26.20])
	(authenticated bits=0)
	by smtp-vbr10.xs4all.nl (8.13.8/8.13.8) with ESMTP id l9CF2wFI045844;
	Fri, 12 Oct 2007 17:02:59 +0200 (CEST)
	(envelope-from wielemak@science.uva.nl)
User-Agent: KMail/1.9.5
In-Reply-To: <20071012143043.GD7865@efreet.light.src>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60696>

Hi Jan,

On Friday 12 October 2007 16:30, Jan Hudec wrote:
> On Fri, Oct 12, 2007 at 14:21:39 +0200, Jan Wielemaker wrote:
> > Does this make sense?
>
> It might make more sense to convert bit by bit, to separate git
> repositories. Would save you some git-filter-branch work.

> > Is the only way to create a GIT repositiory right away from a subset of
> > the CVS for which we want to preserve the history?
>
> No, it's not. It will save you work if you can do as much splitting as
> possible during the conversion, ie. convert the bits you know will be
> separate separately (and combine them using submodules as appropriate).
>
> But if you have bits that will take a lot of work to factor out, you can
> convert to git, make the other code ready to use a submodule and than use
> git-filter-branch to extract the right bits of history for the submodule.

Thanks!  git-filter-branch looks a bit overwhelming, but I think I can
manage :-)  I'll do the simple things in separate conversions.

	Cheers --- Jan
