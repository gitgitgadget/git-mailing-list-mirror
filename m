From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: feature request - telling git bisect to skip, from inside a commit
Date: Mon, 28 Mar 2011 06:03:16 +0200
Message-ID: <201103280603.16256.chriscool@tuxfamily.org>
References: <AANLkTinCiM9uqK8Yr=pKaeKytWXqpWF898AeTwvHKg4-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jim Cromie <jim.cromie@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 06:03:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q43fv-0004q9-7e
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 06:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136Ab1C1ED0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 00:03:26 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:40787 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753822Ab1C1EDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 00:03:25 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C56FAA623C;
	Mon, 28 Mar 2011 06:03:17 +0200 (CEST)
User-Agent: KMail/1.13.5 (Linux/2.6.35-22-generic; KDE/4.5.1; x86_64; ; )
In-Reply-To: <AANLkTinCiM9uqK8Yr=pKaeKytWXqpWF898AeTwvHKg4-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170100>

Hi,

On Saturday 26 March 2011 19:48:25 Jim Cromie wrote:
> sometimes its feels clearer to devote a commit to changing (for example)
> the definition of a struct;  and changing all users of that struct in
> the next commit.
> This isolates and highlights the definitional change, rather than burying
> it in the middle of a huge diff.
> 
> The downside of doing this is that git bisect will trip over this 1/2
> change. It would be nice if a committer could mark the commit as not
> bisectable, perhaps by just adding this, on a separate line, to the
> commit-message:
> 
>     "git bisect skip [optional range]"
> 
> the range presumably would be something like CURRENT^1
> except that it would make more sense to flag successors than ancestors,
> and of course, CURRENT would have to mean something.
> 
> Anyway, range isnt really needed, as any subsequent interim commits
> could also flag themselves as such.
> 
> git bisect already has ability to skip a commit, this just helps an
> automated bisection script.

Please look at this recent thread:

http://thread.gmane.org/gmane.comp.version-control.git/169026/

where there are other suggestions and discussions about how to deal with this 
kind of problems.

Thanks,
Christian.
