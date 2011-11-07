From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/4] Documentation: unanchored gitignore patterns match basename
Date: Mon, 7 Nov 2011 17:18:15 +0700
Message-ID: <CACsJy8BLmanoWmUwT4uD+qosxbQYRCaACDFriLA6J7-jUztG6Q@mail.gmail.com>
References: <20111107080449.GA30448@elie.hsd1.il.comcast.net> <20111107080926.GC30486@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Blake <eblake@redhat.com>,
	Johannes Sixt <j6t@kdbg.org>, "Y.G." <yamomo1@hotmail.com>,
	Eli Barzilay <eli@barzilay.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 11:18:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNMI1-0008CT-Su
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 11:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286Ab1KGKSt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 05:18:49 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46495 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240Ab1KGKSs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 05:18:48 -0500
Received: by bke11 with SMTP id 11so3438313bke.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 02:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mnJi0XoKQ/wC9DeAzqr6wsMC7lZcOtv6ahDlj/GyRYc=;
        b=vn60KOzqnD7DQk9mCMR5Lep1HCMg+ufN1Qmtz+u61+S/a7avOf4mL/TgCxsbwlObI+
         tydQHBGYdyrIqcPLAUxyiZLnvebTxt8nbNZoK4t8sTj7nZOS3DoB3BVlce43+XqO/QEi
         J5m8UzHCNAQIQS8z10OJ38TmNiWN9UE7iBBCk=
Received: by 10.204.147.215 with SMTP id m23mr18340593bkv.84.1320661127157;
 Mon, 07 Nov 2011 02:18:47 -0800 (PST)
Received: by 10.205.134.1 with HTTP; Mon, 7 Nov 2011 02:18:15 -0800 (PST)
In-Reply-To: <20111107080926.GC30486@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184970>

2011/11/7 Jonathan Nieder <jrnieder@gmail.com>:
> The rule described by v1.7.1.1~31^2 (gitignore.5: Clarify matching
> rules, 2010-03-05) is just false: simple gitignore patterns without a
> slash like "foo" and "cscope*" have always matched files in all
> directories, not just the toplevel, and a question mark cannot be use=
d
> to match the slash separating path components.
>
> For example:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0foo/ - matches directories named "foo" thr=
oughout the tree
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Documentation?foo - does not match Documen=
tation/foo
>
> Reported-by: Y.G. <yamomo1@hotmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Acked-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
--=20
Duy
