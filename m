From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn clone just stops
Date: Sun, 20 Dec 2009 08:57:31 +0000
Message-ID: <20091220085731.GA11535@dcvr.yhbt.net>
References: <1260915555.6475.8.camel@mark.engr.acx> <20091216081514.GB26038@dcvr.yhbt.net> <4B2B990B.9060502@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Jerkovic <mjerkovic@aconex.com>, git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Sun Dec 20 10:00:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMHe8-0003BJ-Ui
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 10:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbZLTI5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2009 03:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbZLTI5d
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Dec 2009 03:57:33 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:51978 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801AbZLTI5c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2009 03:57:32 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 768E21F516;
	Sun, 20 Dec 2009 08:57:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4B2B990B.9060502@obry.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135527>

Pascal Obry <pascal@obry.net> wrote:
> Eric,
> 
> > Not without error messages of some sort.  git svn was designed with poor
> > network conditions in mind and clone is resumable, so you can just
> > resume like this:
> > 
> >    cd project.git && git svn fetch
> 
> What about --revision option. I mean if I have this clone interrupted:
> 
>    $ git svn clone --revision=345:HEAD svn+ssh://...
> 
> Should I specify --revision when restarting with fetch? I think I had an
> issue with this...
> 
> Maybe some other options are also to be passed to fetch?

Hi Pascal,

--revision may be passed to fetch, but its optional.  fetch should
always know where to pickup after it left off.

"git svn $command -h" shows you all options a particular $command
allows.

-- 
Eric Wong
