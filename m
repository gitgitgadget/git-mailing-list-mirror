From: Uri Okrent <uokrent@gmail.com>
Subject: Re: Question: start mergetool with trivial differences already 
	handled?
Date: Mon, 17 May 2010 15:23:11 -0700
Message-ID: <AANLkTilLX8fWto-xL261Bkj_2fhRDqBPakP7l83QNDBj@mail.gmail.com>
References: <AANLkTinYq5LKcY8EDzfCGRoEYXftcd15Dviww749uBUC@mail.gmail.com>
	 <AANLkTiliNtjh6FsGW_S2BRN_C_WjDzdlMxMg90Kekb5G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: The Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 18 00:23:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE8iW-0005uE-6D
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 00:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755831Ab0EQWXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 18:23:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33815 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067Ab0EQWXM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 18:23:12 -0400
Received: by iwn6 with SMTP id 6so809236iwn.19
        for <git@vger.kernel.org>; Mon, 17 May 2010 15:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=UNpMOxztKRHaBonqM2uwWKjQfYxfr+K6xj/8LfYUXh0=;
        b=EXMxQWKW826PgwYCboe+DR8KkGQc8eqfQ7BpSJ2CN++pKMROqhYeWtQCUgEcWwgex9
         zno6yHvgv2K9QHxFfiXJT3K9q/do4lK4Mw/v88n/SKYu1ISSp5qsBt87joUYFgqndj5+
         0Opd6L5B8sF9mMECr2E6tkUCZWtP2CYu3W4XM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=pcfpRA7AU+F1rezU2tvvRxtfeAvI+wII6Fmf4pYy12/+fOdTq9Jj3TquR4hOBM/j9g
         p4ZXs4E8jpZDeF1M8LY2iFyI/5AFx2/PFxgylrT05S0HYq+puXKM+1XibcwdJ2TAXHQQ
         LcPY0FjfxgUUxt5kyTZ2+P48l/bg9mdUxE2os=
Received: by 10.231.186.161 with SMTP id cs33mr731370ibb.65.1274134991816; 
	Mon, 17 May 2010 15:23:11 -0700 (PDT)
Received: by 10.231.200.198 with HTTP; Mon, 17 May 2010 15:23:11 -0700 (PDT)
In-Reply-To: <AANLkTiliNtjh6FsGW_S2BRN_C_WjDzdlMxMg90Kekb5G@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147262>

On Mon, May 17, 2010 at 3:07 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> This doesn't really have anything to do with git at this point. It's
> up to whatever tool mergetool invokes to perform the 3-way diff
> itself.


But doesn't the git-mergetool command inform the requested merge tool
what it should be displaying?


> That tool should then only ask you to resolve the conflicting
> regions, and all other differences should be auto resolved.


I haven't found this to be the case.  Is there a merge tool that can
do this?  I had assumed that git used some magic using the project's
history in order to resolve conflicts in a smart way.  Will a merge tool
that only has $THEIRS, $OURS, and $BASE have enough information to
resolve conflicts as smart as git itself does when it produces the
unmerged file in your working tree?

If it isn't possible for a merge tool to do that, I guess the behavior
I'm looking for would be for git to somehow inform the merge tool of how
the trivial merges should be resolved, i.e., that it should tell the
merge tool to "use the 'unmerged' path from working tree" that git merge
(or git rebase) created.


> Most of the tools that mergetool supports out-of-the-box perform 3-way
> diffs, so I guess I'm curious what merge tool you're using.


I use xxdiff or diffuse (or more frequently, vim ;))

-- 
   Uri

Please consider the environment before printing this message.
http://www.panda.org/how_you_can_help/
