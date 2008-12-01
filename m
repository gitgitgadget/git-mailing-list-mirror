From: Johan Herland <johan@herland.net>
Subject: Re: Is rebase always destructive?
Date: Mon, 1 Dec 2008 12:54:35 +0100
Message-ID: <200812011254.36109.johan@herland.net>
References: <slrngj7jch.2srb.csaba-ml@beastie.creo.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Csaba Henk <csaba-ml@creo.hu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 12:56:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L77Np-0004OJ-1Z
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 12:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbYLALyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 06:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbYLALyv
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 06:54:51 -0500
Received: from sam.opera.com ([213.236.208.81]:50129 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbYLALyv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 06:54:51 -0500
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id mB1Bsa6n028862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 1 Dec 2008 11:54:41 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <slrngj7jch.2srb.csaba-ml@beastie.creo.hu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102024>

On Monday 01 December 2008, Csaba Henk wrote:
> Hi,
>
> When doing a rebase, I can find a number of reasons for which one
> might feel like to preserve the rebased branch (that is, perform an
> operation which copies the branch over a new base, not moves).
>
> -  For example, a successful rebase doesn't necessarily mean that the
>    code, as of the rebased branch, is consistent and compiles. That
> is, the rebase can be broken even if git can put things together
> diff-wise. In such a case I wouldn't be happy to lose the original
> instance of the branch.
>
> -  Or I might want to build different versions of the program, and
> each version of it needs a given set of fixes (the same one). Then
> rebasing my bugfix branch is not a good idea, I'd much rather copy it
> over all those versions.
>
> I can't see any option for rebase which would yield this cp-like
> behaviour. Am I missing something? Or people don't need such a
> feature? (Then give me some LART please, my mind is not yet gittified
> enough to see why is this not needed.) Or is it usually done by other
> means, not rebase?

The operation you refer to as "cp-like" rebase behaviour is equivalent 
to cherry-picking a range of commits. The latter has been discussed 
extensively on this list, although I'm not sure any conclusion has been 
reached.

I would also very much like to have this operation available in either 
form ("git rebase --copy" or "git cherry-pick from..to"), although I'd 
probably prefer the "git cherry-pick from..to" form.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
