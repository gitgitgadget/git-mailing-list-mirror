From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [GSoC 11] submodule improvements
Date: Sun, 8 May 2011 23:01:17 +0200
Message-ID: <20110508210117.GA24380@paksenarrion.iveqy.com>
References: <20110508120538.GA19074@paksenarrion.iveqy.com>
 <20110508151007.GA5066@jpl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
X-From: git-owner@vger.kernel.org Sun May 08 22:48:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJAuB-0005QV-OL
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 22:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947Ab1EHUsZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 16:48:25 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63311 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab1EHUsY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 16:48:24 -0400
Received: by ewy4 with SMTP id 4so1385323ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 13:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=PpKbBcSwtJ9PzI7cv+2PHUaUis90Ztw1cnuZtFr8RD0=;
        b=MYyY+aACjU5av+DD5ZFUsqeHGs1M3eTaNwLTSgJnvE2A9gg5b2f88cGDRnOra8cn4M
         XlxXkI8DB+dT7C44aJp+F455QeexmsgJiSInDYDT4VVmRkSGkm2pIsHeV6ZccrKYdzte
         2PTqWd5hquwbtlKW7xfYdEkn239fE2eQN2IIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ZxdqVs6MpQACORBYLKjQuz4yLMLbFj/LfpiKsHBacqLQqRnGL82Lht1xrG/MVrURUk
         XFZJBE6c4ZCdqbjyjb9D+IrCIjYWRH7tmxYY4l2m0Hml7HO+D0XkiB0DLa1Y4ZB/DiBu
         I3QkoCTZbsNOKe0I0QpAcCpue2isswXdk6rXY=
Received: by 10.14.9.18 with SMTP id 18mr3060808ees.236.1304887702565;
        Sun, 08 May 2011 13:48:22 -0700 (PDT)
Received: from paksenarrion.iveqy.com (h-185-240.A189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id y9sm2967093eeh.22.2011.05.08.13.48.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 May 2011 13:48:21 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1QJB6L-0006ML-Ez; Sun, 08 May 2011 23:01:17 +0200
Content-Disposition: inline
In-Reply-To: <20110508151007.GA5066@jpl.local>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173180>

On Sun, May 08, 2011 at 05:10:07PM +0200, Magnus B=E4ck wrote:
> On Sunday, May 08, 2011 at 14:05 CEST,
>      Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> > [1] My proposal:
> > http://www.google-melange.com/gsoc/proposal/review/google/gsoc2011/=
iveqy/1
>=20
> The proposal says
>=20
>     The submodule system is widely used, specially within the android
>     platform.
>=20
> which puzzles me somewhat. The Android platform uses the Repo tool
> to help out with multiple gits in the same source tree, and Repo
> currently isn't based on submodules. Work is however ongoing to
> switch Repo into using submodules instead (which would make the
> whole tool rather redundant). Are you thinking of that work, or
> is there a misunderstanding somewhere?

That senctence can certainly be misinterpret, specially without the
sentence after.

With "the submodule system" I didn't meant the git implementation of
submodules but rather the use of multiple git-repositories connected in
some way.=20

The git submodule-commands is one way to achieve this, there's many
others, for example (part of) repo.

My goal is that the git submodule system should be good enough to be th=
e
only submodule system needed to be used with git.

I'm sorry for being unclear in the proposal.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
