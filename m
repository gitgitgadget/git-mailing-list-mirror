From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: More Beginning Git Questions
Date: Sat, 24 Sep 2011 14:10:07 -0700 (PDT)
Message-ID: <m362khr6kh.fsf@localhost.localdomain>
References: <4E7C9AAD.7060209@gmail.com>
	<m3ipojqhpm.fsf@localhost.localdomain> <4E7CCCA0.50909@gmail.com>
	<14gm3o851q0ad.1uoossmxgfyit.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tactical <a5158017@nepwk.com>
X-From: git-owner@vger.kernel.org Sat Sep 24 23:10:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7ZUU-0003U8-5u
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 23:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350Ab1IXVKL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Sep 2011 17:10:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64824 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113Ab1IXVKJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Sep 2011 17:10:09 -0400
Received: by fxe4 with SMTP id 4so4862455fxe.19
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 14:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=RkBe+hJlDxiqg8RBiiljJVGzGGpYNzkLzxEq9sRyy+Y=;
        b=j8gsFy6srrC8o0WZ5FgqOJZyMa67JrL80YPBXgD9OjsJaOsMYsL5oZtIwqQOxDB10j
         MksTkPfKoPvn6Op7G+1DNSgSifIBEUhc3sukR1UeP/Rprl83/g8rHih6SutmpjChTFbO
         iX+r7ILb0owWIYNpKk1CO4oYTtsjh/slCmUaU=
Received: by 10.223.59.136 with SMTP id l8mr7475981fah.54.1316898608590;
        Sat, 24 Sep 2011 14:10:08 -0700 (PDT)
Received: from localhost.localdomain (abvl230.neoplus.adsl.tpnet.pl. [83.8.209.230])
        by mx.google.com with ESMTPS id u6sm15153794faf.3.2011.09.24.14.10.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Sep 2011 14:10:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8OL9ZtW011711;
	Sat, 24 Sep 2011 23:09:46 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8OL9J9g011707;
	Sat, 24 Sep 2011 23:09:19 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <14gm3o851q0ad.1uoossmxgfyit.dlg@40tude.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182043>

tactical <a5158017@nepwk.com> writes:
> Jon Forrest wrote:
> > Jakub Narebski wrote:
=20
> > > Generally Alice shouldn't have uncommitted changes when doing
> > > "git pull".
> >=20
> > That's what the tutorial said but I'm trying to understand
> > what happens if she does have uncommitted changes. I'm
> > trying to understand the total picture.
>=20
> Mercurial allows this, and it's a very powerful feature.

You *do* realize thet "hg pull" is "git fetch", don't you?

>  After reading=20
> this thread, I could not believe Git didn't pulling with local change=
s, and=20
> so I tried it, and also asked on IRC -- and it seems that Git really=20
> doesn't.
>=20
> If this is an important part of your workflow (as it is mine), I'd=20
> recommend using Mercurial if possible.
>=20

So the question is if mercurial allows _merging_ with local
changes... and from the thread it looks like git dies allow it, as
long as changes are isolated from changes brought by merge.

Anyway merging with local changes is an easy way to f**k up your
changes in unrecoverable way, IMVHO...

--=20
Jakub Nar=EAbski
