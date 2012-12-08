From: "Matthew Ciancio" <matthew.ciancio16@gmail.com>
Subject: Feature Request - Hide ignored files before checkout
Date: Sat, 8 Dec 2012 11:50:04 +1100
Message-ID: <000301cdd4dd$f8554090$e8ffc1b0$@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 01:50:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th8cr-00081r-46
	for gcvg-git-2@plane.gmane.org; Sat, 08 Dec 2012 01:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249Ab2LHAuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 19:50:17 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52476 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab2LHAuO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 19:50:14 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so710010pbc.19
        for <git@vger.kernel.org>; Fri, 07 Dec 2012 16:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding:x-mailer:thread-index:content-language;
        bh=6bTLPuq1lkx8q4uTyOowriIR7WRbjHK/BnOdiYd3++0=;
        b=Ho/jaUdNZW7TO4tcLZTvF7B3zb4/uFJn0JPUkwmoSti7vcoBJZ0EczRyLUc4s++YEV
         J7TKXZngy12hWimg0R4IPrUNiB0PJtx5A65Vw+wVVoyWtk7Bw/sTlmUOjsveqOyFcNTj
         D+S36dOqINThktIN1ALqIYNQ721u8nc83hMV4P9cHKRyny3NSTQ+VHSsP48fg0eENZTI
         bXMwerWgeW889CxspFWXKV02Uhcez5R10k3lAGoP8OSK1XsXh4zVEyw4K3RquvxbD+M3
         kTYvkRrT2TQGMz/ij/6fZmmEEk9atqknw1BYTCCRQeBCzIP/2H57+xZ/uUvaT+BIYANt
         TOQg==
Received: by 10.69.0.10 with SMTP id au10mr20585285pbd.18.1354927813799;
        Fri, 07 Dec 2012 16:50:13 -0800 (PST)
Received: from MattPC (CPE-60-225-40-254.nsw.bigpond.net.au. [60.225.40.254])
        by mx.google.com with ESMTPS id d2sm7433838paw.19.2012.12.07.16.50.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Dec 2012 16:50:12 -0800 (PST)
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac3U1ak7TLTEIWL+TJe7FSAPCivfIQ==
Content-Language: en-au
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211207>

To whom it may concern,

I am not sure if this is the right place to send this, but I couldn't find
anything on the web that seemed official, so here goes.

Imagine this scenario:

1) You have a Git repo with two branches (branchA and branchB), which are
currently identical.
2) Checkout to branch.
3) Create file foo.txt, stage it and commit it.
4) Create file ignore.txt and add it to the ".gitignore" file of branchB so
that it is successfully ignored by Git.
5) Checkout to branchA.

Problem: ignore.txt does not "disappear" like foo.txt does and is now just
sitting in branchA (and now any other branch I checkout into).

When I first started using Git, I genuinely thought this was a bug, because
it seems so logical to me that ignore files should hide/reappear just like
tracked files do, when switching branches.
I have been told ways of circumventing this (using commits and un-commits OR
using stash), but my reason for avoiding commits is: say you have binary/OS
specific files which really do not belong in the commit logs (even locally)
and hence should be ignored. What if you want those files in only one branch
and not all?
Stashing doesn't seem appropriate either, because it would get messy.

Do you think this warrants a feature request?

If so, I was thinking that maybe the .gitignore file could have a flag after
each entry, to indicate whether the file(s)/folder(s) should have this new
feature or not (that way it would cater for everyone, but I can't see why
you wouldn't want this behaviour). 

If you like this idea and submit this as a feature request, please respond
with a link of the official request so that I can follow it, or provide me
with a link to submit it myself.

P.S. Here is a forum post I made on StackOverflow about the issue:
http://stackoverflow.com/questions/13761682/gitignore-hide-ignored-files-dur
ing-checkout

Kind regards,
Matt
