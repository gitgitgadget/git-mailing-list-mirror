From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] For Real - Fixed pluralization in diff reports
Date: Mon, 1 Aug 2011 11:50:20 +0700
Message-ID: <CACsJy8CdfRCssfrMVOjRn2a_=vZPLyG_uEd4fS2WxzQXKZGn3w@mail.gmail.com>
References: <4E362F8E.1050105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jon Forrest <nobozo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 06:50:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnkSu-00028I-8H
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 06:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401Ab1HAEuw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 00:50:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35524 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334Ab1HAEuv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2011 00:50:51 -0400
Received: by fxh19 with SMTP id 19so4170590fxh.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 21:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=N9Q1PlHhR7EjVBMm3tg2/xvqfrc9WiSMIjLbLednFms=;
        b=OX/ivDzM6U/qDOqjxRYMm/Xj50WTZ8gDwHmI1cSIXzFNpC2KTtGTBmRjA9xM17xKv9
         i3sU5B9MLVXiI51kPKr50CJiUOnZQTPSzq3tbagHGm4Q7XMnuHHpvleGB0kjn0LVEIc9
         nFRbrrueFBX3rAKkjndV3PXCz+MqiLbNmq6ks=
Received: by 10.204.148.89 with SMTP id o25mr1027962bkv.261.1312174250155;
 Sun, 31 Jul 2011 21:50:50 -0700 (PDT)
Received: by 10.204.52.77 with HTTP; Sun, 31 Jul 2011 21:50:20 -0700 (PDT)
In-Reply-To: <4E362F8E.1050105@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178317>

On Mon, Aug 1, 2011 at 11:46 AM, Jon Forrest <nobozo@gmail.com> wrote:
> [I must have accidentally removed the "s" in "deletions" before.
> I just rebuilt everything and remade the patch. All looks well
> this time. This is my first submitted patch to anything
> so my fingers are still learning.]
>
> I got irritated by the
>
> =C2=A0 =C2=A0 1 files changed, 0 insertions(+), 1 deletions(-)
>
> lack of pluralization so I fixed it. Now it says
>
> =C2=A0 =C2=A0 1 file changed, 0 insertions(+), 1 deletion(-)
>
> and so forth.

Are you sure this does not break any tests? t3508.2 for example
hardcodes "1 insertions" and does textual compare. I have not run the
tests but I suspect it will fail.
--=20
Duy
