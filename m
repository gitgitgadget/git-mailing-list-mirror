From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: format-patch signoff argument no longer works
Date: Wed, 31 May 2006 06:58:08 -0700
Message-ID: <m2mzcycn4f.fsf@ziti.fhcrc.org>
References: <93c3eada0605310332p19241861g466e1516a2aaf0df@mail.gmail.com>
	<93c3eada0605310411r712dab8au9b1c7d8ecb595a66@mail.gmail.com>
	<20060531112803.GB3877@spinlock.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 31 15:58:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlRDA-0007DV-93
	for gcvg-git@gmane.org; Wed, 31 May 2006 15:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbWEaN6I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 09:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbWEaN6I
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 09:58:08 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:53240 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965024AbWEaN6H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 09:58:07 -0400
Received: by nz-out-0102.google.com with SMTP id s18so37097nze
        for <git@vger.kernel.org>; Wed, 31 May 2006 06:58:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=nuRuRsMaEppNwAVsMc6WUlZUwcC2AinA23L/gEx6B9WJAjhMkss/8+HNb4NkU4nHxxG5lonq7TBMweZD6sxR9rYKWndxmCVsaqs3ICSm5VCKjg+6jcG9Qun+N1sak2/3lX6pzCPnuGe6xu/0rwdqECugIUTodkgTsb6JwJf4RBM=
Received: by 10.36.121.6 with SMTP id t6mr116082nzc;
        Wed, 31 May 2006 06:58:06 -0700 (PDT)
Received: from ziti.fhcrc.org ( [67.171.24.140])
        by mx.gmail.com with ESMTP id e1sm114042nzd.2006.05.31.06.58.06;
        Wed, 31 May 2006 06:58:06 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <20060531112803.GB3877@spinlock.ch> (Matthias Kestenholz's message of "Wed, 31 May 2006 13:28:03 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21064>

Matthias Kestenholz <lists@spinlock.ch> writes:

> * Geoff Russell (geoffrey.russell@gmail.com) wrote:
>> It appears to have got lost when the shell script got converted to C.
>> 
> Yes, this was intentional. You should sign off your changes while
> committing (git commit -s|--signoff)

When should one commit _without_ signoff?  

The obvious answer is: when one doesn't approve of the changes in the
commit... But in my usual workflow, commit means
works-for-me-I-think-it-is-good. :-)


Also, here's a trivial patch to the git-format-patch doc.  I recently
had the same confusion trying to get git-format-patch to add signoff
for me...

Remove reference to signoff option (-s) in git-format-patch

Signed-off-by: Seth Falcon <sethfalcon@gmail.com>
---
 Documentation/git-format-patch.txt |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 7cc7faf..d13f463 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -9,7 +9,7 @@ git-format-patch - Prepare patches for e
 SYNOPSIS
 --------
 [verse]
-'git-format-patch' [-n | -k] [-o <dir> | --stdout] [--attach] [-s] [-c]
+'git-format-patch' [-n | -k] [-o <dir> | --stdout] [--attach] [-c]
                 [--diff-options] <his> [<mine>]
 
 DESCRIPTION
@@ -44,10 +44,6 @@ OPTIONS
        Do not strip/add '[PATCH]' from the first line of the
        commit log message.
 
--s|--signoff::
-       Add `Signed-off-by:` line to the commit message, using
-       the committer identity of yourself.
-
 -c|--check::
         Display suspicious lines in the patch.  The definition
         of 'suspicious lines' is currently the lines that has
-- 
1.3.3.gb931
