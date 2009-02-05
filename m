From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: How to use git-fmt-merge-msg?
Date: Thu, 5 Feb 2009 13:59:31 +0100
Message-ID: <adf1fd3d0902050459s4fcb914ai2b9c8c04e9f72b02@mail.gmail.com>
References: <84B3CCAA-A044-4517-B2C8-14D5DD754FD2@manchester.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Robert Haines <rhaines@manchester.ac.uk>
X-From: git-owner@vger.kernel.org Thu Feb 05 14:01:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV3qq-0006ug-SE
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 14:01:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376AbZBEM7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 07:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753953AbZBEM7e
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 07:59:34 -0500
Received: from mu-out-0910.google.com ([209.85.134.191]:58212 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754098AbZBEM7d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 07:59:33 -0500
Received: by mu-out-0910.google.com with SMTP id i10so171747mue.1
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 04:59:31 -0800 (PST)
Received: by 10.103.92.8 with SMTP id u8mr195973mul.34.1233838771614; Thu, 05 
	Feb 2009 04:59:31 -0800 (PST)
In-Reply-To: <84B3CCAA-A044-4517-B2C8-14D5DD754FD2@manchester.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108555>

2009/2/5 Robert Haines <rhaines@manchester.ac.uk>:
> Hi all,
>
> I would like to use git-fmt-merge-msg to produce automatic summaries of what
> commits are being merged when I merge one branch into the other - like I see
> all the time in git.git, etc. The problem I am having is that I can only
> seem to get it to work with remote branches via .git/FETCH_HEAD - basically
> I don't know what else I can feed it to do what I want.
>
> Say I have a local repo with no remotes so no .git/FETCH_HEAD. Can I use
> git-fmt-merge-msg to produce such a summary when I'm just merging local
> branches? I've tried feeding just about everything I can find in .git/ into
> it but with no luck. Is there anything generated during the merge that can
> be used as input if I do a merge --no-commit? A list of merged commits or
> something?
>
> I'm sure I've missed something simple here...

Sure :-)

Manpage of git merge:
       --log
           In addition to branch names, populate the log message with one-line
           descriptions from the actual commits that are being merged.

Manpage of git config:
       merge.log
           Whether to include summaries of merged commits in newly created
           merge commit messages. False by default.

HTH,
Santi
