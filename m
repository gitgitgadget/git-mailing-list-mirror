From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [RFC] Use cases for 'git statistics'
Date: Mon, 12 May 2008 13:49:18 +0200
Message-ID: <bd6139dc0805120449j874e4b8j21b90f79230e45a7@mail.gmail.com>
References: <bd6139dc0805080851y2065bedfsf0f388cfd6d85929@mail.gmail.com>
	 <m3d4nr4ykr.fsf@localhost.localdomain>
	 <bd6139dc0805120319s5ad37867k392eff88616b689e@mail.gmail.com>
	 <200805121319.37512.jnareb@gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"David Symonds" <dsymonds@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 13:50:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvWXk-0007Sw-PN
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 13:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535AbYELLtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 07:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752223AbYELLtX
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 07:49:23 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:29713 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbYELLtW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 07:49:22 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2275734wfd.4
        for <git@vger.kernel.org>; Mon, 12 May 2008 04:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=NcW5VNQ8v27iPb9GG88abr8qVK+rUujj5cTZqiKf4Gc=;
        b=V6pxPnoyYGQ7QMGXHxbGyci7WiJpICBPKp18XR52+nO/nwMvqDAdrC1XQPbtmQ4ggSWPNVv9bLIeSRqyWcZc/lEsgHqgc5Jk2SQR0tx/V4xa6nmKFavlv6KJZTIg5ZpSdXAIzkVqy25w720kZcziS9BLTyZKUXugcP8gu+fsGkA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sG2PgOQ0EZskIHcjUefWkqPdDqTgJLVo1Y13b/aYfOKsYUD1eJR9RxPLI+XWmaEbBmmh8YVA3426739lRemhaAGAlMZR8Q3FWcweCFgj2f5niP7nscsbhZHWyzb/opC35Zwp0Mo3ORIhcFjJ8YWymMrJPKTqOUqQwlEihQM8xEU=
Received: by 10.142.211.10 with SMTP id j10mr3229370wfg.168.1210592958163;
        Mon, 12 May 2008 04:49:18 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Mon, 12 May 2008 04:49:18 -0700 (PDT)
In-Reply-To: <200805121319.37512.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81854>

On Mon, May 12, 2008 at 1:19 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>  One note: why not provide HTML version in addition to PDF?

HTML version is now available too: http://alturin.googlepages.com/Use_cases.html

>  This is "Finding the owner of the code" (i.e. something like
>  non-existent 'git blame --summary') with the goal of "Find who
>  needs to be contact about changing (or adding) license / relicensing".

Ah, it is a simple aggregation of 'git blame' then, you are right,
that is not the same as what I had in mind for the mentioned use case.

>  This is similar, but not exactly the same as "Find maintainer of given
>  subsystem", or "Who is responsible for this part of code".

Agreed, since those should look back in history too.

>  * Maintainer: how close should I examine provided patch?

I'm not sure I understand what you mean with this, perhaps related to
"Name: Finding parts of the content in which a lot of bugs are
introduced and fixed" (e.g., patches to bug prone areas should be
examined more closely).

>  * Contributor: who is maintainer of the code / whom should I contact
>   and send copy of a patch?

I think this -is- the "Finding a Contributor that is active in a
specific bit of content" use case this time.

>  * Bug-fixer: who is responsible about this part of code? Who might have
>   introduced the bug?

How would you define 'responsible'? "Having a lot of signed-off-by
lines in that part of the content" would seem like a candidate, but
the "activity" use case seems applicable again here.

>  * Contributor: what happened with my code?

Do you mean a "track my code" like feature? Showing the movement of a
particular piece of code through the code? (Displaying information
like "moved from foo.c to bar.c in commit 0123456789abcd"?)

>  * Searching where to contribute: what are oldest part of code dealing
>   with error messages (find ancient code)?

In other words, find the lines with the oldest modification time stamp
from 'git blame'?

-- 
Cheers,

Sverre Rabbelier
