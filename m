From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFH] Questions for Git User's Survey 2009
Date: Thu, 11 Jun 2009 11:43:14 +0200
Message-ID: <200906111143.15980.jnareb@gmail.com>
References: <200905291855.03328.jnareb@gmail.com> <200906102042.15119.jnareb@gmail.com> <20090611085744.GA36556@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 11:43:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEgop-0002RV-FS
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 11:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760521AbZFKJnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 05:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760643AbZFKJnV
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 05:43:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:13178 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761714AbZFKJnT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 05:43:19 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1451311fga.17
        for <git@vger.kernel.org>; Thu, 11 Jun 2009 02:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ZSEoc06Y7TuHYb8+Y/bovE+xflP8nrIGhYaAITRYOwU=;
        b=RUt+mcOqlGRRx54lI87pqRmsRFj0ypH+JprotvZ6D96Xrhqe+xNw5tCWqVPZKmUOs3
         fLdtxWxSVGwbpAaWXKaDl/LCGfptETUb70WIQzHBbEPm7E6IVgZS0kYYl2p4hU71WlPp
         M0QkhLRV1BXqMzT32O5KN62hPEFPp01e+D15A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=YNN+k3/8binurpwGK0xjtCU1iYTZWuDlsNNGjQuqD7/q8y6/uBfNl5wyfaLBnqRRUy
         8HzJRrjVBM97o14FYnsHHk1S6RT92lwU8fic5IQuwiLiC/Ixu8ZcQb08DSOdrTG+U9CI
         hlQqutssHBwtvljKB9v17uUEeR8ASIGc3oz3M=
Received: by 10.86.35.8 with SMTP id i8mr2051420fgi.42.1244713400510;
        Thu, 11 Jun 2009 02:43:20 -0700 (PDT)
Received: from ?192.168.1.13? (abwl198.neoplus.adsl.tpnet.pl [83.8.235.198])
        by mx.google.com with ESMTPS id l19sm1600641fgb.22.2009.06.11.02.43.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Jun 2009 02:43:19 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090611085744.GA36556@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121332>

On Thu, 11 June 2009, David Aguilar wrote:
> On Wed, Jun 10, 2009 at 08:42:13PM +0200, Jakub Narebski wrote:
> > 
> > 11.*Which porcelains / interfaces / implementations do you use?
> >     (multiple choice: git (core), JGit, Cogito, pg, StGIT, Guilt,
> >     Easy Git, Pyrite, TopGit, other - please specify)
> > 12. Which of the following git tools do you use?
> >     (multiple choice: JGit (EGit etc.), Cogito, pg, StGIT, Guilt,
> >     TopGit, Easy Git, editor/IDE VC integration, gitk, git-gui,
> >     QGit, GitView, Giggle, tig, git-sh, instaweb, git-cola / ugit,
> >     GitNub, GitX, GitTortoise, Git Extensions, git-cheetah, Gitosis,
> >     graphical diff tool, graphical merge tool, other - please specify)
> 
> Can you not mention ugit?
> Less is more.  I really hope it has 0 users.
> 
> As you're well aware, git-cola is how most people know it.
> 
> My reason for wanting to strike it from the record is to make
> things simpler for users.  If someone went looking for ugit these
> days they'd be redirected to git-cola.

O.K.

I wonder if I should do the same for Guilt (formerly gq = Git Queues)...

> I have a similar feeling about cogito, but I didn't write it.
> Since cogito is dead, it's best to let it rest, otherwise new
> users waste time wondering what it is, no?
> 
> It's kinda like rewriting history... ;-)

The goal of including Cogito and pg (Patchy Git), of course with strong
warning about it being DEPRECATED, was to check if many people use it,
even when they should not (because it is unmaintained).

Cogito had 14 replies, and pg 2 replies last survey (for 2681 responders).

Put perhaps it is time to lay this answer to rest...

> 
> 
> Thanks for the survey.
> I'll be forwarding to all my co-workers.

It would be a bit before starting survey.  Most work would be announcing
the survey, I think.  Any ideas for channels I forgot last year?

> 
> > 16. Which of the following features do (or did) you use?
> >     (multiple choice: non-default hooks, working with dirty tree,
> 
> fwiw, the number one thing cvs users ask me for is the
> ugly+dirty cvs update-before-commit/merge workflow...

Well, perhaps I should add "What features would you like to see in Git?"
free-form question.  Mind you, I don't guarantee that it would be ever
analyzed... :-)

-- 
Jakub Narebski
Poland
