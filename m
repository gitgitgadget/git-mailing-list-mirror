From: John Keeping <john@keeping.me.uk>
Subject: Re: cvsps: bad usage: invalid argument --norc
Date: Sun, 14 Apr 2013 10:47:56 +0100
Message-ID: <20130414094756.GA2278@serenity.lan>
References: <323381594.20130414121834@gmail.com>
 <673219382.20130414124800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: esr@thyrsus.com, git@vger.kernel.org
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 11:48:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URJXi-0008NY-6z
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 11:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317Ab3DNJsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 05:48:09 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:41166 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab3DNJsI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 05:48:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 36FEFCDA525;
	Sun, 14 Apr 2013 10:48:07 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5yA2VSLQHhTa; Sun, 14 Apr 2013 10:48:06 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 31E23CDA5B9;
	Sun, 14 Apr 2013 10:48:01 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <673219382.20130414124800@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221090>

On Sun, Apr 14, 2013 at 12:48:00PM +0400, Ilya Basin wrote:
> IB> Hi esr.
> IB> In cvsps 3.10 the flag --norc was removed. It broke 'git cvsimport'.
> IB> Please give the option back and write something in the man page like:
> IB>     This option has no effect; it is present for compatibility
> 
> Looks like the tool is completely different. I think I'll have to
> downgrade.

If you want incremental import support, then that's the best thing to
do.  There was some discussion about this in January [1] and it doesn't
look like cvsps-3 has changed since then, so if you want to
incrementally update a Git clone of a CVS repository then cvsps-2 is
really the only way to go.

If you're doing a one-off import then I recommend ignoring git-cvsimport
and investigating cvs2svn[2] and cvs-fast-export [3].

[1] http://thread.gmane.org/gmane.comp.version-control.git/214258/focus=214305
[2] http://cvs2svn.tigris.org/cvs2git.html
[3] https://gitorious.org/cvs-fast-export
