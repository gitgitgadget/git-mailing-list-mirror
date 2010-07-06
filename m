From: tytso@mit.edu
Subject: Re: [PATCH] guilt: Make sure the commit time is increasing
Date: Tue, 6 Jul 2010 14:57:45 -0400
Message-ID: <20100706185745.GB26677@thunk.org>
References: <1278296639-25024-1-git-send-email-tytso@mit.edu>
 <20100705025900.GQ22659@josefsipek.net>
 <67D0ABD4-BD1A-4B7A-B3EC-F48F21B5DD01@mit.edu>
 <20100705185238.GS22659@josefsipek.net>
 <20100705192201.GI25518@thunk.org>
 <20100706172954.GD18795@josefsipek.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: jeffpc@josefsipek.net
X-From: git-owner@vger.kernel.org Tue Jul 06 20:57:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWDLC-0006mM-6A
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 20:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754542Ab0GFS5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 14:57:49 -0400
Received: from THUNK.ORG ([69.25.196.29]:42500 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752954Ab0GFS5s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 14:57:48 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1OWDL1-0001Fm-N0; Tue, 06 Jul 2010 14:57:47 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1OWDKz-0000Kr-Mf; Tue, 06 Jul 2010 14:57:45 -0400
Content-Disposition: inline
In-Reply-To: <20100706172954.GD18795@josefsipek.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150394>

On Tue, Jul 06, 2010 at 01:29:54PM -0400, jeffpc@josefsipek.net wrote:
> 
> And we're touching +1+1min.  I'll fix it up before applying.
> 

Yup, I forgot to take the "+ 60" out.  Thanks for catching that.

					- Ted
