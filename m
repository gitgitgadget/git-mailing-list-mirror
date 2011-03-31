From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 3/3] revisions.txt: language improvements
Date: Thu, 31 Mar 2011 14:19:29 +0200
Message-ID: <AANLkTikofGHcJtHMAqhAM7ofD=f2jybPAiJTnV=4ciu7@mail.gmail.com>
References: <cover.1301569271.git.git@drmicha.warpmail.net>
	<48111612952115ce454de0766e3537da92e141ac.1301569271.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 14:19:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Gqd-0003hz-VL
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 14:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757402Ab1CaMTb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 08:19:31 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50822 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552Ab1CaMTa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 08:19:30 -0400
Received: by qwk3 with SMTP id 3so1430872qwk.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 05:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fXoMgKS3YoED5ThtiJ9dqkrixLB+bVA7NIFyT6X2NYE=;
        b=rw1nBaXC7BHGyFOxgpVzv/OhPojrkupX1jaX6wrQIYD7zmTW3P/7K9FJVzKP+oTRIN
         8HOMGHgvIk+qs1nV87XdBSDJfh3aU1yVWcr4DpwTfH6HG8IAr60UWcuE21YStUzS8O0P
         oZSJM9PiNM80nAFjiLmVadXyO71Px36GJcKgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fay8SGBl8W28AJpVRcB83dF7JdhyKByn3z266DtHP5HEfey8vgeDj2PEAyISOso4j6
         vx/VfPXUdVw9Z/Lqd12dQaArKL6FEYTrzL+8s6AjUltPlHF6eOAZhxWNtCRFy5daLzIB
         dS4FEaVUFIQf2y5jfDzdDdzCLRvtNORwT8sbk=
Received: by 10.224.203.73 with SMTP id fh9mr2029472qab.340.1301573969358;
 Thu, 31 Mar 2011 05:19:29 -0700 (PDT)
Received: by 10.224.134.68 with HTTP; Thu, 31 Mar 2011 05:19:29 -0700 (PDT)
In-Reply-To: <48111612952115ce454de0766e3537da92e141ac.1301569271.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170480>

On Thu, Mar 31, 2011 at 13:03, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> =C2=A0Documentation/revisions.txt | =C2=A0 68 +++++++++++++++++++++--=
-------------------
> =C2=A01 files changed, 34 insertions(+), 34 deletions(-)
>
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.tx=
t
> index fa399df..288fa6e 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -27,30 +27,30 @@ blobs contained in a commit.
> =C2=A0 When ambiguous, a '<name>' is disambiguated by taking the
> =C2=A0 first match in the following rules:
>
> - =C2=A0. if '$GIT_DIR/<name>' exists, that is what you mean (this is=
 usually
> + =C2=A0. If '$GIT_DIR/<name>' exists, that is what you mean (this is=
 usually
> =C2=A0 =C2=A0 useful only for 'HEAD', 'FETCH_HEAD', 'ORIG_HEAD', 'MER=
GE_HEAD'
> =C2=A0 =C2=A0 and 'CHERRY_PICK_HEAD');
>
> - =C2=A0. otherwise, 'refs/<name>' if exists;
> + =C2=A0. otherwise, 'refs/<name>' if it exists;
>
> - =C2=A0. otherwise, 'refs/tags/<refname>' if exists;
> + =C2=A0. otherwise, 'refs/tags/<refname>' if it exists;
>
> - =C2=A0. otherwise, 'refs/heads/<name>' if exists;
> + =C2=A0. otherwise, 'refs/heads/<name>' if it exists;
>
> - =C2=A0. otherwise, 'refs/remotes/<name>' if exists;
> + =C2=A0. otherwise, 'refs/remotes/<name>' if it exists;
>
> - =C2=A0. otherwise, 'refs/remotes/<name>/HEAD' if exists.
> + =C2=A0. otherwise, 'refs/remotes/<name>/HEAD' it if exists.

s/it if/if it/

> =C2=A0+
> -'HEAD' names the commit your changes in the working tree is based on=
=2E
> -'FETCH_HEAD' records the branch you fetched from a remote repository
> +'HEAD' names the commit on which you based the changes in the workin=
g tree.
> +'FETCH_HEAD' records the branch which you fetched from a remote repo=
sitory
> =C2=A0with your last `git fetch` invocation.
> -'ORIG_HEAD' is created by commands that moves your 'HEAD' in a drast=
ic
> +'ORIG_HEAD' is created by commands that move your 'HEAD' in a drasti=
c
> =C2=A0way, to record the position of the 'HEAD' before their operatio=
n, so that
> -you can change the tip of the branch back to the state before you ra=
n
> -them easily.
> -'MERGE_HEAD' records the commit(s) you are merging into your branch
> +you can easily change the tip of the branch back to the state before=
 you ran
> +them.
> +'MERGE_HEAD' records the commit(s) which you are merging into your b=
ranch
> =C2=A0when you run `git merge`.
> -'CHERRY_PICK_HEAD' records the commit you are cherry-picking
> +'CHERRY_PICK_HEAD' records the commit which you are cherry-picking
> =C2=A0when you run `git cherry-pick`.
> =C2=A0+
> =C2=A0Note that any of the 'refs/*' cases above may come either from
