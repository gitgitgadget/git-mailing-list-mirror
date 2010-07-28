From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Recommended work flow with git to send in patches
Date: Wed, 28 Jul 2010 18:49:45 +0200
Message-ID: <201007281849.47989.jnareb@gmail.com>
References: <AANLkTiksAOpFG3vGVGcbeZ0NcpQ5FbDjnZ7yDxUsAY_r@mail.gmail.com> <m3y6cwkew7.fsf@localhost.localdomain> <AANLkTi=psuiq-GP9zV=pY6swNAUF-MwJt6COrNDVDLqu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tong Sun <suntong@cpan.org>
X-From: git-owner@vger.kernel.org Wed Jul 28 18:50:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe9pZ-0004GG-SG
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 18:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755798Ab0G1QuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 12:50:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62627 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755691Ab0G1QuA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 12:50:00 -0400
Received: by fxm14 with SMTP id 14so1384494fxm.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 09:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+ePObehL9VRNjwSsp1hYUBHEbbPaiBFpP/q19eMN/nc=;
        b=i3DAIAMBHr5qTXHMhLRngHs1kbL0Ujytx4kLX0o+0Dio2eddSnGeQVGNAJ7w2/4F8x
         S81PNLbR51uG4O0XQc3qW3Gdl151KjEqHSNLZ+tYHOSZMX+LEVp90aFYkMQH/wiBNtSp
         Z8/042DVvumsTc4Im7Li2bM0J1od6RMS9ldgA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vlmPKBJ7OxuQOPHl8Hd6lv5/ysGsoI+nClEfhobsYXn3Ys4D/4d6IfnH3bzo9Rhwgs
         5E0C6IUBSPnVOZmvqG80t84shRO3MTcvBzCXuKMfm/kqXHJgZ+FUYz7BPQePesZe/0l5
         acuWOZ+gTarEFJBSg9I43u6OGCPEhXPFFNvnI=
Received: by 10.223.105.14 with SMTP id r14mr10313595fao.33.1280335799191;
        Wed, 28 Jul 2010 09:49:59 -0700 (PDT)
Received: from [192.168.1.13] (abvz244.neoplus.adsl.tpnet.pl [83.8.223.244])
        by mx.google.com with ESMTPS id b9sm2679747faq.31.2010.07.28.09.49.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 09:49:57 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTi=psuiq-GP9zV=pY6swNAUF-MwJt6COrNDVDLqu@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152102>

On Tue, Jul 27, 2010, Tong Sun wrote:
> On Tue, Jul 27, 2010 at 1:35 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> 
> > Doesn't GRML have web page / wiki page for developers?
> 
> Yes, http://grml.org/git/, but it is kind of reference book style,
> doesn't cover much on the work flow, especially on the topic of
> no-writing-privilege user contributing back.

You could point lack of information for "leaf" contributors to them...

> > > - do initial git pull into grml-debootstrap
> > >
> > >   git pull git://git.grml.org/grml-debootstrap master
> >
> > Why not git-clone (possibly shallow, if you are working on one-shot
> > patch or patch series)?
> 
> Ok, to explain it, I have to touch upon my "life long story" of using
> git. Long story short on this, the recommended work flow that I
> searched and found from the Inet was to do 'git clone' from web then
> 'git clone' a local working copy. Here is my trying log:
> 
> # Download the latest version of the repository without downloading all the
> history, using "shallow checkouts".
> 
>   git clone --depth 1 git://git.grml.org/grml-debootstrap.git

O.K.
 
> create working repo:
> 
>   $ git-clone --depth 1 grml-debootstrap grml-debootstrap.working
>   Initialized empty Git repository in
> /export/repositories/gitwork/grml/grml-debootstrap.working/.git/
>   fatal: attempt to fetch/clone from a shallow repository
>   ^^^^^^^^^^^^^^^
> 
> Seeing that fatal error, and not knowing where to get help from, I
> just gave up the 'git clone' approach. Please be specific (with git
> commands), how would I use 'git clone' for working on one-shot patch
> or patch series.

I don't understand this second step.  Why do you want this second clone?
It is totally unnecessary.  The clone you make is working repository
you can make your contributions in.

In short, the workflow should look like this (I use here grml as example,
but in practice I used git repository as I know it is fairly small, so
the numbers, SHA-1 identifiers and branches won't match)

  $ cd <somewhere>
  $ git clone --depth 1 git://git.grml.org/grml-debootstrap.git
  Initialized empty Git repository in <somwehere>/grml-debootstrap/.git/
  [...]
  $ cd grml-debootstrap
  $ git branch -a
  * master
    remotes/origin/HEAD -> origin/master
    remotes/origin/master
  [...]

Now you have two choices: you can work on 'master' branch (reasonable
if you want to do only single thing), or you can create your own branch
(one branch for one independent unrelated feature).  Let's create new
branch off 'origin' == 'origin/master' == 'remotes/origin/master'

  $ git checkout -b t/my-working-branch origin
  Branch t/my-working-branch set up to track remote branch master from origin.
  Switched to a new branch 't/my-working-branch'

We could first setup git in such way, that it sets up to track upstream
via rebasing rather than via merge (using `branch.autosetuprebase` config
variable), but let's not complicate matters.

Now you work on branch

  [edit, edit, edit]
  [commit or commit --amend]
  [repeat as necessary]
  
Now, after some time you feel that your changes are ready for sending.
First, download any new changes, if any.

  $ git fetch

Then use interactive rebase to both update your changes to apply to most
recent upstream code, and also reorder and edit your patches (e.g. fix
typo in commit message, move fix commit and squash it with fixed commit,
etc.)

  $ git rebase --interactive origin
  [...]
  Successfully rebased and updated refs/heads/t/my-working-branch.

Then you need to generate patches.  If its more of them, I found it good
idea to save them in separate subdirectory, but it might be not necessary
for you

  $ git format-patch --cover-letter origin..

There are some situations where you don't need cover letter, e.g. if you
are sending single patch, but they are quite useful especially with longer
series.

  [edit '0000-cover-letter.patch' at least]
  [add comments to individual patches, if necessary]

Then you can either use your email client, or just

  $ git send-email --dry-run *.patch

(Here you see why saving patch series to separate subdirectory by
using '-o' option makes it easy to pick up relevant patches... ;-))

HTH
-- 
Jakub Narebski
Poland
