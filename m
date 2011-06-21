From: Kasra Khosoussi <kasra.mail@gmail.com>
Subject: Re: corrupted Git repository
Date: Tue, 21 Jun 2011 18:56:55 +0430
Message-ID: <BANLkTi=6jt7Z3fvK++ontW=F9AJbmEr9Qg@mail.gmail.com>
References: <BANLkTi=A=DpyfNwEeSd6N6ibCsA5qh_NPQ@mail.gmail.com>
	<4E005404.5010901@drmicha.warpmail.net>
	<BANLkTi=WVTGcGkUXjkuPYcxhMY0a5KPB7g@mail.gmail.com>
	<4E006682.80101@drmicha.warpmail.net>
	<BANLkTi=GdEfXnAGa6V-33wqX2C-2x-9JQQ@mail.gmail.com>
	<4E00A0E1.8000006@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jun 21 16:27:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ1uv-0000Be-Rh
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 16:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756716Ab1FUO04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 10:26:56 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55503 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756431Ab1FUO04 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 10:26:56 -0400
Received: by pwj7 with SMTP id 7so1033007pwj.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 07:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=K2uqaQhTQ0cKeb2Xqbr+xOch3XjMk2AWQ0Kq0uKErZY=;
        b=kJYl/WxRub2Y9ROEogOv9aVuom/D0XAr0pEb281/TeKKwjxdNR7HvyTNp4aVq6rSHY
         Y1hgey6rxkV9BOWR809f1U+q6EwEml9FEv9fAMLmMNj5dc9dvceszRyTnCWAqIvkhOiB
         hzfBOG5AUk5nyLCndxaj5fHxiBm0q2ZWiUcZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=DqiJk06otKvo9E6m5y5xT6C2vgqIrdBUuVpQiyy8ZUw1sf0MR/j6ykjzHrPljCYcDU
         1BKVZgxcqr0cDtbT6DPblMc8F61TEv6HLZ/4czjoqDPL8pzmKJ4JUzjpjckt8X3XvOzl
         803yecWy/yntVm+JCWoBVQirG3RnPuCMyAxPs=
Received: by 10.68.9.231 with SMTP id d7mr3134144pbb.111.1308666415611; Tue,
 21 Jun 2011 07:26:55 -0700 (PDT)
Received: by 10.68.55.132 with HTTP; Tue, 21 Jun 2011 07:26:55 -0700 (PDT)
In-Reply-To: <4E00A0E1.8000006@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176155>

Good question! Actually I have no idea!

It was fine yesterday. I had to leave home so I just shutdown my
netbook (I just issued the command and closed the lid). Files were
open in my editor but I'm sure that there were no Git processes
running at the time. The battery was empty this morning, so my best
guess is that the halt operation was somehow failed, but I think it
can not explain the corruption.

Any idea?

-Kasra

On Tue, Jun 21, 2011 at 6:17 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 6/21/2011 12:10, schrieb Kasra Khosoussi:
>> Everything seems fine now
>
> But it would still be good to know how the corruption could have happened.
> Do you have any clues?
>
> Disk full?
> Ctrl-C in the middle of a git operation?
> Some cron script interference (unlikely)?
> Permission problems (unlikely)?
> Networking problems (only if the repository is on a network mount)?
> Something else?
>
> -- Hannes
>
