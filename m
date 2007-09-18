From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Problem with merge when renaming
Date: Wed, 19 Sep 2007 00:44:47 +0200
Message-ID: <20070918224447.GC14488@steel.home>
References: <95b3d0af0709181334y1e21507ey485860e4d45aa26f@mail.gmail.com> <7v7imnvca0.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Euresti <evelio@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 00:44:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXloO-0008Sg-PX
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 00:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759922AbXIRWov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 18:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759811AbXIRWou
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 18:44:50 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:26407 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759465AbXIRWot (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 18:44:49 -0400
Received: from tigra.home (Faaaa.f.strato-dslnet.de [195.4.170.170])
	by post.webmailer.de (mrclete mo9) (RZmta 12.10)
	with ESMTP id m05987j8IJFGUo ; Wed, 19 Sep 2007 00:44:47 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 56BAC27752;
	Wed, 19 Sep 2007 00:44:47 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 3061FBF18; Wed, 19 Sep 2007 00:44:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v7imnvca0.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolCodE=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58653>

Junio C Hamano, Wed, Sep 19, 2007 00:28:39 +0200:
> "David Euresti" <evelio@gmail.com> writes:
> 
> > I think I found a problem when you move a file into a directory of the
> > same name.  Here's what I did.
> 
> Two questions.
> 
>  (1) git --version?

it happens with very recent git (as of today)

>  (2) if you do "git merge -s resolve" instead of just "git
>      merge", do you see a difference?

yes: it has more error output.

Trying really trivial in-index merge...
warning: Merge requires file-level merging
Nope, a really trivial in-index merge not possible
Trying simple merge.
Simple merge failed, trying Automatic merge.
error: init: is a directory - add individual files instead
fatal: Unable to process path init
fatal: merge program failed
Automatic merge failed; fix conflicts and then commit the result.
