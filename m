From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation: enhanced "git for CVS users" doc about
	shared repositories
Date: Wed, 7 Nov 2007 11:47:48 -0500
Message-ID: <20071107164748.GA10525@fieldses.org>
References: <472F99F8.4010904@gmail.com> <7v8x5cmern.fsf@gitster.siamese.dyndns.org> <4730E056.7080809@gmail.com> <7vd4unez2l.fsf@gitster.siamese.dyndns.org> <47310ACF.4030103@gmail.com> <277490E5-2B9A-4BA7-9DD7-C1CEE698B348@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francesco Pretto <ceztkoml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 17:50:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipo6N-0001QT-FG
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 17:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756565AbXKGQto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 11:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756153AbXKGQto
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 11:49:44 -0500
Received: from mail.fieldses.org ([66.93.2.214]:49519 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755461AbXKGQtn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 11:49:43 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1Ipo4C-0004Yt-Vt; Wed, 07 Nov 2007 11:47:48 -0500
Content-Disposition: inline
In-Reply-To: <277490E5-2B9A-4BA7-9DD7-C1CEE698B348@zib.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63833>

On Wed, Nov 07, 2007 at 09:07:58AM +0100, Steffen Prohaska wrote:
> On Nov 7, 2007, at 1:46 AM, Francesco Pretto wrote:
>
>> Junio C Hamano ha scritto:
>>>
>>> Honestly speaking, I am not too thrilled about making the
>>> cvs-migration document much longer than what it currently is.
>>>
>
> Maybe the description of setting up a shared repository should
> go to the user-manual and cvs-migration should refer to the
> user-manual, instead of the other way round. I don't like the
> idea that the user-manual is referring to a CVS specific guide.
> The user manual should be as self-contained as possible.

I'd be interested in patches that did that.  If somebody wants to work
on that, they might want to start with

	git://linux-nfs.org/~bfields/git.git docwork-foreign-scms

which has the skeleton of an "interoperating with foreign scms" chapter.

The thing that's kept me from working on this in the past is that it's a
bit of a step backwards for someone that *just* wants to get to the
cvs-migration stuff, since now it may appear you have to plow through
the rest of the manual to get to it.

We could address that with clearer dependency information ("before
reading this chapter, read chapters 1 and 3..."), and/or by providing
some more links (e.g. repopulate the howto directory with links to some
chapters that address popular questions).

--b.
