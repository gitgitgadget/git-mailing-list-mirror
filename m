From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Rebasing stgit stacks
Date: Fri, 19 Jan 2007 10:40:16 +0100
Message-ID: <200701191040.17476.jnareb@gmail.com>
References: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com> <eojn5c$v9u$1@sea.gmane.org> <20070117205301.GH9761@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 10:39:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7qDu-0000Gt-RJ
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 10:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbXASJjs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 04:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbXASJjs
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 04:39:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:49168 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965025AbXASJjq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 04:39:46 -0500
Received: by ug-out-1314.google.com with SMTP id 44so412864uga
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 01:39:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Id82p/fHEQWcMAslqU0jlatLgO43QSpoAQpnY6ZkJk6BVfzAxw35Vt/JdqzwWcy44wRfGhLURepv+lS4ifXBFoA/jnvIjKRUUAFhtbUiR0h1Cx6jRvoUD1wHnE4UHcCy1ORimwimHieeKBJb/dhdVuXGNeB0IGjQujNu+hE7az0=
Received: by 10.67.21.11 with SMTP id y11mr2725718ugi.1169199584275;
        Fri, 19 Jan 2007 01:39:44 -0800 (PST)
Received: from host-81-190-20-200.torun.mm.pl ( [81.190.20.200])
        by mx.google.com with ESMTP id a1sm2319651ugf.2007.01.19.01.39.42;
        Fri, 19 Jan 2007 01:39:43 -0800 (PST)
To: Yann Dirson <ydirson@altern.org>
User-Agent: KMail/1.9.3
In-Reply-To: <20070117205301.GH9761@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37167>

On Wed, Jan 17, 2007 Yann Dirson wrote:
> On Wed, Jan 17, 2007 at 12:30:18AM +0100, Jakub Narebski wrote:

>> I'm all for calling this command "stg rebase".
> 
> After all, my current implementation as "pull --to" mostly bypasses
> the fetch, so it probably makes sense to use a new command.
> 
> However, "stg rebase <target>" does not sound right.  I'm not very
> happy with "stg rebaseto <target>" (or rebase-to) either.
> "stg rebase --to <target>" may feel strange too (command without
> non-option arg), but may finally a good choice after all ?  What do
> others think ?

First, "stg rebase" when on some git branch might mean rebase StGIT
stack to head of current branch (because there were some git commits
on top of this branch). So it would be "stg rebase [--onto <target>]";
it would be command without non-option arg, but this arg would be
optional.

Second, if you were to implement separating commands into subcommands
(perhaps just as alternative names) depending on what they act on:
"stg stack <subcommand>", "stg patch <subcommand>" etc., this would
I think belong to "stg base <subcommand>".
-- 
Jakub Narebski
Poland
