From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH] Allow local branching to set up rebase by default.
Date: Tue, 29 Apr 2008 17:56:45 -0400
Message-ID: <76718490804291456r7d1ef385q4e51a5705fdd26ef@mail.gmail.com>
References: <1209502182-39800-1-git-send-email-dustin@spy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Dustin Sallings" <dustin@spy.net>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:57:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqxpU-0000XS-D6
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 23:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbYD2V4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 17:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbYD2V4r
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 17:56:47 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:11748 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053AbYD2V4q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 17:56:46 -0400
Received: by wa-out-1112.google.com with SMTP id m16so283815waf.23
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 14:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=pmZVQaxQo1embB6YDdIm5gAoZLv8snD/BBWQi1ytECc=;
        b=C3Uyfc9/0WLoe+Meooh8EHMtNOjEZoorL546xH54zhJQZz6cElqoBO5v6K3EoPG/R/vkmrQ9pF8bPg0ZeJykq9x/JDMnEx3KD4ydLVRbN9YC5nBoJ9oajXBr3DHgkNJRO/K3KP7jVTKpwjHo1s/xHPtdEH2JRM2Qc6y/mDbiRNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Td4qfwZl/cbOOSgJVuZMrgMxQLhxR/pqjjJT4+MgcUamCq7q97QseMuD6MhRe2lWLiYJtimQ4SflVnVvoujiQrlPQ5tOnzU2ER+zyXrPiCJgKjQv7eHCLxoQHpPtu+kvqwRAFw1Qm6TNj0OYIAvLDDN+bADHCWhlrOMv58lTAPM=
Received: by 10.114.166.1 with SMTP id o1mr8586080wae.5.1209506205558;
        Tue, 29 Apr 2008 14:56:45 -0700 (PDT)
Received: by 10.114.13.5 with HTTP; Tue, 29 Apr 2008 14:56:45 -0700 (PDT)
In-Reply-To: <1209502182-39800-1-git-send-email-dustin@spy.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80752>

On Tue, Apr 29, 2008 at 4:49 PM, Dustin Sallings <dustin@spy.net> wrote:
> Change cd67e4d4 introduced a new configuration parameter that told
>  pull to automatically perform a rebase instead of a merge.  I use this
>  feature quite a bit in topic branches and would like it to be the
>  default behavior for a topic branch.
>
>  If the parameter branch.autosetuprebase applies for a branch that's
>  being created, that branch will have branch.<name>.rebase set to true.
>
>  See the documentation for how this may be applied.
>

I've had this change parked in one of my branches forever. Consider
this a UI suggestion to go with the new config option?

    [WIP] new --rebase option to set branch.*.rebase for new branches

    Add a --rebase option to git-branch and git-checkout. If given, it
    implies --track but additionally sets branch.<newbranch>.rebase to true.

    [NOTE TO SELF: this is based off the old next branch, and also it sitting on
    top of my old --track changes, so it will need to be reworked.]
