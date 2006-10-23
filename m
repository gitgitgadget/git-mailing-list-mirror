From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [ANNOUNCE] GIT 1.4.3.1
Date: Mon, 23 Oct 2006 13:42:47 +0200
Message-ID: <20061023114247.GO8251@kernel.dk>
References: <7v4ptyi68s.fsf@assigned-by-dhcp.cox.net> <20061023113956.GN8251@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 13:41:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbyBg-0001Zb-4i
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 13:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWJWLlo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 07:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWJWLlo
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 07:41:44 -0400
Received: from brick.kernel.dk ([62.242.22.158]:28704 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932104AbWJWLln (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 07:41:43 -0400
Received: from nelson.home.kernel.dk (nelson.home.kernel.dk [192.168.0.33])
	by kernel.dk (Postfix) with ESMTP id 18453257BD0;
	Mon, 23 Oct 2006 13:41:40 +0200 (CEST)
Received: by nelson.home.kernel.dk (Postfix, from userid 1000)
	id E54BD11A1F; Mon, 23 Oct 2006 13:42:47 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20061023113956.GN8251@kernel.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29826>

On Mon, Oct 23 2006, Jens Axboe wrote:
> On Fri, Oct 20 2006, Junio C Hamano wrote:
> > The latest maintenance release GIT 1.4.3.1 is available at the
> > usual places:
> > 
> >   http://www.kernel.org/pub/software/scm/git/
> > 
> >   git-1.4.3.1.tar.{gz,bz2}			(tarball)
> >   git-htmldocs-1.4.3.1.tar.{gz,bz2}		(preformatted docs)
> >   git-manpages-1.4.3.1.tar.{gz,bz2}		(preformatted docs)
> >   RPMS/$arch/git-*-1.4.3.1-1.$arch.rpm	(RPM)
> > 
> > This is primarily to work around changes in the recent GNU diff output
> > format.  Also it contains irritation fix for "git diff" which now
> > paginates its output by default.
> > 
> > ----------------------------------------------------------------
> > 
> > Changes since v1.4.3 are as follows:
> > 
> > Junio C Hamano (1):
> >       pager: default to LESS=FRS
> 
> It still behaves badly, git diff still shows my an empty pager waiting
> for 'q', while LESS=FRS git diff works as desired.

Ah:

        setenv("LESS", "FRS", 0);

axboe@nelson:/home/axboe/git/git $ echo $LESS
-M -I

-- 
Jens Axboe
