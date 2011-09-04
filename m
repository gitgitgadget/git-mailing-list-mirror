From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Lost association between TAGS and COMMITs when rebased a git(1) repository
Date: Sun, 04 Sep 2011 08:39:24 -0700 (PDT)
Message-ID: <m362l848sw.fsf@localhost.localdomain>
References: <FF0364F3D5244CA4987EDDCFE7244BF3@urbanjsPC>
	<CACx-yZ3tav1sJnLtJOn_YugQOsM9ERi7Cc7SowunyobxxX5YdA@mail.gmail.com>
	<CAMOZ1BtxZ5C+pH_eEBu8=oqOyY6JkP8wiFmauyqcSOeijvgA+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: knittl <knittl89@googlemail.com>,
	"John S. Urban" <urbanjost@comcast.net>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 04 17:39:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0EnG-0002w4-DD
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 17:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573Ab1IDPja convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Sep 2011 11:39:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45165 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457Ab1IDPj2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Sep 2011 11:39:28 -0400
Received: by fxh19 with SMTP id 19so3133323fxh.19
        for <git@vger.kernel.org>; Sun, 04 Sep 2011 08:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=FZeSsJIpDbJw/iMleDi/m0Kl4O/ge1Vdw66pmvZUZV0=;
        b=OLBxB3AhCozhrwFm6dQBJ5g9X+GWC2szGbUIxxO4Xw7vadMaReMdj+4jStwsZ6cd24
         kCx2z1psQ2dIlx+rSNXgoLQvRT+5yfdZCsIHy/JIE4jwPe7vNHfW85fGHzl9lmSEQgEF
         Le+dnxek6yqkAV2mhNN30T2et9vfxy4r7Kbyk=
Received: by 10.223.23.141 with SMTP id r13mr365753fab.74.1315150767553;
        Sun, 04 Sep 2011 08:39:27 -0700 (PDT)
Received: from localhost.localdomain (abwp177.neoplus.adsl.tpnet.pl [83.8.239.177])
        by mx.google.com with ESMTPS id p18sm3012960fak.6.2011.09.04.08.39.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Sep 2011 08:39:24 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p84FckjW020925;
	Sun, 4 Sep 2011 17:38:56 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p84FcOTf020915;
	Sun, 4 Sep 2011 17:38:24 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAMOZ1BtxZ5C+pH_eEBu8=oqOyY6JkP8wiFmauyqcSOeijvgA+g@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180686>

Michael Witten <mfwitten@gmail.com> writes:
> On Sun, Sep 4, 2011 at 14:30, knittl <knittl89@googlemail.com> wrote:
>=20
> > "Rebase" takes commits and creates new commits from those. The new
> > commits are not the same as the old, although they might have
> > associated the same tree or changeset.
>=20
> According to `git help glossary':
>=20
>   changeset
>       BitKeeper/cvsps speak for "commit".
>       Since git does not store changes, but states,
>       it really does not make sense to use the term
>       "changesets" with git.
>=20
> Git's erroneous nomenclature is bad enough as it is, so please try
> not to explain things using such spurious terminology.

Actually "changeset", at least in the original meaning as the set of
changes (the difference between two snapshots), is perfectly in place
here: rebase operation preserves changes which means that it copies
changesets, at least if there are no conflicts.

--=20
Jakub Nar=EAbski
