From: Jeff King <peff@peff.net>
Subject: Re: make test failure with latest master
Date: Sun, 2 Dec 2007 11:34:26 -0500
Message-ID: <20071202163426.GA29781@coredump.intra.peff.net>
References: <4752A53E.4030000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 17:34:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyrmN-0006SI-93
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 17:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbXLBQe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 11:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752501AbXLBQe3
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 11:34:29 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2033 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752422AbXLBQe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 11:34:28 -0500
Received: (qmail 21801 invoked by uid 111); 2 Dec 2007 16:34:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Dec 2007 11:34:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Dec 2007 11:34:26 -0500
Content-Disposition: inline
In-Reply-To: <4752A53E.4030000@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66789>

On Sun, Dec 02, 2007 at 07:29:50AM -0500, A Large Angry SCM wrote:

> With the latest master, 2221a6757161af1905925c405aded9ff470f70d5, "make 
> test" now fails; last successful "make test" was mid-week sometime with 
> master d25430. This is on a laptop running Suse 9.3.
>
> *** t9600-cvsimport.sh ***
> *   ok 1: setup cvsroot
> *   ok 2: setup a cvs module
> * FAIL 3: import a trivial module
>
>
>                 git cvsimport -a -z 0 -C module-git module &&
>                 git diff module-cvs/o_fortuna module-git/o_fortuna

Can you please try ./t9600 --verbose? Presumably cvsimport is generating
some kind of error message to tell us what's going on.

-Peff
