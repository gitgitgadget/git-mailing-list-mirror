From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation: A few minor fixes to Git User's Manual
Date: Tue, 3 Apr 2007 13:21:13 -0400
Message-ID: <20070403172113.GB26201@fieldses.org>
References: <11756176481314-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 19:21:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYmhU-00067O-Ge
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 19:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965714AbXDCRVQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 13:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965918AbXDCRVQ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 13:21:16 -0400
Received: from mail.fieldses.org ([66.93.2.214]:50606 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965714AbXDCRVP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 13:21:15 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HYmgz-0001cp-Fu; Tue, 03 Apr 2007 13:21:13 -0400
Content-Disposition: inline
In-Reply-To: <11756176481314-git-send-email-jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43633>

On Tue, Apr 03, 2007 at 06:27:28PM +0200, Jakub Narebski wrote:
> Mainly consistent usage of "git command" and not "git-command" syntax

Looks good, thanks!

> A few [shorthand] comments about Git User's Manual:

And thanks very much for the comments.

> * inconsistent use of header levels
>         Level 0 (top level):     ======================
>         Level 1:                 ----------------------
>         Level 2:                 ~~~~~~~~~~~~~~~~~~~~~~
>         Level 3:                 ^^^^^^^^^^^^^^^^^^^^^^
>         Level 4 (bottom level):  ++++++++++++++++++++++

Have you found internal inconsistencies, or are you just referring to
the fact that it's using different syntax from the default?

My original intention was to suck in other articles under Documentation/
as chapters.  Shifting all the headers by one allows us to do that, at
least initially, by just including the articles without modification.
The glossary is the only thing we're currently using that way, though.

The "Git interals" chapter is obviously most taken from the README,
which has gotten out of date in a few places.

My vague medium-term plan is to revise that chapter and then merge
tutorial-2.txt into it, and maybe core-tutorial too, but I haven't had
time to work on it recently.  (Any help appreciated.)

I'd kinda like to remove all the tutorials some day and absorb them into
the manual instead, but maybe that would be unpopular.

--b.
