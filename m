From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: git file sharing/versioning.
Date: Tue, 5 Jan 2010 21:10:38 +0100
Message-ID: <20100105201038.GA12942@vidovic>
References: <1262579824.9041.15.camel@ams.xobas.net> <1262580346.9041.20.camel@ams.xobas.net> <1262580426.9041.21.camel@ams.xobas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Bas Driessen <bas.driessen@xobas.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 21:12:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSFl4-0001Qd-Di
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 21:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755705Ab0AEUK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 15:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755696Ab0AEUKq
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 15:10:46 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:34485 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755692Ab0AEUKo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 15:10:44 -0500
Received: by ewy19 with SMTP id 19so8850673ewy.21
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 12:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=etoRxDdpa7bTGcwNB28h6DxnvhISx0pWpevk70/X1qo=;
        b=IL7Mf4PrGZagbpM8LoWVl5Cw44WEOicxexVY2w7k+AylbMoOFA1EmtDxicS+lWLOOB
         t2dQnqL5Y9X4onT91Skjbm4gcDO6yXr7DeuhsC5e8qSp6RJsgNyqyPQfPazumFZBETGU
         RLc8pri3j3l8y6B0ydq+D/v09vvLnorafyesc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GE8duE96GyntdsR7sOAPQOqRf/h9SKBV8Tfm9IrndkAK7gp4YorFr6OdvcH5Sp4OjV
         tNkHcNjpwyrfAhKNUuYvx+ZVDGKkc4NNv7HpxrCJjYaXo8KKv6AJHKzz5XLB/cb0AOzV
         i+PKlWeWcz2n9RcYzV++fZH49lm2oQv7NHv4c=
Received: by 10.213.107.65 with SMTP id a1mr378046ebp.85.1262722242238;
        Tue, 05 Jan 2010 12:10:42 -0800 (PST)
Received: from @ (88-122-113-243.rev.libertysurf.net [88.122.113.243])
        by mx.google.com with ESMTPS id 16sm13517506ewy.10.2010.01.05.12.10.40
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 05 Jan 2010 12:10:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1262580426.9041.21.camel@ams.xobas.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136206>

The 04/01/10, Bas Driessen wrote:

> I have a project where I have 2 trees with several hundreds of files.
> Let's call them tree1 and tree2. Only a handful of files in tree2 are
> different. What is the best way to set this up in GIT? Basically most
> files in tree2 should act as a symbolic link to tree1. So if the file
> changes in tree 1, it automatically changes in tree 2. Obviously, I
> don't want to store everything double. Branching does not appear to be
> an option as changes in tree1 would not be visible in the tree2 branch. 

Look at:

  git merge --help
  git rebase --help
  git cherry-pick --help

-- 
Nicolas Sebrecht
