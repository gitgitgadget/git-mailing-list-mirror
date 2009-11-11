From: Baz <brian.ewins@gmail.com>
Subject: Re: [PATCH] Clarify documentation on the "ours" merge strategy.
Date: Wed, 11 Nov 2009 20:54:54 +0000
Message-ID: <2faad3050911111254h426e24ccg93d2824f9e971521@mail.gmail.com>
References: <alpine.DEB.1.00.0911031047510.4985@pacific.mpi-cbg.de>
	 <200911111411.nABEBfox031023@ds9.cixit.se>
	 <2faad3050911110713y4e33c7d2h21ad42efe4fd70b3@mail.gmail.com>
	 <200911112135.25839.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?Q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Nov 11 21:55:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8KDZ-0007fM-BK
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 21:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758825AbZKKUyy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Nov 2009 15:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758816AbZKKUyx
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 15:54:53 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:43764 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756940AbZKKUyw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Nov 2009 15:54:52 -0500
Received: by fxm21 with SMTP id 21so1475358fxm.21
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 12:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6LIlBQFtxA4olF+r3GdIW8rmTlpw79k8teAhwlkrkLA=;
        b=qU8hslxVhQ5335tgsk8WgWTf6ufAdmyv/hkX7rcy8mWQuykcrWyAYrh4sak/Pvp8aO
         z2hjeEaK0VXjn5IHDncQhMrQ/iMdR12dRTzA30K6ORZG8Asf9rTyym4BKUpq4HLcetm3
         6RMsY5IGPyi6T9WwYK27OgtyRlAPEDoGlszVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JpHDHiu91u6g2oCR6x/2h6h99eLmECgdKzfEtDgmJencqQk8GyOtFcN/loK9//XAbw
         XGbuWVfIdSyGome8pmYT51CCbp1fFhjVv2XWeVyo+D1AUzDF6uTHLCEFVUSpUDN3KTK1
         5SflAXA6P/tiOLruEjV/bObDXGzpxKpyWANAM=
Received: by 10.216.87.144 with SMTP id y16mr620848wee.95.1257972894391; Wed, 
	11 Nov 2009 12:54:54 -0800 (PST)
In-Reply-To: <200911112135.25839.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132700>

2009/11/11 Thomas Rast <trast@student.ethz.ch>:
> Baz wrote:
>> 2009/11/11 Peter Krefting <peter@softwolves.pp.se>:
>> > =C2=A0ours::
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0This resolves any number of heads, but =
the result of the
>> > - =C2=A0 =C2=A0 =C2=A0 merge is always the current branch head. =C2=
=A0It is meant to
>> > + =C2=A0 =C2=A0 =C2=A0 merge is always the current branch head, di=
scarding any
>> > + =C2=A0 =C2=A0 =C2=A0 changes on the merged branch. =C2=A0It is m=
eant to
>>
>> I think part of the problem is that it is unclear what the "current
>> branch head" means when used in a rebase, and hence when this text i=
s
>> included in the help for git-rebase and git-pull.
> [...]
>> Perhaps something more in the way of an explicit warning?
>>
>> ours::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This resolves any number of heads,=
 but the result of the
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0merge is always the current branch=
 head, discarding any
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0changes on the merged branch. =C2=A0=
It is meant to
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0be used to supersede old developme=
nt history of side
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0branches. Note that when rebasing,=
 the branch you are
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rebasing onto is the "current bran=
ch head", and using this
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strategy will lose all of your cha=
nges - unlikely to be what
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0you wanted to do.
>
> I'd much rather see this explained in the description of the rebase
> -m/-s options since it (the swap) applies to all uses of 'git rebase
> -m'. =C2=A0Perhaps with an extra (but short) note in the "ours"
> description, like so:
>
> diff --git i/Documentation/git-rebase.txt w/Documentation/git-rebase.=
txt
> index 33e0ef1..181947c 100644
> --- i/Documentation/git-rebase.txt
> +++ w/Documentation/git-rebase.txt
> @@ -228,6 +228,10 @@ OPTIONS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Use merging strategies to rebase. =C2=A0Wh=
en the recursive (default) merge
> =C2=A0 =C2=A0 =C2=A0 =C2=A0strategy is used, this allows rebase to be=
 aware of renames on the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0upstream side.
> ++
> +Note that in a rebase merge (hence merge conflict), the sides are
> +swapped: "theirs" is the to-be-applied patch, and "ours" is the so-f=
ar
> +rebased series, starting with <upstream>.
>
> =C2=A0-s <strategy>::
> =C2=A0--strategy=3D<strategy>::
> diff --git i/Documentation/merge-strategies.txt w/Documentation/merge=
-strategies.txt
> index 4365b7e..0cae1be 100644
> --- i/Documentation/merge-strategies.txt
> +++ w/Documentation/merge-strategies.txt
> @@ -33,6 +33,9 @@ ours::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0merge is always the current branch head. =C2=
=A0It is meant to
> =C2=A0 =C2=A0 =C2=A0 =C2=A0be used to supersede old development histo=
ry of side
> =C2=A0 =C2=A0 =C2=A0 =C2=A0branches.
> ++
> +Because the sides in a rebase are swapped, using this strategy with
> +git-rebase is never a good idea.

Yes, this (with Peter's patch) makes the danger nice & clear.

Thanks!

-Baz

>
> =C2=A0subtree::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0This is a modified recursive strategy. Whe=
n merging trees A and
>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
>
