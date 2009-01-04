From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-branch --print-current
Date: Sun, 04 Jan 2009 13:48:03 -0800 (PST)
Message-ID: <m3bpumbv5c.fsf@localhost.localdomain>
References: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu>
	<1a69a9d80901040021i1dae2c6j7337cf57eed6476a@mail.gmail.com>
	<quack.20090104T0440.lthbpun1bxo@roar.cs.berkeley.edu>
	<20090104180208.GA12298@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl Chen <quarl@cs.berkeley.edu>,
	Arnaud Lacombe <lacombar@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: =?iso-8859-15?q?Adeodato_Sim=F3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Sun Jan 04 22:50:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJarX-0000s9-QS
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 22:50:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbZADVsN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jan 2009 16:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755532AbZADVsM
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 16:48:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:10050 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbZADVsH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jan 2009 16:48:07 -0500
Received: by nf-out-0910.google.com with SMTP id d3so868372nfc.21
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 13:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=tqbO9mb/5xk3atTygyzKLskm4OiaLiP7kYYQoT2Iiig=;
        b=DqsWdx4bqoMz1E3l5WxhluI7Y5auvGUfcT55P+wbvwFrqKDqdHSsEVpdudoSDhiMlh
         Wg4pQhj88ieJU3VSmy8FSUAdd2mfIHN17K25py3aZ2NPRxZRBLJzgH6GHrmegvHDW7Qf
         lvfcvuy3m2MfsdDDlpbBdXyzQrfxYGSfYXbk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=bpQQP9mqwy9nCbOBkydfVokzJy+NhMu71P3C59Am1+9eLyhrqkg8e9XG2hgzUnmEe1
         Yh/1NpfgpBgsVCoCst+06eHiKu3nnwUUqLZyX+4aTkx8V1HaHGYQJMGbXcuGDtEEKUwV
         AnZpami39KPAbaTIDHYJLUtz+6iK2swC2Dgzw=
Received: by 10.210.61.8 with SMTP id j8mr23661377eba.45.1231105684761;
        Sun, 04 Jan 2009 13:48:04 -0800 (PST)
Received: from localhost.localdomain (abrz203.neoplus.adsl.tpnet.pl [83.8.119.203])
        by mx.google.com with ESMTPS id 28sm4000864eyg.14.2009.01.04.13.48.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Jan 2009 13:48:03 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n04Lm3Fn032056;
	Sun, 4 Jan 2009 22:48:03 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n04Lm0EZ032053;
	Sun, 4 Jan 2009 22:48:00 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090104180208.GA12298@chistera.yi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104543>

Adeodato Sim=F3 <dato@net.com.org.es> writes:
> * Karl Chen [Sun, 04 Jan 2009 04:40:51 -0800]:
>=20
> >     Arnaud> $ git branch | awk '/^\*/ {print $2}'
>=20
> > Yet another addition to the list of ways to pipeline it, this one
> > probably the shortest :)
>=20
> Heh, if we're playing golf:
>=20
>               $ git branch | sed -n 's/^\* //p'

Even if you want to reimplement __git_ps1 provided with bash
completion in completion/git-completion.bash instead of reusing it,
you still have to deal with many situations: not being in git
repository, being on detached HEAD, being in intermediate state
(during git-am, git-rebase, git-bisect etc.), etc.  Additionally you
would probably want name of git repository and relative path inside
git repository in prompt.

Therefore you need to use script anyway. And for scripting you should
use plumbing (which output format shouldn't change) and not porcelain
git-branch (which output might change, for example having '-v' on by
default, or something; and you might have color.ui set to true by
mistake and have to deal with color codes). And then you don't need
sed nor awk: POSIX shell features would be enough:

  BR=3D$(git symbolic-ref HEAD 2>/dev/null)
  BR=3D${BR#refs/heads/}
  BR=3D${BR:-HEAD} # one of possibilities to show detached HEAD / no br=
anch

--=20
Jakub Narebski
Poland
ShadeHawk on #git
