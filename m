From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 5/6] Refresh the main stg man page
Date: Mon, 6 Oct 2008 22:14:05 +0100
Message-ID: <b0943d9e0810061414ja87488k6aef65fec0856144@mail.gmail.com>
References: <20081005155450.19886.43748.stgit@yoghurt>
	 <20081005160157.19886.7137.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 23:15:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmxQF-0005gJ-E7
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 23:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118AbYJFVOK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Oct 2008 17:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752970AbYJFVOK
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 17:14:10 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:43626 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618AbYJFVOH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Oct 2008 17:14:07 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3151983rvb.1
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 14:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=6GTHHMdVXT0WosGxM8IvLt8IBXPSkl4nhHzKYFFGdU0=;
        b=PIUw3d1rkcmMv50ke1wO3Vp56ZZUB13grnuals4UVhr0cDnF2tp5WupqeM9CZ40N7C
         DPsvQ6O0OIDrmMObsS9RL5keuDrnLJHyAlCkd/Am3Ng43csMrXvYRhnzD3OzNyI6r34A
         Fs/12Un9UGhQQ/0vvtJ0vLKqLkVP3/LzARkwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vxiDVFYavGKsb+wRnVgYzSbrm8B3OTQcYvmNFL8SbCII5zeSvUyhvtU2fWufkvtFoj
         hJvtFX/T0rUdKke0Xq/rArME7dMrayy9GjUs/Onv4sXy7yjHJB/ahSKhxDD8EGkXyIlb
         5+btQ6FmfDx5EcCazX6J/Bd6ZdQgATbo3u/64=
Received: by 10.141.41.12 with SMTP id t12mr3355636rvj.282.1223327645704;
        Mon, 06 Oct 2008 14:14:05 -0700 (PDT)
Received: by 10.141.201.12 with HTTP; Mon, 6 Oct 2008 14:14:05 -0700 (PDT)
In-Reply-To: <20081005160157.19886.7137.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97630>

2008/10/5 Karl Hasselstr=F6m <kha@treskal.com>:
> Update the text to reflect what's happened in StGit in the last few
> releases. Also, consistently capitalize the names "Git" and "StGit".

I need to change the websites as well (BTW, I gave you admin rights on
the gna.org project page).

> --- a/Documentation/stg.txt
> +++ b/Documentation/stg.txt
[...]
> +  * After making changes to the worktree, you can incorporate the
> +    changes into an existing patch; this is called 'refreshing'. You
> +    may refresh any patch, not just the topmost one.

I wouldn't advertise the refreshing of "any" patch as it doesn't
always work (it actually fails in a lot of cases). Or at least we
could mention that there are some restrictions.

> +  * You can easily 'rebase' your patch stack on top of any other Git
> +    branch.

It might be better with something like "on top of a different Git
commit". The first thought when reading the above is that you can move
the patch stack to a different Git branch easily, which is not the
case (you need to cherry-pick the patches).

> +  * The patch stack is just some extra metadata attached to regular
> +    Git commits, so you can continue to use Git tools along with
> +    StGit.

Again, this is with some restrictions (or there aren't any with the
new infrastructure?).

> +  Tracking changes from a remote branch, while maintaining local
> +  modifications against that branch, possibly with the intent of
> +  sending some patches upstream. You can modify your patch stack as
> +  much as you want, and when your patches are finally accepted
> +  upstream, the permanent recorded Git history will contain just the
> +  final sequence of patches, and not the messy sequence of edits tha=
t
> +  produced them.

Maybe we could mention that the local history is also clean, not only
the upstream tree (though you mention it later in a different hunk).

--=20
Catalin
