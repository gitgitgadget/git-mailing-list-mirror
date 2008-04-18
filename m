From: "=?ISO-8859-1?Q?Stefan_N=E4we?=" <stefan.naewe@googlemail.com>
Subject: Re: Q. regarding subtree merge
Date: Fri, 18 Apr 2008 14:18:25 +0200
Message-ID: <60b759020804180518k2fc1957bk60a5d7cdac8c3991@mail.gmail.com>
References: <loom.20080418T091729-407@post.gmane.org>
	 <8aa486160804180302m43a7c942la93954401741b264@mail.gmail.com>
	 <8aa486160804180309o26ab9c69j2b3b665a280bf7c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 15:31:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmpYf-0001Bh-Ob
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 14:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbYDRMS1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Apr 2008 08:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752253AbYDRMS1
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 08:18:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:19134 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbYDRMS0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Apr 2008 08:18:26 -0400
Received: by nf-out-0910.google.com with SMTP id g13so230670nfb.21
        for <git@vger.kernel.org>; Fri, 18 Apr 2008 05:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=pKJnUAOtnUdOjegvrZvbvomjFdCx99VXExD5k+q47jo=;
        b=W0YtvfnPv2B4tpVWRsW0+6ah8IorbdtfuNG10Ydf5ho0t2RJm6WuB1D1+dVvqDXUjnr/roybPB9LPTR9dpOW+1wZUPqvhthOrR37t//n/E0Npfl3DyaxGBQ1aniHQAZRpPGuCilitt8z7SwpReQuEMQxx9hfU6tZodubmAXNvs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jwrQKOueYF86Jz4ErWqg73ME8J4z1dSUdHbms9w5afscVDD0FLKG8GqkwIoWXSmqxOnyrLNX48FTOWhBkaS3Sweha/HRyK7irOH9mr78iFLDN9ys2UxQOUkMRtoUxDZSRbNHPJLAXV4Lu5UZ0Lxseatr//nxHzRPMA+cpx5kxLM=
Received: by 10.78.81.20 with SMTP id e20mr3245134hub.64.1208521105134;
        Fri, 18 Apr 2008 05:18:25 -0700 (PDT)
Received: by 10.78.150.9 with HTTP; Fri, 18 Apr 2008 05:18:25 -0700 (PDT)
In-Reply-To: <8aa486160804180309o26ab9c69j2b3b665a280bf7c4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79888>

2008/4/18, Santi B=E9jar <sbejar@gmail.com>:
> On Fri, Apr 18, 2008 at 12:02 PM, Santi B=E9jar <sbejar@gmail.com> wr=
ote:
>  >
>  > On Fri, Apr 18, 2008 at 11:36 AM, Stefan N=E4we
>  >  <stefan.naewe+git@gmail.com> wrote:
>  >  > Hi all.
>  >  >
>  >  >  I tried the scenario described in
>  >  >  $GIT_DIR/Documentation/howto/using-merge-subtree.txt and have =
some problems
>  >  >  with it.
>  >  >
>  >  >  My setup:
>  >  >
>  >  >  I use git to track my changes in three different "project dire=
ctories", lets
>  >  >  say:
>  >  >
>  >  >  ...../src_root/libfoo
>  >  >  ...../src_root/appbar
>  >  >  ...../bin_root/installed
>  >  >
>  >  >  All three git repositories contain a topic branch (lets say 'c=
urrent-work')
>  >  >  that I want to track.
>  >  >
>  >  >  Now I want to setup one git repository containing only the thr=
ee directories
>  >  >  'libfoo', 'appbar', and 'installed' that others can clone easi=
ly. Reading the
>  >  >  above howto document, I think this should be possible.
>  >  >
>  >  >  I do:
>  >  >
>  >  >   $ mkdir super-prj
>  >  >   $ cd super-prj
>  >  >   $ git init
>  >  >   $ git add remote -f libfoo ../path/to/src_root/libfoo
>  >  >
>  >  >  OK. No problem.
>  >  >
>  >  >  The problem arises after the second step of the howto:
>  >  >
>  >  >   $ git merge -s ours --no-commit libfoo/current-work
>  >  >
>  >  >  Now, all files of 'libfoo' are in the current directory. This =
is not what I
>  >  >  want.
>  >  >
>  >  >  Could someone please tell me what I'm doing wrong?
>  >
>  >  You are trying to merge libfoo with an empty project, so the merg=
e
>  >  just "fast-forward" to the other commit as you do not have an "ou=
rs".
>  >
>  >  Simply skip the merge step.
>
>
> Ups, I think you have to specify the parent for the new commit. Maybe
>  change the merge step with:
>
>  $ git reset --soft libfoo/current-work
>

OK. Thanks. It worked without the merge.
I did another test where the 'super-prj' was not empty, this time with
'git merge -s...' and
that worked as well. So:
If you have an empty super-prj    -> drop the merge
If you have a non-empty super-prj -> do the merge

But I really don't understand (yet...) why it is as it is...

Thanks

Stefan
