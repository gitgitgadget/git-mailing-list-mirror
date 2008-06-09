From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [StGIT PATCH 3/5] Create a git.Branch class as ancestor of stack.Stack
Date: Mon, 9 Jun 2008 02:46:18 +0200
Message-ID: <bd6139dc0806081746q3b71dd3cp5dfef55184508930@mail.gmail.com>
References: <20080604210655.32531.82580.stgit@localhost.localdomain>
	 <20080604211334.32531.74258.stgit@localhost.localdomain>
	 <20080605070126.GC23209@diana.vm.bytemark.co.uk>
	 <b0943d9e0806050503x40191104ye332d6a8435811a5@mail.gmail.com>
	 <20080605130415.GB28995@diana.vm.bytemark.co.uk>
	 <b0943d9e0806060144x48176566m277ba2969087b91e@mail.gmail.com>
	 <20080607090636.GB32647@diana.vm.bytemark.co.uk>
	 <b0943d9e0806081516y575faba9g8b5a27646615f72f@mail.gmail.com>
	 <402731c90806081707m384edef4p4c2328ac1ee1ea08@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Catalin Marinas" <catalin.marinas@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	git-python@googlegroups.com
To: "David Aguilar" <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 02:47:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5VXU-0004db-VZ
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 02:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbYFIAqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 20:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752626AbYFIAqT
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 20:46:19 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:31956 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbYFIAqS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 20:46:18 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1869583wfd.4
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 17:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=bgmfMlgtEQi7cY6Z1gX08Jxu3+hOh1wr5sPwPxwTfI0=;
        b=jNHGKhgXgp/wRhowEFCu7aABI2jpPQxt9C25NORQe86USk9aLPmhPXsxJUC/p8W9V4
         yo9xGNoXEv8L+Bd4Rv5fBR4iR6dXIdUn0vNbcLrghEgEfworjwSTKyaPJSXgonj2JuAH
         rwTNfwLR+1CBLjDUlm/Y2Su0TPSsFcuQoeQ4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=Z7d1VkZS26kAWxmnfW2e1RmjXK1721xg6isSf06hqd0B0Qh/GTr23abWjRDXtnSbna
         yJgtEwo6kDwFUS7p3eFe0zHWIzizM0to3983jwqUjJH7dNRMS7mW4xbGsYGbinxj5ifF
         eMJelCsy3TlZYYn06M5nIlDwN++3TyvPCUYAo=
Received: by 10.142.253.21 with SMTP id a21mr1157572wfi.254.1212972378087;
        Sun, 08 Jun 2008 17:46:18 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Sun, 8 Jun 2008 17:46:18 -0700 (PDT)
In-Reply-To: <402731c90806081707m384edef4p4c2328ac1ee1ea08@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84353>

On Mon, Jun 9, 2008 at 2:07 AM, David Aguilar <davvid@gmail.com> wrote:
> A few folks are working towards an OO git interface for python.
> Perhaps joining forces would be a big win for everyone?
>
> http://gitorious.org/projects/git-python
>
> It would be really cool if we could wrangle in all interested parties
> towards a common goal for python.  You guys (the stgit team) have a
> lot of experience in this domain so your ideas and opinions would be
> greatly appreciated.

I very much agree with you. I'm using git-python for my GSoC project
myself (although currently I'm only using the Git object really). I
think it would be awesome if git-python and stgit.lib.git would merge.
I'd be happy to help with that in any way I can :).

-- 
Cheers,

Sverre Rabbelier
