From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] git-svn: clarify the referent of dcommit's optional
 argument
Date: Wed, 16 May 2012 00:59:47 +0000
Message-ID: <20120516005945.GA16271@dcvr.yhbt.net>
References: <1336978405-17943-1-git-send-email-jon.seymour@gmail.com>
 <CAH3Anroxjn6sCBYa71Y-H1AvitiFn=dRUapGxgQ1Nu6=Tf03Uw@mail.gmail.com>
 <7vr4umivr2.fsf@alter.siamese.dyndns.org>
 <CAH3Anrr11eLiHkasdLxAWD9--B6QNq5-kFfO+Xg1F5xTDS56zg@mail.gmail.com>
 <7vliktfoza.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	trast@student.ethz.ch
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 02:59:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUSan-000479-AL
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 02:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758419Ab2EPA7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 20:59:49 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41340 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757825Ab2EPA7s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2012 20:59:48 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10B243338B;
	Wed, 16 May 2012 00:59:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vliktfoza.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197861>

Junio C Hamano <gitster@pobox.com> wrote:
> Jon Seymour <jon.seymour@gmail.com> writes:
> > Re-reading this, I don't think the advice:
> >
> >     "It is recommended that you run 'git svn' fetch and rebase (not
> >     pull or merge) your commits against the latest changes in the =C2=A0SVN
> >     repository."
> >
> > really belongs in the description of dcommit at all.
> 
> I tend to agree.  Opinions from git-svn experts?

I agree, too.   It should be moved to/reworded for the
"REBASE VS. PULL/MERGE" section instead.
