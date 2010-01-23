From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/7] Documentation: merge: move merge strategy list to end
Date: Sat, 23 Jan 2010 03:33:37 -0600
Message-ID: <20100123093337.GD7571@progeny.tock>
References: <20100123092551.GA7571@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 10:33:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYcNB-0006rX-Lz
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 10:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499Ab0AWJdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 04:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742Ab0AWJdh
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 04:33:37 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:60341 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab0AWJdh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 04:33:37 -0500
Received: by iwn16 with SMTP id 16so817439iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 01:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=IEiN2QYiQPFhHI1k0rrabnJ+2vjDbn8snoAFuMfEi9o=;
        b=Afm6u+AR3oVVBGNbsX6+aHTt9qJSX9jX3IOJLQSaHwWv82ObWjABy55Wo/Un7uk0NR
         TRYotmL82wpK+9GO0g1G/1wDVB6ImIg02G6WaJiQ54tYO9rcmO9T5cS23ZKwtoG+WKpU
         LB0MPPQmkrJoItL7svdt3gZCkYVLOwZmaG6D8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=i6D3cqnipUWprQyF3Vj1mRxOpElGNTdioUcdmLtot2nvDwTi/q0y0tl4fgWZXL407b
         mFo8lgNKu3LoM1LAInOqh2DvC3xpi0+GCs1jOxBefMtQl3rHLtHvdaFAIdrY39AvkucE
         2jQ0gP2WfZY7q4ql4X0oPvFy4ul1ZGIQT18SE=
Received: by 10.231.149.12 with SMTP id r12mr457868ibv.86.1264239216516;
        Sat, 23 Jan 2010 01:33:36 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm2569235iwn.11.2010.01.23.01.33.35
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 01:33:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100123092551.GA7571@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137821>

So the section layout changes as follows:

 NAME
 SYNOPSIS
 DESCRIPTION
 OPTIONS
-MERGE STRATEGIES
 HOW MERGE WORKS
 HOW CONFLICTS ARE PRESENTED
 HOW TO RESOLVE CONFLICTS
 EXAMPLES
+MERGE STRATEGIES
 CONFIGURATION
 SEE ALSO
 AUTHOR
 DOCUMENTATION
 GIT
 NOTES

The first-time user will care more about conflicts than about
strategies other than 'recursive'.

One of the examples uses -s ours, but I do not think this hinders
readability.

Suggested-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thomas Rast wrote [1]:

> While I agree with the general intent of deferring the strategies
> further back, wouldn't it be better go all the way and instead put
> them before (or even after, but one of them uses -s ours) "EXAMPLES"?
> The average user will care more about conflicts than about strategies
> other than 'recursive'.

Good idea.  Thanks!

[1] http://thread.gmane.org/gmane.comp.version-control.git/136356/focus=136679

 Documentation/git-merge.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 1fecedb..83bf3e7 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -42,8 +42,6 @@ include::merge-options.txt[]
 	You need at least one <commit>.  Specifying more than one
 	<commit> obviously means you are trying an Octopus.
 
-include::merge-strategies.txt[]
-
 
 HOW MERGE WORKS
 ---------------
@@ -240,6 +238,8 @@ changes into a merge commit.  Small fixups like bumping
 release/version name would be acceptable.
 
 
+include::merge-strategies.txt[]
+
 CONFIGURATION
 -------------
 include::merge-config.txt[]
-- 
1.6.6
