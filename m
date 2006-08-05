From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] git-status: colorize status output
Date: Sat, 5 Aug 2006 01:16:21 -0700
Message-ID: <20060805081621.GA2683@kroah.com>
References: <20060805031418.GA11102@coredump.intra.peff.net> <20060805032135.GA11244@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 10:17:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9HLC-0003Ps-KL
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 10:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422739AbWHEIQn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 04:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422757AbWHEIQn
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 04:16:43 -0400
Received: from ns.suse.de ([195.135.220.2]:56296 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422739AbWHEIQn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 04:16:43 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id AB98610102;
	Sat,  5 Aug 2006 10:16:41 +0200 (CEST)
To: Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <20060805032135.GA11244@coredump.intra.peff.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24892>

On Fri, Aug 04, 2006 at 11:21:35PM -0400, Jeff King wrote:
> On Fri, Aug 04, 2006 at 11:14:19PM -0400, Jeff King wrote:
> 
> > The idea is that red things indicate a potential mistake on the part of the
> > user (e.g., forgetting to update a file, forgetting to git-add a file).
> 
> I actually wanted to do this because I started syntax-highlighting the
> git-commit message in vim. I found myself catching simple mistakes in
> commits, like the ones I mentioned above, before committing, saving me
> from doing an --amend. Then I got so hooked on it I wanted the
> colorization everytime I ran git-status.
> 
> If anyone is interested in the vim syntax highlighting, it is below.
> Copy the file to $HOME/.vim/syntax/gitcommit.vim and add the following
> line to your .vimrc:
>   autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit

Ah, very nice, thanks for this, makes commits much easier to read now.

greg k-h
