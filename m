From: Matthias Kestenholz <lists@spinlock.ch>
Subject: Re: newbie question
Date: Tue, 16 May 2006 09:09:15 +0200
Message-ID: <20060516070915.GA4680@spinlock.ch>
References: <9FCDBA58F226D911B202000BDBAD467308146E@zch01exm40.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 09:09:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FftgH-0004MN-VO
	for gcvg-git@gmane.org; Tue, 16 May 2006 09:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbWEPHJT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 03:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbWEPHJT
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 03:09:19 -0400
Received: from mail15.bluewin.ch ([195.186.18.63]:17144 "EHLO
	mail15.bluewin.ch") by vger.kernel.org with ESMTP id S1751630AbWEPHJS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 03:09:18 -0400
Received: from spinlock.ch (83.77.57.210) by mail15.bluewin.ch (Bluewin 7.2.073)
        id 4461D7240017247D; Tue, 16 May 2006 07:09:15 +0000
Received: (nullmailer pid 9085 invoked by uid 1000);
	Tue, 16 May 2006 07:09:15 -0000
To: Li Yang-r58472 <LeoLi@freescale.com>
Content-Disposition: inline
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467308146E@zch01exm40.ap.freescale.net>
X-Editor: Vim http://www.vim.org/
X-Operating-System: GNU/Linux 2.6.17-rc3-g532f57da (i686)
X-GPG-Fingerprint: 249B 3CE7 E6AE 4A1F F24A  DC44 B546 3304 690B 13F9
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20109>

Hello,

* Li Yang-r58472 (LeoLi@freescale.com) wrote:
> I just starting to use git recently.  I have setup a public repository,
> and pushed cloned open source repository to it.  As most documents 
> suggested, I need to run a repack on the public repository.  Normally 
> git-repack is run in the source directory(the parent directory of .git).  
> Considering the public repository, there is no source directory and the
> *.git is the uppest level directory.  Where am I supposed to run the
> git-repack command?

Do it like that:

$ ls
project.git
$ GIT_DIR=project.git git-repack -a -d
