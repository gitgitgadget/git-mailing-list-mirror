From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git submodules
Date: Wed, 21 Oct 2009 15:38:27 -0400
Message-ID: <32541b130910211238s6f4a04cawd7f95c4731fe4a3b@mail.gmail.com>
References: <f488382f0910171015j1a6d4d9fg690867154334c514@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	crawl-ref-discuss@lists.sourceforge.net
To: Steven Noonan <steven@uplinklabs.net>
X-From: git-owner@vger.kernel.org Wed Oct 21 21:38:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0h1J-00018i-Uk
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 21:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855AbZJUTin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 15:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754745AbZJUTin
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 15:38:43 -0400
Received: from mail-gx0-f216.google.com ([209.85.217.216]:34058 "EHLO
	mail-gx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754005AbZJUTim (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 15:38:42 -0400
Received: by gxk8 with SMTP id 8so7788101gxk.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 12:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=FB89cOCYl450HLIrotvApcNbWhAZff+83VL+pFDc8Lo=;
        b=n+EJvkSgaaVYTrQkuIDpSNrN1FxuQd2hVXgkQltyyJzOI895CrCKSkNKjy4pQOU/yG
         9OTRO8UZ5zM7cGOcdJAVWsoF1em0Vy6UgOxmomNxN03rLofZ/pm4mHSO1LvqR6s7M6iA
         5b/zPOgGRh20vth5Nt8grAA7+gNvRlBLvlws8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ct4pp8leWGwO4Y2Y6iIp5aQRDRTgfmOKF2Qi1LvXSKWxLjJnmpDzn+BsByJRgxdr2l
         BAcLXM6acJ+4z5y5KBAZ4Ha1YMltrBn3M0SXwOMx4GA5RhciwtUic8Ke3pvmiQJErttF
         AUpNU2qGky7JTyILMeIrmg7RhW8MC38ZPbPeQ=
Received: by 10.150.114.1 with SMTP id m1mr13771653ybc.182.1256153927137; Wed, 
	21 Oct 2009 12:38:47 -0700 (PDT)
In-Reply-To: <f488382f0910171015j1a6d4d9fg690867154334c514@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130953>

On Sat, Oct 17, 2009 at 1:15 PM, Steven Noonan <steven@uplinklabs.net> wrote:
> We're using git submodules for the contributing libraries. When I
> commit changes to those contribs, it correctly shows in the parent
> repository that those folders have different revisions than what's
> currently committed. However, if someone pulls those changes, it
> doesn't automatically update the contribs to match the committed
> version. But doing a pull or merge _should_ update the working tree to
> match the committed versions. It does with file data, so why not
> update the submodules? Especially if the submodule revision matched
> the committed version -before- the pull. Why are we forced into using
> 'git submodule update'?

<advertisement>
git-subtree (http://github.com/apenwarr/git-subtree) is an alternative
to submodules that doesn't have this problem.
</advertisement>

But it probably has other problems. :)  Works great for my purposes,
though, and quite a few people have contacted me to say they're using
it happily.

Have fun,

Avery
