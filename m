From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Documentation/git-update-index.txt: Remove obsolete note
Date: Thu, 31 Mar 2011 19:15:43 +0700
Message-ID: <AANLkTik3nEE2mtpRVwuQxfoNZd8Ejpgc=T=GS_jEpXsB@mail.gmail.com>
References: <4D9329C5.3060809@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	torvalds@osdl.org, spearce@spearce.org, johannes.schindelin@gmx.de,
	peff@peff.net, nico@fluxnic.net, barkalow@iabervon.org,
	chriscool@tuxfamily.org, jrnieder@gmail.com, raa.lkml@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, Johannes Sixt <j.sixt@viscovery.net>
To: Jakob Pfender <jpfender@elegosoft.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 14:16:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5GnT-00029D-F1
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 14:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757375Ab1CaMQO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 08:16:14 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42605 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab1CaMQN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 08:16:13 -0400
Received: by pvg12 with SMTP id 12so389113pvg.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 05:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=/kxpzyi8UoK4v1jntNGevjN2CaTlFIBZjcMZOh3qds0=;
        b=UytMC96jrP8yGGBigxUPrJKQ5rlFSMPDCVv9qYCVGhPjfko+/pnvKEGiFDyjY4T+P/
         wUa4lnT1npA448vIxoHfO4pmHXs+dK0PJbQ/C5mcta5GsF9hjkX3ciCE1tVRDWekC0Ei
         O09Iiu5WAc1lBJckC/BQkxZ+iDtJDlEFnZWsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=IFPE6LYcpFq6qO/rNP9iobCMlwxoy0rYTDEGwWsCBx5fRvLFlqXXqHrNCaEAITzL8b
         O8EjmhT1/9JiPmuLsFkN3B+lmvVngiOZUw0B0hbO0hvxgFbp/RX5SUHiZPEG+LwrJ+BS
         ABycSE2lr/jiDqPw2IFz0yhty3SkGX818V1hQ=
Received: by 10.142.62.6 with SMTP id k6mr1929764wfa.100.1301573773130; Thu,
 31 Mar 2011 05:16:13 -0700 (PDT)
Received: by 10.68.42.234 with HTTP; Thu, 31 Mar 2011 05:15:43 -0700 (PDT)
In-Reply-To: <4D9329C5.3060809@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170479>

On Wed, Mar 30, 2011 at 8:01 PM, Jakob Pfender <jpfender@elegosoft.com>=
 wrote:
> 8dcf39 (Prevent bogus paths from being added to the index) introduced=
 a
> check for files beginning with '.', preventing path names such as
> `./file`, `dir/./file` or `dir/../file` from being added. This was
> reflected in the man page.
>
> d089eba (setup: sanitize absolute and funny paths in get_pathspec())
> removed this check without reflecting the change in the man page.

Sounds good.

> =C2=A0<file>::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Files to act on.
> - =C2=A0 =C2=A0 =C2=A0 Note that files beginning with '.' are discard=
ed. This includes
> - =C2=A0 =C2=A0 =C2=A0 `./file` and `dir/./file`. If you don't want t=
his, then use
> - =C2=A0 =C2=A0 =C2=A0 cleaner names.
> - =C2=A0 =C2=A0 =C2=A0 The same applies to directories ending '/' and=
 paths with '//'
> + =C2=A0 =C2=A0 =C2=A0 Note that directories ending in '/' and paths =
with '//' are
> + =C2=A0 =C2=A0 =C2=A0 discarded.

Do you mean the slashes or the directories are discarded? Directories
are not, I believe.
--=20
Duy
