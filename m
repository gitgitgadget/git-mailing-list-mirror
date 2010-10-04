From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v4 3/3] git-remote-ext
Date: Mon, 4 Oct 2010 18:56:24 +0200
Message-ID: <AANLkTikenkhm0RJR0ovVyY9WLHtwWo+qQsyAhFDk=BO2@mail.gmail.com>
References: <1286190258-12724-1-git-send-email-ilari.liusvaara@elisanet.fi> <1286190258-12724-4-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Mon Oct 04 18:56:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2oLM-0005oC-9O
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 18:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755917Ab0JDQ4q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 12:56:46 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58993 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087Ab0JDQ4p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 12:56:45 -0400
Received: by yxp4 with SMTP id 4so1696570yxp.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 09:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=mBd8gRRClEONEdVvsuJMOjUCpfOAr/7us9ul4GgS3pg=;
        b=uXUaq/e0VoQZo/cV35sCi+O6BhXymewI6mM8rhVPxVyE4ck9MWzcsZM0tEVCiHeGg5
         SqTrkfn4E9emsBGb30E5jymVEp8dohmBtiwjfzpuEu80043V4TMdbvxKWrnjGEQ+dyx5
         27JIR8wVAmqD36vmtJLjXh66X8BVJcKmF63OQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=IdJ2Bgu9Gelfx3u/wYjZjC3fpCtkHnRZhIZ4uq5Vke7j7Qh6OJ0g9P/u1aJ+WA9I/1
         Cd2jN701qXv96SbL2O+Wdj4lXUy1RjOQJaQpavxkN0GYyySiVwPLlxAoPfbse33fqVic
         lEVBYWmbB4VN8Oj7el0ddbA3LiOVnLg4ZcKpg=
Received: by 10.101.187.7 with SMTP id o7mr6057689anp.116.1286211404236; Mon,
 04 Oct 2010 09:56:44 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Mon, 4 Oct 2010 09:56:24 -0700 (PDT)
In-Reply-To: <1286190258-12724-4-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158066>

Heya,

On Mon, Oct 4, 2010 at 13:04, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> +EXAMPLES:
> +---------
> +This remote helper is transparently used by git when
> +you use commands such as "git fetch <URL>", "git clone <URL>",
> +, "git push <URL>" or "git remote add nick <URL>", where <URL>
> +begins with `ext::`. =C2=A0Examples:

Much better! I was hesitant about this patch in earlier iterations
because I didn't understand it's purpose, but with these examples it
makes much more sense.


> +"ext::git-server-alias foo %G/repo %Vfoo"::
> + =C2=A0 =C2=A0 =C2=A0 Represents a repository with path /repo access=
ed using the
> + =C2=A0 =C2=A0 =C2=A0 helper program "git-server-alias foo". =C2=A0T=
he hostname for the
> + =C2=A0 =C2=A0 =C2=A0 remote server passed in the protocol stream wi=
ll be "foo"
> + =C2=A0 =C2=A0 =C2=A0 (this allows multiple virtual git servers to s=
hare a
> + =C2=A0 =C2=A0 =C2=A0 link-level address).

Can you explain better what the 'git-server-alias' helper is supposed t=
o do?

--=20
Cheers,

Sverre Rabbelier
