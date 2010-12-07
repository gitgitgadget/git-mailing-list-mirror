From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-rm.txt: Fix quoting
Date: Tue, 7 Dec 2010 11:19:39 -0600
Message-ID: <20101207171939.GA21105@burratino>
References: <4CFDF388.6060907@drmicha.warpmail.net>
 <73d13b752212b557c0dc157edea9a62122840e93.1291712241.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Dec 07 18:19:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ1Co-0004Xf-FQ
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 18:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781Ab0LGRTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 12:19:53 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42616 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab0LGRTw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 12:19:52 -0500
Received: by vws16 with SMTP id 16so147117vws.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 09:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=86xhmo9vQlHoLRmjFxRDS8hTr/lF8WyIMHOIDEBKSLA=;
        b=Qjbv4vRjSKTCn9/Jv4Lu80o5MkHWApnqxP+uEhesFJRtxT99KxLCtLEMOSHCDI0GO8
         wYr0hWEdXhUfMpI11ZAMQObXW2kcmeVWID+8ndpUuKzXUCx2n0ew+ogVihL7c1B1Iq7a
         9BmYzGm3D+6a7XBHTXZNAvluEBCAB6aEzo2LE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QGFndcqhvjTb2zlu2uD8rQ/PGW7R5u6geBDr47QMgBpHm84+OzrncCdHpTc7SNaZTZ
         NYijIQ8EROI+ij6wp0LHkBeWUgRLO6N30w7SLezgAoTK3Esa9zOHwlRp2McxZed1Nd1K
         u1kJyrHWWV7YewsdAalUjbs1dvkAHkmiXKe0Q=
Received: by 10.220.199.77 with SMTP id er13mr1982031vcb.47.1291742391614;
        Tue, 07 Dec 2010 09:19:51 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id j21sm842693vcr.34.2010.12.07.09.19.48
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 09:19:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <73d13b752212b557c0dc157edea9a62122840e93.1291712241.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163093>

Michael J Gruber wrote:

> --- a/Documentation/git-rm.txt
> +++ b/Documentation/git-rm.txt
> @@ -111,8 +111,8 @@ tree using this command:
>  git ls-files -z | xargs -0 rm -f
>  ----------------
>  
> -and then "untar" the new code in the working tree. Alternately
> -you could "rsync" the changes into the working tree.
> +and then `untar` the new code in the working tree. Alternately
> +you could `rsync` the changes into the working tree.

I like the patch.  Is there really an "untar" command?

Maybe something like this on top?  ('rsync' is in italics because it
is just a command name rather than a full command ready to be typed on
the command line.)
---
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index dd61ebd..0adbe8b 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -90,7 +90,7 @@ depending on the use case, there are several ways that can be
 done.
 
 Using ``git commit -a''
-~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~
 If you intend that your next commit should record all modifications
 of tracked files in the working tree and record all removals of
 files that have been removed from the working tree with `rm`
@@ -99,7 +99,7 @@ automatically notice and record all removals.  You can also have a
 similar effect without committing by using `git add -u`.
 
 Using ``git add -A''
-~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~
 When accepting a new code drop for a vendor branch, you probably
 want to record both the removal of paths and additions of new paths
 as well as modifications of existing paths.
@@ -111,8 +111,8 @@ tree using this command:
 git ls-files -z | xargs -0 rm -f
 ----------------
 
-and then `untar` the new code in the working tree. Alternately
-you could `rsync` the changes into the working tree.
+and then untar the new code in the working tree. Alternately
+you could 'rsync' the changes into the working tree.
 
 After that, the easiest way to record all removals, additions, and
 modifications in the working tree is:
