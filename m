From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: how do I resolve this merge manually + mergetool bug
Date: Tue, 24 Feb 2009 01:52:59 -0500
Message-ID: <81bfc67a0902232252h56570308r22872854af8da54a@mail.gmail.com>
References: <81bfc67a0902232204y7a1e9a91x6cbf751319664734@mail.gmail.com>
	 <7vbpssmjm9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 07:54:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbrBX-0001r2-8M
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 07:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbZBXGxE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 01:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753844AbZBXGxD
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 01:53:03 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:25247 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbZBXGxB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 01:53:01 -0500
Received: by qw-out-2122.google.com with SMTP id 5so1665715qwi.37
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 22:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uokVe5TePmFYb3+BZ/R0fdJ9FHXy9i/cThAmpgkZm4U=;
        b=hmVa2Wzcp4mTQdvpkU3v8lFIsnyg7FTCTKxBdwcZl/2yAQEFLRQr5B6GLmj1xftgYE
         FofOM8Hqi0LCvtCy55kIET+POMsflcE+duFkrI9H2pY6G5aVNZrf2GPx9hxQc/DbmC2P
         t4ddZq/nIaX+R976MAYppQFOpNo/jw5cpX+lU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QRtXs4rxRCH8ElhA6bJdgWJynHgbb2/YnqN/Si+xnZNcQKM7cL8x3gOTD+nZmXIJaJ
         yYg2p0dU2e5TOGev0xGpueSEvCdgEnQWTawfCuorDrha/dAHXvTcYghXgohG+V4YMPsK
         Mwy6VELY/K3ojrakABoWbfiR2zlnzel8eGGdg=
Received: by 10.229.96.6 with SMTP id f6mr1737430qcn.81.1235458379112; Mon, 23 
	Feb 2009 22:52:59 -0800 (PST)
In-Reply-To: <7vbpssmjm9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111224>

On Tue, Feb 24, 2009 at 1:31 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> =C2=A0 =C2=A0$ git cat-file blob :1:profiles/package.mask >original
> =C2=A0 =C2=A0$ git cat-file blob :3:profiles/package.mask >theirs
> =C2=A0 =C2=A0$ git cat-file blob profiles/package.mask/frotz >mine
> =C2=A0 =C2=A0$ git merge-file mine original theirs
> =C2=A0 =C2=A0$ diff -u profiles/package.mask/frotz mine ;# eyeball th=
e merge result
> =C2=A0 =C2=A0$ cat mine >profiles/package.mask/frotz

so do all this if theirs is different? (at the moment I know it isn't)

> and then finally conclude the merge with:
>
> =C2=A0 =C2=A0$ git rm profiles/package.mask
> =C2=A0 =C2=A0$ git add profiles/package.mask/frotz

git rm profiles/package.mask

rm 'profiles/package.mask'
rm 'profiles/package.mask'
rm 'profiles/package.mask/gentoo.org'
rm 'profiles/package.mask/java-overlay'
rm 'profiles/package.mask/perl-experimental'
rm 'profiles/package.mask/regen2.org'
rm 'profiles/package.mask/sunrise'
fatal: git rm: profiles/package.mask: Is a directory

and git status still shows..

#       unmerged:   profiles/package.mask

--=20
Caleb Cushing

http://xenoterracide.blogspot.com
