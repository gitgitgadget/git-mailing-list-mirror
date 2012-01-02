From: Chris Leong <walkraft@gmail.com>
Subject: Git ghost references
Date: Tue, 3 Jan 2012 10:42:04 +1100
Message-ID: <CAJ6vYjfpx-hfDsd+urp5_iS99p0RhmxohOc+TNv7SUWFnYe5wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 03 00:42:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RhrWi-0008St-Vd
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 00:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418Ab2ABXm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jan 2012 18:42:28 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62374 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab2ABXm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jan 2012 18:42:27 -0500
Received: by eaad14 with SMTP id d14so8283578eaa.19
        for <git@vger.kernel.org>; Mon, 02 Jan 2012 15:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=biASJCzyqcRQUHivtgLtIdkL0O00lsYBvSlg/vYQTeA=;
        b=SRPtRY0SLLb+UTiNpQ7BQ9wGd5BQVMg61mYeK2QXgTyaV8nIz6QmhcjzCMCMUUuSyO
         aUm0hbtLK8IlUHDt6zvwA23TpJRNdWuq5KQFsia8s+87HHNoKK33zKZystZg9XXm9k7x
         Wrl3Ez/z2p162HjaINZnPWhI3PNBAmcKMbM30=
Received: by 10.204.32.146 with SMTP id c18mr9005245bkd.132.1325547745293;
 Mon, 02 Jan 2012 15:42:25 -0800 (PST)
Received: by 10.205.139.5 with HTTP; Mon, 2 Jan 2012 15:42:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187851>

I seem to have a "ghost reference" - ie. I can check out a reference
that doesn't appear to exist. Does anyone know what might cause this?

~/gaf-cvs (project-membership)$ g show-ref | grep production
~/gaf-cvs (project-membership)$ g gc --prune=now
Counting objects: 117306, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (25270/25270), done.
Writing objects: 100% (117306/117306), done.
Total 117306 (delta 83839), reused 117283 (delta 83820)
~/gaf-cvs (project-membership)$ g co production
Note: checking out 'production'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b new_branch_name

HEAD is now at ae5b621... Merge branch 'master' of git.freelancer.com:production
~/gaf-cvs ((no branch))$
