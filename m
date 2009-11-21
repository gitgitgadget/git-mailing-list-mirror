From: bill lam <cbill.lam@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.15
Date: Sat, 21 Nov 2009 11:58:58 +0800
Message-ID: <20091121035858.GC3919@debian.b2j>
References: <20091120133117.GA26917@diku.dk>
 <20091120135004.GA3919@debian.b2j>
 <2c6b72b30911200755l16b306cey16efb42fe9ba27da@mail.gmail.com>
 <20091120162543.GB3919@debian.b2j>
 <2c6b72b30911201829i52ffa022qff827bdf317ad447@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sat Nov 21 04:59:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBh7w-0008QT-DT
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 04:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbZKUD67 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Nov 2009 22:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751967AbZKUD67
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 22:58:59 -0500
Received: from mail-px0-f204.google.com ([209.85.216.204]:57061 "EHLO
	mail-px0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbZKUD66 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 22:58:58 -0500
Received: by pxi42 with SMTP id 42so2189728pxi.5
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 19:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=NBeZ/NQ7G9ZcuKadfo6elDHmnebUT1RJcZwfDzR0JDM=;
        b=AmsxqXiXnBR9ZlM1G+Jem99D6rybBwdGqYr80g6WOlHWvxVu9vjAes9dHvH2YgZp6t
         XoRXcA2+G0Jg0sRxEfYKhX2/18GScnfIFSuYMbWQ2Rb0KJzcI36aMdxTINGMjmHB/rrP
         l5/zZwYl6TsTX5RGuBrdNfR9Epx2H0uCI9ZrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=n9pKPF69NdJZ38WtLUN4WFwu/7hXpuduJ1JO40qBXVrYWFJ9dAngXV4K9nK/t+dDeT
         WohEI1PdFT4EPT1crkAoEmT6LWsHSCQ2H/ToUpWIDvyqvAayNrsuUPPhuEU/bVz6NU49
         ewu6ACOm9i3nIBS5RKoEMQAL2v/u+0Ce5UtxU=
Received: by 10.114.3.15 with SMTP id 15mr2826601wac.181.1258775942993;
        Fri, 20 Nov 2009 19:59:02 -0800 (PST)
Received: from localhost (n219077015140.netvigator.com [219.77.15.140])
        by mx.google.com with ESMTPS id 23sm1315555pzk.8.2009.11.20.19.59.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Nov 2009 19:59:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2c6b72b30911201829i52ffa022qff827bdf317ad447@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133390>

On Fri, 20 Nov 2009, Jonas Fonseca wrote:
> On Fri, Nov 20, 2009 at 11:25, bill lam <cbill.lam@gmail.com> wrote:
> > On Fri, 20 Nov 2009, Jonas Fonseca wrote:
> >> install-release-doc-man:
> >> =A0 =A0 =A0 =A0for doc in $(MANDOC); do \
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0git checkout origin/release $$doc; =
\
> >> =A0 =A0 =A0 =A0done
> >> =A0 =A0 =A0 =A0$(MAKE) install-doc-man
> >
> > Thanks it works. =A0Could you also commit this to git?
>=20
> Done, but using git-checkout-index ...
the line
  git read-tree release
raised error perhaps I didn't checkout a branch for it, replacing it
with=20
   git read-tree origin/relase
or
   git read-tree remotes/origin/relase

seems working.

Another question, while it can open a file with editor in tree-view, I
cannot find in tigmanual how to directly save a file.  Any idea?

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
