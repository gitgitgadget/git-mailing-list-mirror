From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: dangling commits
Date: Mon, 16 Jan 2006 11:08:14 +0100
Message-ID: <20060116100814.GA5196@fiberbit.xs4all.nl>
References: <20060116085238.GA3768@fiberbit.xs4all.nl> <20060116093249.8F939353A3F@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Marco Roeland <marco.roeland@xs4all.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 11:08:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyRHg-00043O-BX
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 11:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWAPKIR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 05:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWAPKIR
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 05:08:17 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:59798 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S932312AbWAPKIR
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 05:08:17 -0500
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.54)
	id 1EyRHa-0001My-LF; Mon, 16 Jan 2006 11:08:14 +0100
To: Wolfgang Denk <wd@denx.de>
Content-Disposition: inline
In-Reply-To: <20060116093249.8F939353A3F@atlas.denx.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14735>

On Monday January 16th 2006 Wolfgang Denk wrote:

> I like to have  my  repository  "clean"  so  there  are  no  warnings
> normally  from  git-fsck-objects  -  if  you  get used to expect some
> "harmless" messages you might easily miss a critical error.

That's right, yes.

> > However you can easily get rid of them by using "git prune".
> 
> Tried this, didn't work.

Ok, didn't know that it didn't prune directly from packs. I should have
realised that it only can do so efficiently by repacking I suppose.

> Ummm... please have a look at the  .git/objects/pack/  directory  for
> example in your Linux repository.

I did as a matter of fact, but I use "git" as protocol and also
regularly "repack" the repository, when I'm not using the machine for
a while, to make 'gitk' and 'qgit' work faster. It is less apparent
then! Thanks very much for clearing up my knowledge. It only shows the
power of git that even ignorant gits like myself still find it useful
and productive. There's just enough rope to wiggle yourself out of
precarious situations but fortunately most of the time not enough to
hang yourself.
-- 
Marco Roeland
