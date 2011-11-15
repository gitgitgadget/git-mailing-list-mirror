From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/7] New sequencer workflow!
Date: Tue, 15 Nov 2011 21:42:48 +0530
Message-ID: <CALkWK0nPQm6Qnp2=0Bc+ntHU6sGSp2C+BFnEqTznws3mY9=E5g@mail.gmail.com>
References: <1321181181-23923-1-git-send-email-artagnon@gmail.com> <CABURp0qt+r09Uy_nfLd60pXiMMXgTOUB__XL-N=S7HaJa-oWoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 17:13:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQLdL-00015H-LU
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 17:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756692Ab1KOQNL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Nov 2011 11:13:11 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44303 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756486Ab1KOQNK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2011 11:13:10 -0500
Received: by wwe5 with SMTP id 5so6349332wwe.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 08:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=xGGAsFvvyStQT4Nx+vEIClQXH4GmL8vUsLZd3jMn9ys=;
        b=iMtiLYOwcxLo/xp9jAGxJRhypbP7ZfwkkYaIIPR/+LUqXVNdiXD/DhNApaJFZpD0I+
         HMUAj6Ye+RxEKf73cmiNrRfTFKjd5+VY2nOU3PrfJbQtp5SYm8WoMeB3fV756YO0/ISu
         MjNXVH+lJgYlnUDwKUao+8woU0iwhfPDoOQQY=
Received: by 10.227.207.205 with SMTP id fz13mr18743820wbb.0.1321373589161;
 Tue, 15 Nov 2011 08:13:09 -0800 (PST)
Received: by 10.216.19.209 with HTTP; Tue, 15 Nov 2011 08:12:48 -0800 (PST)
In-Reply-To: <CABURp0qt+r09Uy_nfLd60pXiMMXgTOUB__XL-N=S7HaJa-oWoA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185464>

Hi Phil,

Phil Hord wrote:
> I see that --reset was added to cherry-pick, revert and sequencer
> around the same time back in August. =C2=A0Shouldn't it be spelled
> "--abort" instead?

"reset" is actually different from "abort": it simply removes the
sequencer state without touching the worktree, index or HEAD.  We
decided that this would be a nice low-level command to implement
(since I find myself doing `rm -rf .git/rebase-todo` sometimes).
Sure, "abort" and a lot of other porcelain would be nice- we can
always implement them carefully later :)

Thanks.

-- Ram
