From: David <bouncingcats@gmail.com>
Subject: Re: git rebase --interactive commits order
Date: Mon, 9 May 2011 20:10:23 +1000
Message-ID: <BANLkTi=PyBfMxCbWNfJEXEP6-MphdeE+_Q@mail.gmail.com>
References: <BANLkTimX2tupqV464+Re8u06TT+qRmqPuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 12:10:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJNQ9-0001Mf-D1
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 12:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668Ab1EIKKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 06:10:25 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38055 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab1EIKKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 06:10:25 -0400
Received: by bwz15 with SMTP id 15so3842332bwz.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 03:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WtPdMxBjb50cFzwR8EUSIcX7CoxEgdw3JWSz4y0E6mQ=;
        b=jV90h2YP+Oku9OXc2PaIJEPFxc6YS2dIYvpiekEDZGdd31hPWmbo41kl6WYl9eWZFs
         Cbp9itRq939HRpchdCyk2tIOBzu/UpKKpUrgjVsNI6Qb7pmH623hD8MJ89Xho8c+HOqx
         K08hNf8tIWIZZr9O057hFjzK3CIUIaX0PFwTc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ZmA5qAZ/v3gvMqmAwjThPqH7fkcoO3TCB59lJOi0h7OtPV2A2qdGohjrs1CSbHlwpC
         5ndPtfY8771TE+0g3b1gvYj2rUVHUhMdyHvFRvb8Ex5xLdo9TFA8pWzt+KFldC7ri6rU
         AuG/tvXxSnBqaz6hhuSN+r+WW5b3Ehwodhy+c=
Received: by 10.204.19.65 with SMTP id z1mr478740bka.202.1304935823486; Mon,
 09 May 2011 03:10:23 -0700 (PDT)
Received: by 10.204.14.137 with HTTP; Mon, 9 May 2011 03:10:23 -0700 (PDT)
In-Reply-To: <BANLkTimX2tupqV464+Re8u06TT+qRmqPuw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173215>

On 9 May 2011 19:30, Philippe Vaucher <philippe.vaucher@gmail.com> wrote:
>
> Is there an option or would it be possible to make it so that `git
> rebase -i` lists commits in reverse chronological order, like it does
> for `git log` ?
>
> Almost every git commands I use lists events in reverse chronological
> order (reflog, log, gitk) and then you do an interactive rebase and it
> always takes me a second or two to switch mindsets and start reading
> them in chronological order. I asked around and I'm far from being the
> only one who think this is counter-intuitive. I understand there's an
> implementation simplicity reason for it to be that way, and also that
> it is somewhat logical to show the commits to be applied in order, but
> as your mind is trained to read them in reverse chronological order
> with the other commands I'd find it more consistant if rebase also
> followed that.

I agree. I use "rebase -i" a lot, often simultaneously viewing with
gitk, and  I find my work rate is reduced because it is anti-intuitive
to have different tools showing the same information in the opposite
order, especially when squashing commits. I find I have to do a mental
double check before every such operation. Like the OP, I would like to
see "rebase -i" gain the capability to display commits in the same
onscreen-ordering as the other command tools.
