From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 5/9] revert: libify pick
Date: Sat, 22 Aug 2009 06:35:56 +0200
Message-ID: <200908220635.56925.chriscool@tuxfamily.org>
References: <20090821054729.3726.5078.chriscool@tuxfamily.org> <20090821055001.3726.15854.chriscool@tuxfamily.org> <7v8whdip1l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 06:35:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeiJu-0002ZS-8e
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 06:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbZHVEfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 00:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752683AbZHVEfB
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 00:35:01 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:40978 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126AbZHVEfA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 00:35:00 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B90C581801E;
	Sat, 22 Aug 2009 06:34:53 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 89DB481805D;
	Sat, 22 Aug 2009 06:34:50 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7v8whdip1l.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126784>

On Friday 21 August 2009, Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > From: Stephan Beyer <s-beyer@gmx.net>
> >
> > This commit is made of code from the sequencer GSoC project:
> >
> > git://repo.or.cz/git/sbeyer.git
> >
> > (commit 5a78908b70ceb5a4ea9fd4b82f07ceba1f019079)
> >
> > The goal of this commit is to abstract out pick functionnality
> > into a new pick() function made of code from "builtin-revert.c".
> >
> > The new pick() function is in a new "pick.c" file with an
> > associated "pick.h".
>
> Is it pick() or pick_commit()?

It is pick_commit(). Sorry I didn't properly update the commit message.

> By the way, this comment applies to other messages in the series, but do
> these original commits by Stephan lack any meaningful messages?

Well, in Stephan's repo the commit 
(94a568a78d243d7a6c13778bc6b7ac1eb46e48cc) that created the pick.c and 
pick.h files had this message:

------
Libify cherry-pick and revert.

A poor start.
------

(Note that I have seen far worse commit messages in other GSoC students' 
repo.)
And then quite a few other commits improved on this one, and the whole gives 
the code that is in this patch.

> I would 
> actually have expected to see a commit log message that looks more like:
>
> 	From: Stephan Beyer <...>
>
>         Meaningful log message Stephan describes what this commit does in
>         sufficient detail, perhaps with clarification and rewording by
>         Christian.
>
> 	Second and subsequent paragraph to explain it as necessary.
>
> 	[cc: this is based on 5a78908b70ceb5a4ea9fd4b82f07ceba1f019079
>         from Stephan's git://repo.or.cz/git/sbeyer.git]
>
>         Signed-off-by: ...
>
> The point is that the "origin info" would be a side-note, not the first
> and the most important thing in the message.

I tried to improve some commit messages like this in the v3 that will follow 
this email.

Thanks,
Christian.
