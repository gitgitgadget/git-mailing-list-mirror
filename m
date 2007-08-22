From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: git-svnimport: what to do after -i?
Date: Wed, 22 Aug 2007 12:58:47 -0400
Message-ID: <20070822165846.GA17815@dervierte>
References: <20070822113325.1bihryuk4gko8kgs@intranet.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jing Xue <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 18:59:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INtXn-0007HZ-EM
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 18:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762544AbXHVQ6x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 12:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761894AbXHVQ6w
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 12:58:52 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:44381 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764427AbXHVQ6v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 12:58:51 -0400
Received: by wa-out-1112.google.com with SMTP id v27so249131wah
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 09:58:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=UtOZKBzqTez2s5bL0/Pmtm1n35o9sO6Od9UAgsVdLXQW+u4pMnriGq4ApzUw/ivPIqO0ZcFYNseNFhG5XmBBt2tpW+AB2piRvselIxYT93D4XLo7nlM3gNKLufvAqqtnO6UGycxW2wRY1JPDu0+KyRkYWedDYRQGX+fWzZwDu8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=l75sY5yt4JwvGQ8L/n6TiUo+b5JaZ9zznDRsbBg23XXzFtDR4oR0hotT9D5RBcpNsCjIqfPuI/iw0JTB6zyRuzXHCVJZQwNkzo/4/aWqALiSeubuLycAKBivVWOmdiCjSAJLeSLWCrm5aTApon966eie+9nBQxZETjleuyaxyxs=
Received: by 10.115.77.1 with SMTP id e1mr27499wal.1187801930439;
        Wed, 22 Aug 2007 09:58:50 -0700 (PDT)
Received: from dasbrennen.isa-geek.org ( [76.177.36.23])
        by mx.google.com with ESMTPS id 23sm470316nzn.2007.08.22.09.58.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Aug 2007 09:58:48 -0700 (PDT)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id 09018CBDAED; Wed, 22 Aug 2007 12:58:47 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070822113325.1bihryuk4gko8kgs@intranet.digizenstudio.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56400>

On Wed, Aug 22, 2007 at 11:33:25AM -0400, Jing Xue wrote:
> 
> I am new to git. Last night I used "git svnimport -i" to import a svn  
> project. It finished successfully. The only problem now is I can't  
> seem to be able to checkout a working copy. In other words, I have a  
> 'projectFoo' directory, with only .git in it, but not any actual  
> working files. "git-branch" shows two branches, master and origin.  
> "git-checkout master" returns successfully, but does nothing.
> 
> I guess that's because I used -i without fully understanding what it  
> implies. Is there any way to checkout a working directory?
> 
> Thanks in advance for any ideas.
> -- 
> Jing Xue

See if "git reset --hard master" doesn't check out the files for you.  I
seem to recall an issue where, after an import, no files were checked
out.  reset fixed it for me.
-- 
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
   -Robert Heinlein
