From: Christopher Faylor <me@cgf.cx>
Subject: Re: [PATCH] Teach git-checkout-index to read filenames from stdin.
Date: Wed, 1 Mar 2006 10:50:53 -0500
Message-ID: <20060301155053.GC1010@trixie.casa.cgf.cx>
References: <20060301024333.GB21186@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Mar 01 16:51:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FETbR-0000oh-Ax
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 16:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWCAPu4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 10:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWCAPu4
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 10:50:56 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:3779 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S932406AbWCAPuz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 10:50:55 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id 70EE84A819D; Wed,  1 Mar 2006 10:50:53 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060301024333.GB21186@spearce.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16982>

On Tue, Feb 28, 2006 at 09:43:33PM -0500, Shawn Pearce wrote:
>Since git-checkout-index is often used from scripts which may have a
>stream of filenames they wish to checkout it is more convenient to use
>--stdin than xargs.  On platforms where fork performance is currently
>sub-optimal and the length of a command line is limited (*cough* Cygwin
>*cough*)

AFAIK, the length of the command line for cygwin apps is very large --
if you're using recent versions of Cygwin.  I believe that it is longer
than the linux default.  We bypass the Windows mechanism for setting the
command line when a cygwin program starts a cygwin program.

For native Windows programs, the command line length is ~32K but I don't
think that git uses any native Windows programs, does it?

cgf
