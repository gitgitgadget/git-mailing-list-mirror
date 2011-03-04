From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH] Documentation: fix a typo in git-apply.txt
Date: Fri, 4 Mar 2011 11:43:14 +0100
Message-ID: <20110304114314.2bc9ce26@mkiedrowicz>
References: <1299144510-8143-1-git-send-email-michal.kiedrowicz@gmail.com>
	<7vlj0v942a.fsf@alter.siamese.dyndns.org>
	<20110304085622.6faa0c93@mkiedrowicz>
	<4D70A345.1010706@nextest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Raible <raible@nextest.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 11:43:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvSTk-0005gA-3t
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 11:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759274Ab1CDKnT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2011 05:43:19 -0500
Received: from mail-fx0-f66.google.com ([209.85.161.66]:62472 "EHLO
	mail-fx0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab1CDKnS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2011 05:43:18 -0500
Received: by fxm18 with SMTP id 18so363500fxm.1
        for <git@vger.kernel.org>; Fri, 04 Mar 2011 02:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:in-reply-to
         :references:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=btdEjP527Ky2bs3L685mng/9vxkX0IuFqs+celZm5Dw=;
        b=xSiNlnyYsWdwaN1QQ3UceGypjUiKUea+YMpP1BXp4nlZ9bq5KPIA+n4XMLNqt6ISpF
         DbxxQlllkSHBnJ9dD6fR4cyPYzqnEpD4AIs0Wde3K1Yr7Vu9bP7kjFejEFJWPVGNzmGz
         dk9+SH3A81NdCxebpdO9NiSU2+uRbJtCtnDj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=Z1WDn4RrYec3KK87RkJiku+Kd5ZAw6Y9WsECDCxxvmwETdy86Lm9MYSCgLl/4gNXpE
         CPbaUio+C+BwfOboYfgVE1YmqMIQAiOshKT2s7rg4DQPBJ3xqCoFqAwEjBHfi2m/MxG8
         OuzmuF0D3U3YJUIGzCNe6sWdvDzNIxc40H1/k=
Received: by 10.223.102.13 with SMTP id e13mr616926fao.56.1299235396775;
        Fri, 04 Mar 2011 02:43:16 -0800 (PST)
Received: from mkiedrowicz (pc10.ivo.park.gdynia.pl [153.19.128.10])
        by mx.google.com with ESMTPS id z1sm1067382fau.45.2011.03.04.02.43.16
        (version=SSLv3 cipher=OTHER);
        Fri, 04 Mar 2011 02:43:16 -0800 (PST)
In-Reply-To: <4D70A345.1010706@nextest.com>
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168435>

On 04.03.2011 00:31:01 -0800 Eric Raible <raible@nextest.com> wrote:

> On 11:59 AM, Michal Kiedrowicz wrote:
> > On 03.03.2011 15:28:45 -0800 Junio C Hamano <gitster@pobox.com>
> > wrote:
> >=20
> >> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
> >>
> >>> git-apply accepts the --cached option, not --cache.
> >>>
> >>> Signed-off-by: Micha=3DC5=3D82 Kiedrowicz
> >>> <michal.kiedrowicz@gmail.com> ---
> >>>  Documentation/git-apply.txt |    2 +-
> >>>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>>
> >>> diff --git Documentation/git-apply.txt Documentation/git-apply.tx=
t
> >>> index 881652f..2dcfc09 100644
> >>> --- Documentation/git-apply.txt
> >>> +++ Documentation/git-apply.txt
> >>
> >> What kind of crap is this?
> >>
> >> We really should make it much harder for people to use funky
> >> src/dst prefix when generating patches.
> >=20
> > It's called diff.noprefix=3Dtrue :). I use it @work to easily
> > copy/paste paths from git-diff output. I guess I should somehow
> > make git.git config ignore global settings.
>=20
> The local config will override the global settings automatically.
>=20
> 	git config diff.noprefix false
>=20
> Should do it.
>=20

Yeah, I know, that's what I did eventually. I meant something like

	git config core.ignoreGlobalConfig true

to protect from all changes set in ~/.gitconfig.
