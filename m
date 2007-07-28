From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/2] gitk: Markup many strings for translation.
Date: Sat, 28 Jul 2007 12:39:23 +1000
Message-ID: <18090.44123.905869.974967@cargo.ozlabs.ibm.com>
References: <20070727165318.e96b1yxxwsooo884@webmail.tu-harburg.de>
	<20070727170300.t01ku4u2sg04sgsk@webmail.tu-harburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Sat Jul 28 04:39:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEcDj-0002n1-BI
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 04:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbXG1Cjk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 22:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759980AbXG1Cjj
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 22:39:39 -0400
Received: from ozlabs.org ([203.10.76.45]:52556 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756857AbXG1Cji (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 22:39:38 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id D8A4DDDE24; Sat, 28 Jul 2007 12:39:36 +1000 (EST)
In-Reply-To: <20070727170300.t01ku4u2sg04sgsk@webmail.tu-harburg.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53989>

Christian Stimming writes:

> Similar to the discussion in git-gui, all user-visible strings are  
> passed through the [mc ...] procedure to have them translated by msgcat.
> 
> Signed-off-by: Christian Stimming <stimming@tuhh.de>
> ---
> @Paul: Are you interested in applying this? If yes, I'd happily  

Yes, it doesn't look too bad.  The patch seemed to be line-wrapped and
whitespace-damaged, though.

> provide the Makefile rules for string extraction and translation  
> catalog updates, but I'd like to hear a proposal or decision on where  
> to place them. Should the po files for translation go into the po/  
> subdirectory? And then a proposal/decision of where to install the  
> compiled .msg catalogs will be necessary.

Yes indeed.  Junio?

Is it possible to include the translations, or at least the more
common translations, in the Tcl code itself?  So far I have managed to
have gitk be self-contained, in that it doesn't need any external data
files, which simplifies installation and is a useful attribute in some
situations.

Also I would want to be sure that gitk wouldn't crash or fail to
function if it can't find its message catalogs.

Paul.
