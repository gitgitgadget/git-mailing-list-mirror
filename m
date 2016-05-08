From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [GSOC update] Week 1
Date: Sun,  8 May 2016 16:57:02 +0530
Message-ID: <1462706822-5189-1-git-send-email-pranit.bauva@gmail.com>
References: <CAFZEwPMr=imv==kvVULy4PDYKW-0RRQ5a+X8DFqNFhNjCSyWKA@mail.gmail.com>
Cc: christian.couder@gmail.com, chriscool@gmail.com,
	larsxschneider@gmail.com, Pranit Bauva <pranit.bauva@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 13:28:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azMsY-0007G5-8x
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 13:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbcEHL1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 07:27:45 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34412 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbcEHL1o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 07:27:44 -0400
Received: by mail-pa0-f68.google.com with SMTP id yl2so13803057pac.1
        for <git@vger.kernel.org>; Sun, 08 May 2016 04:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ULBxdeB8hNJ+KbMSDyipgmG+7Rcj2brK+DG52DbRoPQ=;
        b=nmB77H9cs+uySAj+BfqxmVdx/OFMr7FJAzi+VS/W8+Cdl3bJTezotsJXoSM/pH9UOJ
         D2/Mt8akCFDNlk5PgtPphGUDNwlJmoxd+bDPC7s/+7+WGsiSr0VQZwYfAvSSlXyXaBWr
         EzTD4i2BJgrJBx4Lg4eROAj9x8HvjqjZf436wDVlbvr0yJMplbdrOyY0EXz3v9Bm7p+U
         8ukng1lUglm2X2Cqm3KuSAT412Nw22D2NOzHDwvmYnijGqLAPVETpyN2svA5MmztSHOC
         /hCD9SmPgAUKO0i0UTAB5aKPYU0R7BPRyXUtWSr0lxqv9xDhWWe97wvG9vt8yNR/imfr
         2Vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ULBxdeB8hNJ+KbMSDyipgmG+7Rcj2brK+DG52DbRoPQ=;
        b=BCofH1/wsFLacM1jXE7hPpBK+P0qVwojaAK5DCOiz2CI76RcuqYZgGBBKj07RlVfun
         zdvLNS0ACyeau6IS/kyZ9KXJjyXWFlAurcdhzLCxCS8+6qxPFcXCWk3Uws6gwmnN2knK
         AbFGL0AOm/Yh8rg/NSMQOt0WOLDR8v28mHzEmNap6O0hKAI3EjS5LETX42BnH4UJApHQ
         jyRyvVpO/ZqrjfQjDbJl6tGh8de40+0NTj4k+8k6anz0u97Vpr9STKq8gV2aMkuAliqA
         HSUu6+AOzjhAmYRBv9l4mDcBu8LgVxowOgPR6iVi8xpV2N1H0gn52j0BV0JMpkiPmRoD
         z0bA==
X-Gm-Message-State: AOPr4FV83ey8laKJvtCpB6rYNZrIYL/Lw/pv8EK37UJdnUVZxCqxHDNn93zMivHW0ZRsBw==
X-Received: by 10.66.81.70 with SMTP id y6mr42400506pax.121.1462706863858;
        Sun, 08 May 2016 04:27:43 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id o2sm33155497pfi.85.2016.05.08.04.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 May 2016 04:27:43 -0700 (PDT)
X-Mailer: git-send-email 2.8.1
In-Reply-To: <CAFZEwPMr=imv==kvVULy4PDYKW-0RRQ5a+X8DFqNFhNjCSyWKA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293965>

My public git.git is available here[1]. I regularly keep pushing my work so
anyone interested can track me there. Feel free to participate in the
discussions going on PRs with my mentors. Your comments are valuable.

The things I was able to do:

 * Finish off with my micro project[2] about adding a config variable for
   git-commit. There is still a little discussion going on about whether
   verbose should be retired and instead "commit.showDiff" should be used.
   Junio also made a little change to squash it with my patch to make the
   patch look more clearer to digest. Its difficult that this will be included
   in the release of 2.8.3

 * I converted the function check_term_format()[3] from shell to C as a
   subcommand. Faced some difficulty but was greatly helped by Christian
   Couder.

 * I converted the function bisect_log()[4] in a branch from the previous
   check-term-format branch as a subcommand. I was waiting for the first patch
   to get queued on maintainer's git.git repo so as to rebase it there and
   then send the patch.

 * I converted the function write_terms()[5] in a branch from the previous
   bisect-log branch as a subcommand and I removed check-term-format subcommand.
   I was waiting for the bisect-log patch to get queued on maintainer's git.git
   repo so as to rebase it there and send send the patch

 * I am currently introducing subcommands and calling them from git-bisect.sh .
   Eric Sunshine had proposed another top bottom approach wherein I first
   implement a skeleton and redirect it to git-bisect.sh so that the test
   suite is still passing. This method was used by Paul Tan in his last year
   GSoC project. Commit ids for reference, e1ea69fa4e and 73c2779f4 .

 * I ignored it and sent another revision of the series to which Junio wasn't
   quite enthusiastic over my reasoning for using subcommand approach. So
   I wrote an email[6] explaining how using subcommand way is beneficial to
   me, reviewers/testers, and my mentors.

 * I am currently waiting for that discussion to come to a conclusion. Till
   then I have paused on a bit.

 * I am now reading on the API part and planning how will I go about with the
   future functions. The functions I have converted till now were quite simple
   ones and the main difficulty lies ahead!

 * Anywhich ways I think this week was quite productive and if I follow this
   speed then the project is in a good shape to be completed well in time.

 * On a lighter note: I will be on a short vacation from 16th May to 19th May.
   So I will be unavailable till that time.

[1]: https://github.com/pranitbauva1997/git
[2]: http://thread.gmane.org/gmane.comp.version-control.git/293635
[3]: https://github.com/pranitbauva1997/git/pull/1
[4]: https://github.com/pranitbauva1997/git/pull/2
[5]: https://github.com/pranitbauva1997/git/pull/3
[6]: http://article.gmane.org/gmane.comp.version-control.git/293909
