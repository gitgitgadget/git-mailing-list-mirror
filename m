From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Documentation: Fix references to deprecated commands
Date: Mon, 12 Nov 2007 10:37:19 +0100
Message-ID: <20071112093719.GA22555@diku.dk>
References: <Pine.LNX.4.64.0711080041120.4362@racer.site> <20071108145435.GA18727@diku.dk> <4733249B.9020504@op5.se> <20071108160114.GB20988@diku.dk> <7vzlxo1mga.fsf@gitster.siamese.dyndns.org> <20071109002001.GB5082@diku.dk> <7vy7d8xlej.fsf_-_@gitster.siamese.dyndns.org> <20071112002410.GA21970@diku.dk> <20071112003251.GB21970@diku.dk> <7vbq9z50vj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 10:37:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrVjq-0007Gx-0u
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 10:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723AbXKLJh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 04:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755633AbXKLJh2
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 04:37:28 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:58154 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755627AbXKLJh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 04:37:27 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 2254C7704BA;
	Mon, 12 Nov 2007 10:37:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mfDA2wmqVElr; Mon, 12 Nov 2007 10:37:24 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 8DB0B770502;
	Mon, 12 Nov 2007 10:37:19 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 240826DFD94; Mon, 12 Nov 2007 10:36:53 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 577455B8001; Mon, 12 Nov 2007 10:37:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vbq9z50vj.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64582>

Junio C Hamano <gitster@pobox.com> wrote Mon, Nov 12, 2007:
> Jonas Fonseca <fonseca@diku.dk> writes:
> 
> > diff --git a/Documentation/git-get-tar-commit-id.txt b/Documentation/git-get-tar-commit-id.txt
> > index 9b5f86f..ef1b19c 100644
> > --- a/Documentation/git-get-tar-commit-id.txt
> > +++ b/Documentation/git-get-tar-commit-id.txt
> > @@ -14,12 +14,12 @@ SYNOPSIS
> >  DESCRIPTION
> >  -----------
> >  Acts as a filter, extracting the commit ID stored in archives created by
> > -git-tar-tree.  It reads only the first 1024 bytes of input, thus its
> > +gitlink:git-archive[1].  It reads only the first 1024 bytes of input, thus its
> >  runtime is not influenced by the size of <tarfile> very much.
> >  
> >  If no commit ID is found, git-get-tar-commit-id quietly exists with a
> >  return code of 1.  This can happen if <tarfile> had not been created
> > -using git-tar-tree or if the first parameter of git-tar-tree had been
> > +using git-archive or if the <treeish> parameter of git-archive had been
> >  a tree ID instead of a commit ID or tag.
> >
> > -- 
> > Jonas Fonseca
> 
> How did you prepare this hunk?  I count 10 lines preimage and
> postimage, followed by a blank line and the signature separator
> "-- " you added in your MUA, but the header claims to have 12
> lines.

I am sorry to cause you this kind of problems. Usually I keep the patch
ending inserted by format-patch, but yesterday I deleted it for some
unknown reason. Maybe I should learn to use git-send-email. 

-- 
Jonas Fonseca
