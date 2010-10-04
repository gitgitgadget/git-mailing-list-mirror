From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg-patch: use pretty_tree
Date: Tue, 5 Oct 2010 01:02:07 +0200
Message-ID: <AANLkTinOOzY2wk3Z89D2K8qDuHZkj65L56bHr79q2jpT@mail.gmail.com>
References: <1286216867-14701-1-git-send-email-bert.wesarg@googlemail.com>
	<1286222981-28358-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Tue Oct 05 01:02:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2u2y-0007R8-Ap
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 01:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757317Ab0JDXCJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 19:02:09 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63916 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756766Ab0JDXCI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 19:02:08 -0400
Received: by yxp4 with SMTP id 4so1819198yxp.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 16:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=m7FQZj6uvDgDMzxLNH816Uk/m/oCnBXM6uE4Du5un90=;
        b=ZXMJJz5xSQ0m/HcqonrYTDtMD546QfRV5c7iTqez58UD0ZBFsy9Z4FcHg8SPb4QEpb
         N2df2JGiJ3s40uxGkowR4kZT4E7u3ze0KlcnKqCSsxqvZigD6PjGayAxWJO4+cpQCySu
         qkmRnDYcSkSdOo32aKMb1/oG97VRdjV/o8GBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Z+fMG9IXIKUH9qW9oVzv+1ei8MdeZNx4GPAaST1qsQp1wudgfcnYXgpbueesvYNwRX
         sYp5vvAQoRuLJXX5x1RdleCMZQDZAPgh+/O8WXmr3s+WekFnkOGQYW/1OJ13NkAWOAP2
         0qTWPVQRNtAuAmR113kgF5mVELGVIxNwBmm7M=
Received: by 10.42.26.7 with SMTP id d7mr192188icc.90.1286233327567; Mon, 04
 Oct 2010 16:02:07 -0700 (PDT)
Received: by 10.231.171.149 with HTTP; Mon, 4 Oct 2010 16:02:07 -0700 (PDT)
In-Reply-To: <1286222981-28358-1-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158141>

On Mon, Oct 4, 2010 at 22:09, Bert Wesarg <bert.wesarg@googlemail.com> =
wrote:
> @@ -46,22 +44,32 @@ base_rev=3D"$(git rev-parse --short --verify "ref=
s/top-bases/$name" 2>/dev/null)"
>
> =C2=A0setup_pager
:
> +git diff-tree -p --stat -r $b_tree $t_tree

There is currently no color output and I don't know if a simple
--color suffice here.

Bert

>
> =C2=A0echo '-- '
> =C2=A0echo "tg: ($base_rev..) $name (depends on: $(cat_file "$topic:.=
topdeps" | paste -s -d' '))"
> --
> tg: (c9ca19b..) bw/tg-patch-pretty_tree (depends on: bw/files)
>
