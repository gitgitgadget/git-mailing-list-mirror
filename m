From: John Keeping <john@keeping.me.uk>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Fri, 24 May 2013 09:29:01 +0100
Message-ID: <20130524082900.GZ27005@serenity.lan>
References: <7vd2shheic.fsf@alter.siamese.dyndns.org>
 <20130523164114.GV27005@serenity.lan>
 <7vbo81e7gs.fsf@alter.siamese.dyndns.org>
 <20130523215557.GX27005@serenity.lan>
 <7vli75cpom.fsf@alter.siamese.dyndns.org>
 <CAMP44s3-3gpAAyp-WfDjHxJiotO68GUbb5tHw9Qo35yCTGFNqA@mail.gmail.com>
 <7v8v35cnp0.fsf@alter.siamese.dyndns.org>
 <CAMP44s1N=xy2B-YkCLC67pX_EVqAziGWyN1qkrs0Sq=o2jL6Sw@mail.gmail.com>
 <7vzjvlb7mu.fsf@alter.siamese.dyndns.org>
 <CAMP44s1D06ggmTjXBEL0puFLqYDShhy6HV0S+oj0AwDGz-sUqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 10:29:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfnNL-00070M-JE
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 10:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760063Ab3EXI3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 04:29:17 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:49182 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759437Ab3EXI3O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 04:29:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 1D8E7230D6;
	Fri, 24 May 2013 09:29:14 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m1uARUzd-uUF; Fri, 24 May 2013 09:29:11 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 47AD523096;
	Fri, 24 May 2013 09:29:02 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAMP44s1D06ggmTjXBEL0puFLqYDShhy6HV0S+oj0AwDGz-sUqA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225334>

On Thu, May 23, 2013 at 06:53:36PM -0500, Felipe Contreras wrote:
> The alternatives are these:
> 
> a) you annoy the vast majority of the user-base by making 'git pull' a
> dangerous operation that should be avoided, and replaced with 'git
> fetch'+'git rebase'.
> 
> b) you annoy a minority of the user-base by making 'git pull' not do
> the merge the expected, so they have to do +'git merge' (which is
> already less of a change than a)), or configure the default (which
> they most likely are able to do, if they did intent to do a merge).

Note that in my email that started this, I tried to be clear that I was
talking about "git pull" *without a branch name*.  If this user
explicitly says "git pull remote branch" then I consider that a clear
indication that they really do mean to perform a merge; I would not
recommend changing the current behaviour in that case.

If the user just says "git pull" then it is more likely that they are
just trying to synchronise with the upstream branch, in which case they
probably don't actually want a merge.
