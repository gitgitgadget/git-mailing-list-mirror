From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Development strategy
Date: Mon, 2 Jun 2008 20:30:24 +0200
Message-ID: <bd6139dc0806021130p2cc442a3qfe9c00681fdb05e3@mail.gmail.com>
References: <48441715.4010507@gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"John Hawley" <warthog19@eaglescrag.net>
To: "Lea Wiemann" <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 20:31:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3EoR-0006Ii-Mz
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 20:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702AbYFBSa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 14:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752084AbYFBSa2
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 14:30:28 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:17074 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754535AbYFBSaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 14:30:25 -0400
Received: by wf-out-1314.google.com with SMTP id 27so936202wfd.4
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 11:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=R8oUtsYjQOrITWt5Grga/YxpsA7/DGipprlf/bDoN3o=;
        b=Gx0FvGek9qGeStftcxscQq4N1t8jX5wihHp3OnSyez+1p/Igs7M4Ge6ItHvKZ1c6kbIfasdy2inuOwDx6QSmdicvfMtU6wBnhxWWx20ZkC+QPWFFlzPud20DFEvvZG3Zsau5ITEDrVWaWgtxOFl22RIR1OaIrmurDfpJ1T+Nm/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FFIIMLc2ljVjpbeQPxx2YMS0UF29/p8jJXpF2j05KuBusFqleXjIhrG+gxWnKV9Nb1ne3kqRLSXdo01r3LgTKsKVUr6Yy4eAu3DmAHRDuGFHGv9SCSVGJgVGhlSmeXLWD+FKa6MHZiIGjz75ISLL0/XBPdXVRWFor6MmSwxQ6NQ=
Received: by 10.142.172.12 with SMTP id u12mr1728699wfe.95.1212431424546;
        Mon, 02 Jun 2008 11:30:24 -0700 (PDT)
Received: by 10.143.41.7 with HTTP; Mon, 2 Jun 2008 11:30:24 -0700 (PDT)
In-Reply-To: <48441715.4010507@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83553>

On Mon, Jun 2, 2008 at 5:51 PM, Lea Wiemann <lewiemann@gmail.com> wrote:
> 2) I should probably also try to squash patches into larger ones.  This will
> make it easier to make changes in older commits, since I don't have to edit
> several commits, and it reduces the probability of merge conflicts.  I'm not
> sure how much squashing is appropriate though: For example, would it be okay
> to squash a fix like "Git.pm: fix documentation of hash_object" into a
> larger "Git.pm: add and fix several methods" commit, where I only mention
> the documentation-fix in the log message?  It would certainly be helpful in
> that it reduces the number of conflicts, but it will make the logs coarser.

Why not go for the win and do both? Keep your commit strategy as is,
and create a branch whenever you want review, say review-02-06 or such
and in that branch you squash the commits as appropriate (perhaps
StGit can help here). These patches are mostly not intended for
inclusion just yet (but for review only), right? Instead of sending
all the small commits you send a bigger one, perhaps with a link to
where the branch can be found for easy checkout. You can keep the
branch for the a record or delete it after the review and go on with
the next branch.

Cheers,

Sverre, who thinks a few RFC patches are in place soon for git-stats
too and is glad you are doing the fine-tuning wrt patch submission.
