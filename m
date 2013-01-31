From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] Rename {git- => git}remote-helpers.txt
Date: Thu, 31 Jan 2013 22:28:17 +0000
Message-ID: <20130131222817.GP1342@serenity.lan>
References: <7v1ud1gke7.fsf@alter.siamese.dyndns.org>
 <3f26b82599aa2a45897d345c851fab4751c55810.1359669205.git.john@keeping.me.uk>
 <7vy5f9dmrt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 23:28:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U12ck-0000XQ-1g
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 23:28:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756247Ab3AaW22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 17:28:28 -0500
Received: from pichi.aluminati.org ([72.9.246.58]:34242 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755044Ab3AaW21 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 17:28:27 -0500
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 3858C161E3FB;
	Thu, 31 Jan 2013 22:28:26 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: 0.775
X-Spam-Level: 
X-Spam-Status: No, score=0.775 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLACK=1.775] autolearn=no
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2HbnzzxSt5PV; Thu, 31 Jan 2013 22:28:25 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 13E58161E394;
	Thu, 31 Jan 2013 22:28:19 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vy5f9dmrt.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215177>

On Thu, Jan 31, 2013 at 02:13:10PM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > When looking up a topic via "git help <topic>", git-help prepends "git-"
> > to topics that are the names of commands (either builtin or found on the
> > path) and "git" (no hyphen) to any other topic name.
> >
> > "git-remote-helpers" is not the name of a command, so "git help
> > remote-helpers" looks for "gitremote-helpers" and does not find it.
> >
> > Fix this by renaming "git-remote-helpers.txt" to
> > "gitremote-helpers.txt".
> >
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> >
> > ---
> > Changes since v1:
> >
> > - add gitremote-helpers.txt to the Makefile since it is no longer caught
> >   by git-*.txt.
> >
> > - add a simple git-remote-helpers.html to help people following links to
> >   the old name.
> 
> Doesn't "make clean" remove the placeholder file?

Yes.  Should I change it to "git-remote-helpers.html.in" and then copy
it into place?  That seems like the simplest answer and means that
"*.html" will continue to refer only to generated files.


John
