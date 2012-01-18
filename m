From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Wed, 18 Jan 2012 07:20:45 +0530
Message-ID: <CAMK1S_hK_shh5g8BOxhKz3tw2m=kp6qZM1ZTQOOnY2eMNzL3hA@mail.gmail.com>
References: <jbvj5o$skt$1@dough.gmane.org>
	<20111217101009.GA19248@sita-lt.atc.tcs.com>
	<20111217101106.GB19248@sita-lt.atc.tcs.com>
	<CAEY4ZpPKLrWQpEUYkwST8Fh40JwrjxvD+6yML6A+=XpsYmPevg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Gelonida N <gelonida@gmail.com>, git@vger.kernel.org
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 02:50:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnKfr-0003O0-GA
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 02:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756514Ab2ARBuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 20:50:46 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:47397 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753852Ab2ARBuq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2012 20:50:46 -0500
Received: by obcva7 with SMTP id va7so6583843obc.19
        for <git@vger.kernel.org>; Tue, 17 Jan 2012 17:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oJhw5gu6/kJLfE68ebdNVxPeaLNhp6LSKn5bVqlKXE4=;
        b=xtpvAwFF/T7lnradK3B5yseTsCTb099yI4BGBvIztq3Sqo4Cv744rfE+9sWsnJpnkZ
         8riy4KruXzCQOJqv2g3IjdJi9r0cAnvboCstKsqzD7SfSshumGFNz0OwVZ1+nwdSulcg
         zMc7mxE1758Gaq6L1bLqdZ4roRQhEagie7voM=
Received: by 10.182.11.37 with SMTP id n5mr8196093obb.13.1326851445645; Tue,
 17 Jan 2012 17:50:45 -0800 (PST)
Received: by 10.182.51.170 with HTTP; Tue, 17 Jan 2012 17:50:45 -0800 (PST)
In-Reply-To: <CAEY4ZpPKLrWQpEUYkwST8Fh40JwrjxvD+6yML6A+=XpsYmPevg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188737>

(sorry about that previous email; hit send in error.  Here's the complete one)

On Mon, Dec 19, 2011 at 12:01 PM, Nazri Ramliy <ayiehere@gmail.com> wrote:
> On Sat, Dec 17, 2011 at 6:11 PM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
>> oops; forgot the program...
>
> This is nice!
>
> Stick it on github, or somewhere, please, so that I can always get the
> latest and greatest?
>
> Thanks.
>
> nazri

ok; it's on github: http://github.com/sitaramc/git-tools (they're all
standalone tools; you don't have to use the others)

The output is now colorised, and it will now also tell you, for each
remote you have, what branches you are hiding from them and what they
have which you have not started tracking locally.

a "screenshot" is at
http://sitaramc.github.com/git-tools/index.html#index_git_branch_check_

I notice I'm using it more and more, often even as a replacement for
'git status'... at least for repos where I'm juggling multiple
remotes.
