From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Branches & directories
Date: Thu, 18 Aug 2011 12:56:26 +0200
Message-ID: <4E4CEFDA.9000703@drmicha.warpmail.net>
References: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com> <CABNdCrCbSqup1=D2eEbGDhw3JzZGYHWLVqZFsB6GDO4Vk7HRxg@mail.gmail.com> <7vvctvdf5r.fsf@alter.siamese.dyndns.org> <CAE1pOi3rqqcz_6QxB8=g2jWOF-4SRZee7t8NXN1md2C4DL7wug@mail.gmail.com> <CAMOZ1BsZvXsnnWAPXR7UGKdqOMwuGB-ffaAPk55U_1dcjZUcDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 12:56:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu0H5-0000dx-SL
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 12:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213Ab1HRK4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 06:56:30 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:45835 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750785Ab1HRK43 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2011 06:56:29 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 073F820BD5;
	Thu, 18 Aug 2011 06:56:29 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute4.internal (MEProxy); Thu, 18 Aug 2011 06:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=TT1TYZPxbjClfXajCN5tFo
	KahUQ=; b=AOn20JMQvsbDkr+lXP6d6cqRJm1nKvEKsW41BZye4H+D40B7XDRIX0
	1dDwtuuiFFtjJriwJXw22bEaM+RoBxNxKhhSKxA3LqWifMApjimb1BIEYb+3TVO4
	Qgf+eTYA8MnH5W8lvLUCaqtLrZzXGDQ+Pj5A77jcwjtO7B/1Dx3Pg=
X-Sasl-enc: W5/efvSgsq2z12i0SxZSN3LDJNEi7/XIvrHXD19lsuxE 1313664988
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 094F7720074;
	Thu, 18 Aug 2011 06:56:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <CAMOZ1BsZvXsnnWAPXR7UGKdqOMwuGB-ffaAPk55U_1dcjZUcDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179588>

Michael Witten venit, vidit, dixit 18.08.2011 07:52:
> On Wed, Aug 17, 2011 at 21:23, Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:
>> It would be really nice, though, if Git could somehow
>> "stash" such files when checking out a different branch. In general, I
>> would prefer if uncommitted changes and untracked and/or ignored files
>> stuck to the branch where they were created.
> 
> As an aside, the problem here is likely a manifestation of the fact
> that nobody understands what a branch is; the word 'branch' is

I would reject "nobody"...

> TERRIBLE, as everyone has a different idea for what that should mean.

... and insist that this statement is true either trivially true for all
words, or for none, depending on your understanding of "everyone has a
different".

> In my opinion, `git branch' should become `git ref' or the like.

"branch" and "tag" are boths refs. Their only essential difference is
that one "moves" and the other doesn't.

> One of git's worst faults is that a complicated and imprecise
> interface has been draped over a very simple and precise underlying
> structure.

A name is a name and just that. The use of any existing word may clash
with someone's expectations.

I find the concepts "file created on a branch", "commit created on a
branch" silly, it's part of what drove me from hg to git early on. A git
"branch" is an hg "bookmark" these days (a named "head"), and if that
name triggers the right associations for some people, its best used in
explanations for those. git's branches do exactly what I (and many
others) expect branches to do and what I need daily, even coming from a
svn and hg background.

Michael
